package com.project.web.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.domain.AjaxRes;
import com.project.domain.Student;
import com.project.service.StudentService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class MyFilter extends FormAuthenticationFilter {

    @Autowired
    private StudentService studentService;



    /*当认证成功是调用*/
    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {

        System.out.println("认证成功");
        //获取认证
        String userid=(String) token.getPrincipal();

        AjaxRes ajaxRes=new AjaxRes();
        //通过ID获取学生信息；
        Student student=studentService.getStudentWithSid(userid);


       /* try{
            HttpServletRequest req=(HttpServletRequest)request;
            HttpSession session=req.getSession();
            System.out.println("------------"+employee+"------------");
            session.setAttribute("dep_id",employee.getDepartment().getId());
            session.setAttribute("admin",employee.getAdmin());

            *//*判断是否为员工*//*
            List<String> roles=employeeService.getAllPromissionByEid(employee.getId());
            if(roles.contains("index")&&roles.size()<=1){

                session.setAttribute("emp","员工");

                ajaxRes.setEmployee(true);
              //System.out.println("+++++++++++++++++++"+roles+"----------------------");
            }else{
                session.setAttribute("manager",employee);
            }
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            *//*处理日期*//*
            Calendar cal=Calendar.getInstance();
            cal.setTime(employee.getInputtime());
            cal.add(Calendar.DATE,-1);//天数上加1
            String format=sdf.format(employee.getInputtime());
            employee.setTime(format);
            session.setAttribute("employee",employee);

        }catch (Exception e){
            e.printStackTrace();
        }
*/
        /*响应给浏览器*/
        response.setCharacterEncoding("utf-8");
        System.out.println("认证成功");

        ajaxRes.setSuccess(true);
        ajaxRes.setMsg("登录成功");
        /*把对象转成json形式的字符串*/
        String jsonString=new ObjectMapper().writeValueAsString(ajaxRes);
        response.getWriter().print(jsonString);

        return false;
    }

    /*当认证失败时调用*/
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        System.out.println("认证失败");
        response.setCharacterEncoding("utf-8");
        AjaxRes ajaxRes=new AjaxRes();
        ajaxRes.setSuccess(false);

        if(e!=null){
            /*获取异常名称*/
            String name=e.getClass().getName();
            if(name.equals((UnknownAccountException.class.getName()))){
                /*没有账号*/
                ajaxRes.setMsg("账号不正确");
            }else if(name.equals(IncorrectCredentialsException.class.getName())){
                /*密码错误*/
                ajaxRes.setMsg("密码不正确");
            }else{
                /*未知异常*/
                e.printStackTrace();
                ajaxRes.setMsg("未知错误");
                ajaxRes.setSuccess(true);

            }
        }

        try {
            String jsonString=new ObjectMapper().writeValueAsString(ajaxRes);
            response.getWriter().print(jsonString);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        /*响应给浏览器*/
        System.out.println("认证失败");
        return false;
    }
}
