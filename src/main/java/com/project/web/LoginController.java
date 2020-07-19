package com.project.web;

import com.project.domain.AjaxRes;
import com.project.domain.Student;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

    @RequestMapping("/Stulogin")
    @ResponseBody//返回JSON数据
    //AjaxRes是自己创建的一个JSON类
    public AjaxRes login(Student student){
        AjaxRes ajaxRes=new AjaxRes();
        System.out.println(student);


        return ajaxRes;

    }




}
