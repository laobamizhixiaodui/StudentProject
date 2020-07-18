<%--
  Created by IntelliJ IDEA.
  User: windows
  Date: 2020/7/18
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Steppy Account Create Form Flat Responsive Widget Template :: w3layouts</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Steppy Account Create Form template Responsive, Login form web template,Flat Pricing tables,Flat Drop downs  Sign up Web Templates, Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- Custom Theme files -->
    <link href="static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //Custom Theme files -->
    <%@ include file="static/common/common.jsp"%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/register.js"></script>
</head>
<body>
<!-- main -->
<div class="main-agileits">
    <h1>Steppy Account Create Form</h1>
    <div class="main-row">
        <ul class="steps">
            <li class="is-active">Step 1</li>
        </ul>
        <form class="form-wrapper" id="registerForm" action="/register" method="post">
            <fieldset class="section is-active">
                <h3>Your Details</h3>
                <input type="text" name="sid"  placeholder="学号" data-options="required:true,validType:['number']">
                <input type="text" name="sname"  placeholder="姓名" data-options="required:true,validType:['userName','minLength[2]','maxLength[6]']">
                <input type="text" name="phone"  placeholder="手机" data-options="required:true,validType:'phoneRex'">
                <input type="text" name="idcard"  placeholder="身份证" data-options="required:true,validType:'idCode'">
                <input type="password" name="password"  placeholder="Password" data-options="required:true,validType:['minLength[6]','maxLength[8]']">

                <input class="submit button" type="submit" id="register" value="提交">

            </fieldset>

        </form>
    </div>
</div>
<!-- //main -->
<!-- copyright -->
<div class="w3copyright-agile">
    <p>© 2017 Steppy Account Create Form. All rights reserved | Design by <a href="https://shop303982252.taobao.com">源代码设计</a></p>
</div>
<!-- //copyright -->
<!-- js -->
<script src="static/js/jquery-2.2.3.min.js"></script>
<script>


    $(document).ready(function(){
        $(".form-wrapper .button").click(function(){
            var button = $(this);
            var currentSection = button.parents(".section");
            var currentSectionIndex = currentSection.index();
            var headerSection = $('.steps li').eq(currentSectionIndex);
            currentSection.removeClass("is-active").next().addClass("is-active");
            headerSection.removeClass("is-active").next().addClass("is-active");

            $(".form-wrapper").submit(function(e) {
                e.preventDefault();
            });

            if(currentSectionIndex === 3){
                $(document).find(".form-wrapper .section").first().addClass("is-active");
                $(document).find(".steps li").first().addClass("is-active");
            }
        });
    });



    //自定义验证
    $.extend($.fn.validatebox.defaults.rules, {
        phoneRex: {
            validator: function(value){
                var rex=/^1[3-8]+\d{9}$/;
                //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
                //电话号码：7-8位数字： \d{7,8
                //分机号：一般都是3位数字： \d{3,}
                //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/
                var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                if(rex.test(value)||rex2.test(value))
                {
                    // alert('t'+value);
                    return true;
                }else
                {
                    //alert('false '+value);
                    return false;
                }

            },
            message: '请输入正确电话或手机格式'
        },
        number: {
            validator: function (value) {
                var rex=/^12020350+\d{4}$/;
                if(rex.test(value)&&(/^[0-9]+?[0-9]*$/.test(value))){
                    return true;
                }else{
                    return false;
                }
            },
            message: '请输入正确的员工号'
        },
        userName:{
            validator:function (value) {
                if(value.length==0||value.match(" ")){
                    return false;
                }else{
                    return true;
                }
            },
            message: '不能包含空格'
        },
        minLength:{
            validator:function(value,param){
                return value.length >=param[0]
            },
            message:'至少输入{0}个字'
        },
        maxLength:{
            validator:function(value,param){
                return value.length<=param[0]
            },
            message:'最多{0}个字'
        },
        idCode:{
            validator:function(value,param){
                return /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
            },
            message: '请输入正确的身份证号'
        },
        eqPwd : {
            validator : function(value, param) {
                return value == $(param[0]).val();
            },
            message :'密码不一致！'
        }


    });
</script>
<!-- //js -->
</body>
</html>
