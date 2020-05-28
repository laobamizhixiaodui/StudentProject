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
    <title>设备修理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">
    <form class="layui-form ok-form" lay-filter="downItem">

        <fieldset class="layui-elem-field">
            <legend>设备详情</legend>
            <div class="layui-field-box">
                <div class="layui-form-item">

                    <input type="text" name="id" placeholder="id" autocomplete="off" class="layui-input layui-hide"
                           lay-verify="required">

                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" placeholder="请输入设备名称"  autocomplete="off" class="layui-input layui-disabled"
                               lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备类型</label>
                    <div class="layui-input-block">
                        <input type="text" name="category" placeholder="请输入设备类型"  autocomplete="off" class="layui-input layui-disabled"
                               lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备规格</label>
                    <div class="layui-input-block">
                        <input type="text" name="specs" placeholder="请输入设备规格" autocomplete="off" class="layui-input layui-disabled"
                               lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">单价</label>
                    <div class="layui-input-block">
                        <input type="text" name="price" placeholder="请输入单价"  autocomplete="off" class="layui-input layui-disabled"
                               lay-verify="required|number">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">生产厂家</label>
                    <div class="layui-input-block">
                        <input type="text" name="factory" placeholder="生产厂家" autocomplete="off" class="layui-input layui-disabled"
                               lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">保质期</label>
                    <div class="layui-input-block">
                        <input type="text" name="qGP"  placeholder="请输入保质期" autocomplete="off"
                               class="layui-input layui-disabled" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">购买日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="buyTime" placeholder="请选择申请日期 格式为yyyy-MM-dd" disabled autocomplete="off"
                               class="layui-input layui-disabled" id="BuyDate" lay-verify="required">
                    </div>
                </div>

            </div>
        </fieldset>

        <fieldset class="layui-elem-field">
            <legend>设备维修详情</legend>
            <div class="layui-field-box">

                <div class="layui-form-item">
                    <label class="layui-form-label">修理日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="fixDate" placeholder="请选择修理日期 格式为yyyy-MM-dd"  autocomplete="off"
                               class="layui-input" id="fixDate" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">修理工厂</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="fixFactory" placeholder="请输入修理工厂" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">修理费用</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="fixPrice" placeholder="请输入修理费用" lay-verify="required|number"
                               autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">意见/备注</label>
                    <div class="layui-input-block">
                        <textarea name="opinion" placeholder="意见/备注" lay-verify="required" class="layui-textarea"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">责任人</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="fixPerson" placeholder="请输入责任人" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
            </div>
        </fieldset>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="fix">立即修理</button>
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

    layui.use(["element", "jquery", "form", "laydate", "okLayer", "okUtils"], function () {
        let form = layui.form;
        let laydate = layui.laydate;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let $ = layui.jquery;

        okLoading.close($);
        laydate.render({elem: "#buyTime", type: "date", trigger: 'click'});
        laydate.render({elem: "#fixDate", type: "date", trigger: 'click'});

        form.val("downItem", initData);

        form.on("submit(fix)", function (data) {

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
