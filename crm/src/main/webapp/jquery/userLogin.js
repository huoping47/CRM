userLogin = function () {
    var loginAct = $("#loginAct").val()
    var loginPwd = $("#loginPwd").val()
    var isRemPwd = $("#isRemPwd").prop("checked")
    if (loginAct === "" || loginPwd === "") {
//不允许为空
        $("#msg").html("<span style='color: red'>用户名或者密码不允许为空!</span>")
        return;
    }
    $.ajax({
        url: "settings/qx/user/login.do",//发送到哪里处理数据
        type: "post",
        dataType: "json",//发送的格式
        data: {//发送的数据
            "loginact": loginAct,
            "loginpwd": loginPwd,
            "isRemPwd": isRemPwd
        },
        success: function (data) {//接收回来的数据
            if (data.code === "1") {
//登陆成功
                window.location.href = "workbench/LoginSuccessIndex.do"
                $("#msg").html("")

            } else {
                $("#msg").html(data.message)
            }
        },
        beforeSend: function () {//在ajax执行前,可以提前执行的语句,需要返回布尔类型的值,才决定执不执行
            $("#msg").html("<span style='color: black'>正在查询数据中......</span>")
            return true;
        }
    })
}