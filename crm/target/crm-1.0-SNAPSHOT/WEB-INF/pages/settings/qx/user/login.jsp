<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <% String path = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
    %>
    <base href="<%=path%>">
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            $(window).keydown(function (event) {
                if (event.keyCode === 13) {
                    userLogin()
                }
            })
            $("#loginBtn").click(function () {
                userLogin()
            })
            userLogin = function () {
                var loginAct = $("#loginAct").val()
                var loginPwd = $("#loginPwd").val()
                var isRemPwd = $("#isRemPwd").prop("checked")
                if (loginAct === "" || loginPwd === "") {
                    //不允许为空
                    $("#msg").html("<span style='color: red'>用户名或者密码不允许为空</span>")
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
                        $("#msg").html("<span style='color: black'>正在查询数据......</span>")
                        return true;
                    }
                })
            }

            //获得焦点时清空错误的提示
            $("#loginAct").focus(function () {
                $("#msg").html("")
            })
            $("#loginPwd").focus(function () {
                $("#msg").html("")
            })
        }
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="../../../workbench/index.jsp" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" value="huoping" id="loginAct" type="text" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" value="zxc123" id="loginPwd" type="password"
                           placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;margin-left: 10px">
                    <input type="checkbox" id="isRemPwd">十天内免登录
                    <span style="margin-left: 30px" id="msg"></span>
                </div>
                <button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>