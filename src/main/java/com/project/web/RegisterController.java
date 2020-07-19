package com.project.web;

import com.project.domain.AjaxRes;
import com.project.domain.Student;
import com.project.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Request;

@Controller
public class RegisterController {

    @Autowired
    private RegisterService registerService;


    @RequestMapping("/register")
    @ResponseBody
    public AjaxRes register(Student student, HttpServletRequest request, HttpServletResponse response){
        System.out.println(student);
        AjaxRes ajaxRes=new AjaxRes();
        boolean reg=false;
        try{
            reg=registerService.InsertStu(student);
            if(reg){
                ajaxRes.setSuccess(true);
            }else{
                ajaxRes.setSuccess(false);
            }

        }catch (Exception e){
            e.printStackTrace();
            ajaxRes.setSuccess(false);
        }
        System.out.println(ajaxRes);
        return ajaxRes;
    }
}
