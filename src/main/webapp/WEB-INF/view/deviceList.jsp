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

    <table id="deviceTable" lay-filter="deviceTable"></table>
</div>

<!--js逻辑-->
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(["element", "jquery","okLayer","form","util","okUtils","table"],function () {

        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let $ = layui.jquery;
        let table = layui.table;
        let form = layui.form;
        let util = layui.util;


        okLoading.close($);

        let deviceTable = table.render({
            elem: '#deviceTable',
            url: '',
            id: 'deviceTable',
            page: true,
            limits:[10,20,30],
            toolbar:true,
            toolbar: '#toolbarDevice',
            size: 'sm',
            parseData:function(res){
                return{
                    "code":res.code,
                    "msg": res.message,
                    "count":res.content.total,
                    "data":res.content.data
                }
            },
            response:{
                statusName:'code',
                statusCode:200
            },
            cols:[[
                {type:"checkbox",fixed:"left"},

                {field: "id", title: "ID",hide:true},
                {type: "numbers", title:'序号', fixed: "left",width:60},           {field: "number", title: "编号", width: 120},
                {field: "name", title: "设备名称", width: 140},
                {field: "category", title: "设备类别", width: 100},
                {field: "specs", title: "规格", width: 140},
                {field: "price", title: "单价(元)", width: 100,sort:true},
                {field: "factory", title: "生产厂家", width: 140},
                {field: "buyTime", title: "购买日期", width: 100,templet:function (d) {
                        return util.toDateString(d.buyTime,"yyyy-MM-dd");
                    }},
                {field: "qGP", title: "保质期", width: 80},
                {field: "state", title: "状态", width: 80,templet:function (d) {
                        let rep = "";
                        switch (d.state) {
                            case 0:
                                rep += '<span class="layui-badge layui-bg-green">正常</span>';
                                break;
                            case 1:
                                rep += '<span class="layui-badge layui-bg-orange">维修</span>';
                                break;
                            case 2:
                                rep += '<span class="layui-badge layui-bg-red">报废</span>';
                                break;
                        }
                        return rep;
                    }},
                {field: "doPerson", title: "经办人", width: 100},
                {title: "操作", width: 140, align: "center", fixed: "right", templet: "#operationTpl"}
            ]],
            done:function (res, curr, count) {
                console.info(res, curr, count);
            }
        });
        
        table.on("toolbar(deviceTable)",function (obj){
            switch (obj.event) {
                case "batchDel":
                    batchDel();break;
                case "apply":
                    apply();break;
            }
        });

        table.on('tool(deviceTable)',function (obj) {
            let data = obj.data;
            switch (obj.event) {
                case 'delete':
                    deleteDevice(data);break;
                case 'fix':
                    fixDevice(data);break;
                case 'down':
                    downDevice(data);break;
            }
            
        });


        form.on("submit(search)", function (data) {
            deviceTable.reload({
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });

        function apply() {
            okLayer.open("申购设备", "", "90%", "90%", null,null);
        }

        function deleteDevice(data) {
            okLayer.confirm("您确定要删除该设备吗？",function (index) {
                layer.close(index);
                okUtils.ajax(""+data.id,"get",null,true).done(function (rep) {

                 okUtils.tableSuccessMsg(rep.content);

                }).fail(function (rep) {
                    console.log(rep);
                });

            });
        }
        
        function fixDevice(data) {

                okLayer.confirm("你确定要修理该设备吗？",function (index) {
                    layer.close(index);
                    okUtils.ajax("","post",{"id":data.id},true).done(function (rep) {
                       okUtils.tableSuccessMsg(rep.content);
                    }).fail(function (rep) {
                        console.log(rep);
                    })
                });

                $(".layui-laypage-btn")[0].click();


        }
        
        function downDevice(data) {
            okLayer.open("设备报废", "", "90%", "90%", function (layero) {
                let iframeWin = window[layero.find("iframe")[0]["name"]];
                data.buyTime = util.toDateString(data.buyTime,"yyyy-MM-dd");
                iframeWin.initForm(data);
            }, function () {
                $(".layui-laypage-btn")[0].click();
            })
        }
        
        function batchDel() {
            okLayer.confirm("确定要批量删除吗？",function (index) {
                layer.close(index);
                let ids = tableBatchCheck();
                if (ids){
                    okUtils.ajax("","post",{"ids":ids},true).done(function (rep) {
                        okUtils.tableSuccessMsg(rep.content);
                    }).fail(function (rep) {
                        console.log(rep);
                    });

                }
            });
        }


        function tableBatchCheck() {
            let checkStatus = table.checkStatus("deviceTable");
            let rows = checkStatus.data.length;
            console.log(checkStatus.data);
            if (rows > 0) {
                let idsStr = "";
                for (let i = 0; i < checkStatus.data.length; i++) {
                    idsStr += checkStatus.data[i].id+ ",";
                }
                return idsStr;
            } else {
                layer.msg("未选择有效数据", {offset: "t", anim: 6});
            }
        }
    });
</script>

<script type="text/html" id="toolbarDevice">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel">批量删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="apply">申购设备</button>
    </div>
</script>
<script type="text/html" id="operationTpl">
    <a href="javascript:" title="删除" lay-event="delete"><i class="layui-icon">&#xe640;</i></a>
    <a href="javascript:" title="修理" lay-event="fix"><i class="layui-icon">&#xe620;</i></a>
    <a href="javascript:" title="报废" lay-event="down"><i class="layui-icon">&#x1006;</i></a>
</script>

</body>
</html>
