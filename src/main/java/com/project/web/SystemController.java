package com.project.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SystemController {

    @RequestMapping("/login")
    public String login(){
        return "redirect:login.jsp";
    }

    @RequestMapping("/console")
    public String console(){
        System.out.println("------来到了控制台------");
        return "console_1";
    }


    @RequestMapping("/applyList")
    public String appList(){
        return "applyList";
    }

    @RequestMapping("/deviceList")
    public String deviceList(){
        return "deviceList";
    }

    @RequestMapping("/fixList")
    public String fixList(){
        return "fixList";
    }

    @RequestMapping("/categoryList")
    public String categoryList(){
        return "categoryList";
    }

    @RequestMapping("/checkList")
    public String checkList(){
        return "checkList";
    }

    @RequestMapping("/downList")
    public String downList(){
        return "downList";
    }

    @RequestMapping("/fixInfoList")
    public String fixInfoList(){
        return "fixInfoList";
    }

}
