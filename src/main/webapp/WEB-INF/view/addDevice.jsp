<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/19
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改设备申购信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">
    <form class="layui-form ok-form" lay-filter="editApply" >
        <div class="layui-form-item">
            <label class="layui-form-label">ID</label>
            <div class="layui-input-block">
                <input type="text" name="id" placeholder="id" disabled autocomplete="off" class="layui-input"
                       lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">设备名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" placeholder="请输入设备名称" disabled autocomplete="off" class="layui-input"
                       lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">设备类型</label>
            <div class="layui-input-block">
                <input type="text" name="category" placeholder="请输入设备类型" disabled autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">设备规格</label>
            <div class="layui-input-block">
                <input type="text" name="specs" placeholder="请输入设备规格" disabled autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单价</label>
            <div class="layui-input-block">
                <input type="text" name="price" placeholder="请输入单价" disabled autocomplete="off" class="layui-input"
                       lay-verify="required|number">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">数量</label>
            <div class="layui-input-block">
                <input type="text" name="count" placeholder="请输入数量" disabled autocomplete="off"
                       class="layui-input"  lay-verify="required|number">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">生产厂家</label>
            <div class="layui-input-block">
                <input type="text" name="factory" placeholder="生产厂家" autocomplete="off" class="layui-input"
                       lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">保质期</label>
            <div class="layui-input-block">
                <input type="text" name="qGP" placeholder="请输入保质期" autocomplete="off"
                       class="layui-input"  lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">购买日期</label>
            <div class="layui-input-block">
                <input type="text" name="BuyDate" placeholder="请选择申请日期 格式为yyyy-MM-dd HH:mm:ss" autocomplete="off"
                       class="layui-input" id="BuyDate" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">经办人</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="doPerson" placeholder="请输入申请人" lay-verify="required" autocomplete="off">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="add">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

    </form>
</div>
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script type="text/javascript">

    let initData;

    function initForm(data) {
        let jsonString = JSON.stringify(data);
        initData = JSON.parse(jsonString);
    }

    layui.use(["element","jquery", "form", "laydate", "okLayer", "okUtils"], function () {
        let form = layui.form;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let $ = layui.jquery;

        okLoading.close($);

        laydate.render({elem: "#BuyDate", type: "date",trigger: 'click'});

        form.val("editApply",initData);

        form.on("submit(add)", function (data){

            okUtils.ajax("", "post", data.field, true).done(function (response) {

                okLayer.greenTickMsg(response.content, function () {

                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (error) {
                console.log(error)
            });
            return false;
        });
    });
</script>
</body>
</html>
