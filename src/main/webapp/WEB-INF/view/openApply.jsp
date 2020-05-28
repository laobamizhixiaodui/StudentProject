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
    <form class="layui-form ok-form" lay-filter="openApply" >

        <fieldset class="layui-elem-field">
            <legend>申购单详情</legend>
            <div class="layui-field-box">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" disabled placeholder="请输入设备名称" autocomplete="off" class="layui-input"
                               lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备类型</label>
                    <div class="layui-input-block">
                        <input type="text" name="category" disabled placeholder="请输入设备类型" autocomplete="off" class="layui-input" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备规格</label>
                    <div class="layui-input-block">
                        <input type="text" name="specs" disabled placeholder="请输入设备规格" autocomplete="off" class="layui-input" lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">单价</label>
                    <div class="layui-input-block">
                        <input type="text" name="price" disabled placeholder="请输入单价" autocomplete="off" class="layui-input"
                               lay-verify="required|number">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">数量</label>
                    <div class="layui-input-block">
                        <input type="text" name="count" disabled placeholder="请输入数量" autocomplete="off"
                               class="layui-input"  lay-verify="required|number">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">申请日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="applyDate" disabled placeholder="请选择申请日期 格式为yyyy-MM-dd HH:mm:ss" autocomplete="off"
                               class="layui-input" id="sendDate" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">理由/备注</label>
                    <div class="layui-input-block">
                        <textarea name="reason" disabled placeholder="申请理由/备注" class="layui-textarea"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">申请人</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="applyPerson" disabled placeholder="请输入申请人" lay-verify="required" autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">审核状态</label>
                    <div class="layui-input-inline">
                        <select name="state"  disabled lay-filter="state">
                            <option value="0">待审核</option>
                            <option value="1">已审核</option>
                            <option value="2">已驳回</option>
                        </select>
                    </div>
                </div>
            </div>
        </fieldset>

        <fieldset class="layui-elem-field">
            <legend>审核与意见</legend>
            <div class="layui-field-box">
                <div class="layui-form-item">
                    <label class="layui-form-label">审核意见</label>
                    <div class="layui-input-block">
                        <textarea name="opinion" disabled placeholder="审核意见。。。" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">审核日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="checkDate" disabled placeholder="审核日期。。。。" autocomplete="off"
                               class="layui-input" id="checkDate" lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">审核人</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="checkPerson" disabled placeholder="审核人" lay-verify="required" autocomplete="off">
                    </div>
                </div>
            </div>
        </fieldset>

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

        laydate.render({elem: "#sendDate", type: "date",trigger: 'click'});
        laydate.render({elem:'#checkDate',type:"date",trigger: 'click'});

        form.val("openApply",initData);

    });
</script>
</body>
</html>
