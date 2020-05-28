<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/19
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>维修记录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">

    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">

            <input class="layui-input" placeholder="设备名称" autocomplete="off" name="name">
            <input class="layui-input" placeholder="维修工厂" autocomplete="off" name="fixfactory">
            <input class="layui-input" placeholder="责任人" autocomplete="off" name="fixPerson">
            <button class="layui-btn" lay-submit lay-filter="search">
                <i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>

    <table id="fixInfoTable" lay-filter="fixInfoTable"></table>
</div>

<!--js逻辑-->
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(["element", "jquery", "form", "util", "table"], function () {

        let $ = layui.jquery;
        let table = layui.table;
        let form = layui.form;
        let util = layui.util;

        okLoading.close($);

        let deviceTable = table.render({
            elem: '#fixInfoTable',
            url: '',
            id: 'fixInfoTable',
            page: true,
            limits: [10, 20, 30],
            toolbar: true,
            size: 'sm',
            parseData: function (res) {
                return {
                    "code": res.code,
                    "msg": res.message,
                    "count": res.content.total,
                    "data": res.content.data
                }
            },
            response: {
                statusName: 'code',
                statusCode: 200
            },
            cols: [[
                {type: "checkbox", fixed: "left"},
                {type: "numbers", title:'序号', fixed: "left",width:80},
                {field: "id", title: "ID", hide: true},
                {field: "number", title: "编号", width: 120},
                {field: "name", title: "设备名称", width: 140},
                {field: "fixPrice", title: "修理费用(元)", width: 140, sort: true},
                {field: "fixFactory", title: "修理厂家", width: 160},
                {
                    field: "fixDate", title: "修理日期", width: 100, templet: function (d) {
                        return util.toDateString(d.fixDate, "yyyy-MM-dd");
                    }
                },
                {field: "opinion", title: "意见/备注", width: 160},
                {field: "fixPerson", title: "责任人", width: 100},
            ]],
            done: function (res, curr, count) {
                console.info(res, curr, count);
            }
        });

        form.on("submit(search)", function (data) {
            deviceTable.reload({
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });


    });
</script>


</body>
</html>
