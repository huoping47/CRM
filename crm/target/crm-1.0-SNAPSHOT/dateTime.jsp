<%--
  Created by IntelliJ IDEA.
  User: 霍平
  Date: 2022/8/8
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <script type="text/javascript" charset="UTF-8" src="jquery/jquery-1.11.1-min.js"></script>
    <link type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js" charset="UTF-8"></script>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"
            charset="UTF-8"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"
            charset="UTF-8"></script>
</head>
<script>
    $(function () {
        $("#mydate").datetimepicker({
            language: 'zh-CN',
            format: "yyyy-mm-dd",
            minView: "month",
            initialDate: new Date(),
            autoclose: true,
            todayBtn: true,
            clearBtn: true
        });
    })
</script>
<body>
<input id="mydate" type="text">
</body>
</html>
