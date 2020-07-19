$(function () {

    $("#register").click(function () {
        console.log("111")
        if($("#registerForm").form('validate')){
            $.post("/register",$("form").serialize(),function (data) {
                console.log(data);
                if(data.success){
                    window.location.href="login.jsp";
                }else{
                    alert("用户已存在！！！")
                    window.location.href="register.jsp";
                }

            })
        }else{
           alert("请输入正确的格式");
            window.location.href="register.jsp";
        }

        /*$("#registerForm").form("submit",{

            url:'/register',
            success:function (data) {
                data=$.parser(data);
                if(data.success){

                }
            }
        })*/

    });
});