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
    <title>设备列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">

    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">

            <input class="layui-input" placeholder="设备名称" autocomplete="off" name="name">
            <input class="layui-input" placeholder="设备类型" autocomplete="off" name="category">
            <input class="layui-input" placeholder="生产厂家" autocomplete="off" name="factory">
            <input class="layui-input" placeholder="经办人" autocomplete="off" name="doPerson">
            <button class="layui-btn" lay-submit lay-filter="search">
                <i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>

    <table id="downItemTable" lay-filter="downItemTable"></table>
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
            elem: '#downItemTable',
            url: '',
            id: 'deviceTable',
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
                {field: "category", title: "设备类别", width: 100},
                {field: "specs", title: "规格", width: 140},
                {field: "price", title: "单价(元)", width: 100, sort: true},
                {field: "factory", title: "生产厂家", width: 140},
                {
                    field: "buyDate", title: "购买日期", width: 100, templet: function (d) {
                        return util.toDateString(d.buyDate, "yyyy-MM-dd");
                    }
                },
                {field: "qGP", title: "保质期", width: 80},
                {
                    field: "state",
                    title: "状态",
                    width: 80,
                    templet: '<div><span class="layui-badge layui-bg-red">报废</span></div>'
                },
                {field: "opinion", title: "意见/备注", width: 160},
                {
                    field: "downDate", title: "报废日期", width: 100, templet: function (d) {
                        return util.toDateString(d.downDate, "yyyy-MM-dd");
                    }
                },
                {field: "doPerson", title: "经办人", width: 100},
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
