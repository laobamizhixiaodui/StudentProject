<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/22
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>申购列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">

    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">

            <select name="state" lay-filter="state">
                <option value="">请选择审核状态</option>
                <option value="0">待审核</option>
                <option value="1">已审核</option>
                <option value="2">已驳回</option>
            </select>
            <input class="layui-input" placeholder="设备名称" autocomplete="off" name="name">
            <input class="layui-input" placeholder="设备类型" autocomplete="off" name="category">
            <input class="layui-input" placeholder="申购人" autocomplete="off" name="applyPerson">
            <button class="layui-btn" lay-submit lay-filter="search">
                <i class="layui-icon">&#xe615;</i>
            </button>
        </form>
    </div>

    <table id="applyTable" lay-filter="applyTable"></table>
</div>
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(["element", "jquery", "okLayer", "form", "util", "okUtils", "table"], function () {
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let $ = layui.jquery;
        let table = layui.table;
        let form = layui.form;
        let util = layui.util;

        okLoading.close($);

        let applyTable = table.render({
            elem: '#applyTable',
            url: '',
            id: 'applyTable',
            page: true,
            limits: [10, 20, 30],
            toolbar: true,
            toolbar: '#toolbarApply',
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
                {type: "numbers", title: "序号", fixed: "left"},
                {field: "id", title: "ID", hide: true},
                {field: "name", title: "设备名称", width: 100},
                {field: "category", title: "设备类别", width: 100},
                {field: "specs", title: "规格", width: 140},
                {field: "reason", title: "理由/备注", width: 160},
                {
                    field: "applyDate", title: "申请日期", width: 100, templet: function (d) {
                        return util.toDateString(d.applyDate, "yyyy-MM-dd");
                    }
                },
                {field: "price", title: "单价(元)", width: 100, sort: true},
                {field: "count", title: "数量", width: 100, sort: true},
                {field: "amount", title: "总金额", width: 100, sort: true},
                {field: "applyPerson", title: "申请人", width: 100},
                {
                    field: "state", title: "状态", width: 80, templet: function (d) {
                        let rep = "";
                        switch (d.state) {
                            case 0:
                                rep += '<span class="layui-badge layui-bg-orange">待审核</span>';
                                break;
                            case 1:
                                rep += '<span class="layui-badge layui-bg-green">已审核</span>';
                                break;
                            case 2:
                                rep += '<span class="layui-badge layui-bg-red" >已驳回</span>';
                                break;
                        }
                        return rep;
                    }
                },
                {field: "opinion", title: "审核意见", width: 100, hide: true},
                {
                    field: "checkDate", title: "审核日期", width: 100, hide: true, templet: function (d) {
                        if (d.checkDate == null){
                            return "";
                        }
                        return util.toDateString(d.checkDate, "yyyy-MM-dd");
                    }
                },
                {field: "checkPerson", title: "审核人", width: 100, hide: true},
                {title: "操作", width: 140, align: "center", fixed: "right", templet: "#operationTpl"}
            ]]
        });

        table.on("toolbar(applyTable)", function (obj) {
            switch (obj.event) {
                case "batchDel":
                    batchDel();
                    break;
                case "applyDevice":
                    applyDevice();
                    break;
            }
        });
        table.on('tool(applyTable)', function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case 'delete':
                    deleteApply(data);
                    break;
                case 'edit':
                    editApply(data);
                    break;
                case 'buy':
                    buyDevice(data);
                    break;
                case 'open':
                    openApply(data);
            }

        });
        form.on('select(state)', function (data) {
            applyTable.reload({
                where: {
                    state: data.value
                },
                page: {curr: 1}
            });
            return false;
        });
        form.on('submit(search)', function (data) {
            applyTable.reload({
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });

        function batchDel() {
            okLayer.confirm("确定要批量删除吗？", function (index) {
                layer.close(index);
                let ids = tableBatchCheck();
                if (ids) {
                    okUtils.ajax("/apply/batchDelete", "post", {"ids": ids}, true).done(function (rep) {
                        okUtils.tableSuccessMsg(rep.content);
                    }).fail(function (rep) {
                        console.log(rep);
                    })

                }
            });

        }


        function applyDevice() {
            okLayer.open("申购设备", "/system/addApply", "90%", "90%", null, function () {
                $(".layui-laypage-btn")[0].click();
            });
        }

        function deleteApply(data) {
            okLayer.confirm("确定要删除吗？", function (index) {
                okLayer.close(index);
                okUtils.ajax("/apply/delete?id=" + data.id, "get", null, true).done(function (rep) {
                    okUtils.tableSuccessMsg(rep.content);
                }).fail(function (rep) {
                    console.log(rep);
                })

            });
        }

        function editApply(data) {
            okLayer.open("更新申购单", "/system/editApply", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(data);
            }, function () {
                applyTable.reload();
            })
        }

        function buyDevice(data) {
            if (data.state === 1) {
                okLayer.open("设备入库", "/system/addDevice", "90%", "90%", function (layero) {
                    let iframeWin = window[layero.find("iframe")[0]["name"]];
                    iframeWin.initForm(data);
                }, function () {
                    $(".layui-laypage-btn")[0].click();
                })
            } else {
                layer.msg("申购还未通过审核", {icon: 2, time: 2000});
            }

        }

        function openApply(data) {
            okLayer.open("申购单详情", "/system/openApply", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                data.applyDate = util.toDateString(data.applyDate, "yyyy-MM-dd");
                iframeWin.initForm(data);
            }, null)
        }


        function tableBatchCheck() {
            let checkStatus = table.checkStatus("applyTable");
            let rows = checkStatus.data.length;
            if (rows > 0) {
                let idsStr = "";
                for (let i = 0; i < checkStatus.data.length; i++) {
                    idsStr += checkStatus.data[i].id + ",";
                }
                return idsStr;
            } else {
                layer.msg("未选择有效数据", {offset: "t", anim: 6});
            }
        }

    });

</script>

<script type="text/html" id="toolbarApply">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel">批量删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="applyDevice">申购设备</button>
    </div>
</script>
<script type="text/html" id="operationTpl">
    <a href="javascript:" title="详情" lay-event="open"><i class="layui-icon">&#xe705;</i></a>
    <a href="javascript:" title="编辑" lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:" title="删除" lay-event="delete"><i class="layui-icon">&#xe640;</i></a>
    <a href="javascript:" title="购买" lay-event="buy"><i class="layui-icon">&#xe61f;</i></a>
</script>
</body>
</html>
