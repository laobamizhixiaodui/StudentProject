$(function () {

    $("#register").click(function () {
        console.log("111")
        $("#registerForm").form("submit",{

            url:'register',
            success:function (data) {
                data=$.parser(data);
                if(data.success){

                }
            }
        })

    });
});