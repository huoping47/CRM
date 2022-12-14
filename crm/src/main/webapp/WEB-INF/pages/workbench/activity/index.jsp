<%@ page import="com.huoping.crm.setting.pojo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getScheme() + "://" + request.getServerName() + ":"
        + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=path%>">
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/jquery.bs_pagination.min.css">

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript" src="jquery/bs_pagination-master/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.min.js"></script>
    <script type="text/javascript">

        $(function () {
            //提交按钮事件
            $("#insertAcivity").click(function () {
                $("#createActivityModal").modal("show")
            })
            //保存按钮事件
            $("#saveAcitityData").click(function () {
                //验证需要提交的数据
                var owner = $("#create-marketActivityOwner option:checked").attr("id");
                var name = $("#create-marketActivityName").val();
                if (name === null || name === "") {
                    alert("活动名称不能为空")
                    return
                }
                var startDate = $.trim($("#create-startTime").val());
                var endDate = $.trim($("#create-endTime").val());
                if (startDate != null || endDate != null) {
                    if (endDate < startDate) {
                        alert("请输入正确的活动时间")
                        return;
                    }
                }
                var cost = $("#create-cost").val()
                var refCost = /^-[1-9]\d*|0$ 或 ^((-\d+)|(0+))$/
                if (refCost.test(cost)) {
                    alert("请输入大于0的数字")
                    return;
                }
                var describe = $.trim($("#create-describe").val())

                $.ajax({
                    url: "workbench/activity/insertActivityData.do",
                    data: {
                        "owner": owner,
                        "name": name,
                        "startdate": startDate,
                        "enddate": endDate,
                        "cost": cost,
                        "description": describe
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.code === "0") {
                            alert(data.message)
                            return;
                        } else {
                            $("#create-marketActivityName").val("")
                            $.trim($("#create-startTime").val(""));
                            $.trim($("#create-endTime").val(""));
                            $("#create-cost").val("")
                            $.trim($("#create-describe").val(""))
                            OnloadDataAll(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
                            $("#createActivityModal").modal("hide")
                        }
                    }
                })
            })
            $(".mydate").datetimepicker({
                language: 'zh-CN',
                format: "yyyy-mm-dd",
                minView: "month",
                initialDate: new Date(),
                autoclose: true,
                todayBtn: true,
                clearBtn: true
            })

            OnloadDataAll(1, 10)

            //分页查询函数
            function OnloadDataAll(pageNo, pageSize) {
                var get_name = $("#get-name").val()
                var get_owner = $("#get-owner").val()
                var get_startDate = $("#get-startDate").val()
                var get_endDate = $("#get-endDate").val()
                // var pageNo = pageNo
                // var pageSize = pageSize
                $.ajax({
                    url: "workbench/activity/selectAllDataActivityForPage",
                    type: "post",
                    dataType: "json",
                    // String name, String owner, String startdate,
                    // String enddate, String pageNo, String pageSize
                    data: {
                        name: get_name,
                        owner: get_owner,
                        startdate: get_startDate,
                        enddate: get_endDate,
                        pageNo: (pageNo - 1) * pageSize,
                        pageSize: pageSize
                    },
                    success: function (data) {
                        if (data.list == '') {
                            alert("暂时还没有符合要求的信息")
                            return
                        }
                        // $("#countPageB").text(data.countData);
                        let htmlBody = ""
                        $.each(data.list, function (index, obj) {
                            htmlBody += "<tr class=\"active\">"
                            htmlBody += " <td><input type=\"checkbox\"  value='" + obj.id + "'/></td>"
                            htmlBody += "<td><a style=\"text-decoration: none; cursor: pointer;" +
                                "\"onclick=\"window.location.href='detail.html';\">" + obj.name + "</a></td>"
                            htmlBody += "<td>" + obj.owner + "</td>"
                            htmlBody += "<td>" + obj.startdate + "</td>"
                            htmlBody += "<td>" + obj.enddate + "</td>"
                            htmlBody += "</tr>"
                        })
                        $("#dataBody").html(htmlBody)
                        if (data.countData % pageSize == 0) {
                            totalPage = data.countData / pageSize
                        } else {
                            totalPage = parseInt(data.countData / pageSize) + 1
                        }
                        $("#demo_pag1").bs_pagination({
                            currentPage: pageNo,
                            rowsPerPage: pageSize,
                            totalPages: totalPage,
                            totalRows: data.countData,
                            visiblePageLinks: 5,
                            showGoToPage: true,
                            showRowsPerPage: true,//每页显示条数
                            showRowsInfo: true,
                            onChangePage: function (event, data) { // returns page_num and rows_per_page after a link has clicked
                                OnloadDataAll(data.currentPage, data.rowsPerPage)
                            },
                        });
                    }
                })
            }

            $("#checkAll").click(function () {
                $("#dataBody input[type='checkbox']").prop("checked", this.checked)
            })
            //按条件查询函数
            $("#getDataBtn").click(function () {
                OnloadDataAll(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
            })
            //刷新按钮
            $("#resetAll").click(function () {
                OnloadDataAll(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
            })
        });

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${usersName}" var="u">
                                    <option id="${u.id}">${u.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" readonly id="create-startTime">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" readonly id="create-endTime">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="saveAcitityData">保存
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <option>zhangsan</option>
                                <option>lisi</option>
                                <option>wangwu</option>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text" id="get-name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="get-owner">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control mydate" readonly type="text" id="get-startDate"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control mydate" readonly type="text" id="get-endDate">
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="getDataBtn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="insertAcivity" data-target="#createActivityModal">
                    <%--            data-toggle="modal" --%>

                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                <button type="button" class="btn btn-primary" id="resetAll">刷新
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="checkAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="dataBody">
                <%--                <c:forEach items="${tblActivities}" var="act">--%>
                <%--                    <tr class="active">--%>
                <%--                        <td><input type="checkbox"/></td>--%>
                <%--                        <td><a style="text-decoration: none; cursor: pointer;"--%>
                <%--                               onclick="window.location.href='detail.html';">${act.name}</a></td>--%>
                <%--                        <td>${act.owner}</td>--%>
                <%--                        <td>${act.startdate}</td>--%>
                <%--                        <td>${act.enddate}</td>--%>
                <%--                    </tr>--%>
                <%--                </c:forEach>--%>
                </tbody>
            </table>

        </div>
        <div id="demo_pag1"></div>

        <%--        <div style="height: 50px; position: relative;top: 30px;">--%>
        <%--            <div>--%>
        <%--                <button type="button" class="btn btn-default" style="cursor: default;">共<b id="countPageB">0</b>条记录--%>
        <%--                </button>--%>
        <%--            </div>--%>
        <%--            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">--%>
        <%--                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>--%>
        <%--                <div class="btn-group">--%>
        <%--                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">--%>
        <%--                        10--%>
        <%--                        <span class="caret"></span>--%>
        <%--                    </button>--%>
        <%--                    <ul class="dropdown-menu" role="menu">--%>
        <%--                        <li><a href="#">20</a></li>--%>
        <%--                        <li><a href="#">30</a></li>--%>
        <%--                    </ul>--%>
        <%--                </div>--%>
        <%--                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>--%>
        <%--            </div>--%>
        <%--            <div style="position: relative;top: -88px; left: 285px;">--%>
        <%--                <nav>--%>
        <%--                    <ul class="pagination">--%>
        <%--                        <li class="disabled"><a href="#">首页</a></li>--%>
        <%--                        <li class="disabled"><a href="#">上一页</a></li>--%>
        <%--                        <li class="active"><a href="#">1</a></li>--%>
        <%--                        <li><a href="#">2</a></li>--%>
        <%--                        <li><a href="#">3</a></li>--%>
        <%--                        <li><a href="#">4</a></li>--%>
        <%--                        <li><a href="#">5</a></li>--%>
        <%--                        <li><a href="#">下一页</a></li>--%>
        <%--                        <li class="disabled"><a href="#">末页</a></li>--%>
        <%--                    </ul>--%>
        <%--                </nav>--%>
        <%--            </div>--%>
        <%--        </div>--%>

    </div>

</div>
</body>
</html>