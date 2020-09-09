package com.project.web.realm;

import com.project.domain.Student;
import com.project.service.StudentService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

public class StudentRealm extends AuthorizingRealm {
    @Autowired
    private StudentService studentService;

    /*授权
     *web doGetAuthorizationInfo什么时候调用
     * 1,发现访问路径对应的方法上面，有授权的注解，就会调用这个方法
     * 2，页面当中有授权的标签也会调用这个方法
     *
     * */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        System.out.println("授权调用");
        /*获取用户的身份信息*/
        Student student=(Student)principalCollection.getPrimaryPrincipal();

        System.out.println("授权调用："+student);







        return null;
    }

    /*认证*/
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        System.out.println("来到了认证");
        /*获取身份信息*/
        String userid=(String) token.getPrincipal();
        //Long id=Long.valueOf(userid);
        /*到数据库中查询有没有当前用户*/

        Student student=studentService.getStudentWithSid(userid);




        if(student==null){
            System.out.println("----------------------null-------------");
            return null;
        }
        System.out.println("找到用户："+student);
        /*认证*/
        //参数：主体，主体的验证码，盐，当前Real名称

        SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(student,
                student.getPassword(),
                this.getName());
        return info;
    }
}
