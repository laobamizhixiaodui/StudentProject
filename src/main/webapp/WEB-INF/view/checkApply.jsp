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
    <form class="layui-form ok-form" lay-filter="checkApply">

        <fieldset class="layui-elem-field">
            <legend>申购单详情</legend>
            <div class="layui-field-box">
                <div class="layui-form-item">
                    <input type="text" name="id" placeholder="id" autocomplete="off" class="layui-input layui-hide"
                           lay-verify="required">
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="name"  placeholder="请输入设备名称" autocomplete="off"
                               class="layui-input layui-disabled"
                               lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备类型</label>
                    <div class="layui-input-block">
                        <input type="text" name="category"  placeholder="请输入设备类型" autocomplete="off"
                               class="layui-input layui-disabled" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备规格</label>
                    <div class="layui-input-block">
                        <input type="text" name="specs"  placeholder="请输入设备规格" autocomplete="off"
                               class="layui-input layui-disabled" lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">单价</label>
                    <div class="layui-input-block">
                        <input type="text" name="price"  placeholder="请输入单价" autocomplete="off"
                               class="layui-input layui-disabled"
                               lay-verify="required|number">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">数量</label>
                    <div class="layui-input-block">
                        <input type="text" name="count"  placeholder="请输入数量" autocomplete="off"
                               class="layui-input layui-disabled" lay-verify="required|number">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">申请日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="applyDate"  placeholder="请选择申请日期 格式为yyyy-MM-dd HH:mm:ss"
                               autocomplete="off"
                               class="layui-input layui-disabled" id="sendDate" lay-verify="required">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">理由/备注</label>
                    <div class="layui-input-block">
                        <textarea name="reason"  placeholder="申请理由/备注" class="layui-textarea layui-disabled"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">申请人</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input layui-disabled" name="applyPerson"  placeholder="请输入申请人"
                               lay-verify="required" autocomplete="off">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">审核状态</label>
                    <div class="layui-input-inline">
                        <select name="state" disabled lay-filter="state">
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
                        <textarea name="opinion" lay-verify="required" placeholder="审核意见。。。"
                                  class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">审核日期</label>
                    <div class="layui-input-block">
                        <input type="text" name="checkDate" placeholder="审核日期。。。。" autocomplete="off"
                               class="layui-input" id="checkDate" lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">审核人</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="checkPerson" placeholder="审核人"
                               lay-verify="required" autocomplete="off">
                    </div>
                </div>
            </div>
        </fieldset>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn " lay-submit lay-filter="check">同意申请</button>
                <button class="layui-btn layui-btn-danger" lay-submit lay-filter="reject">驳回申请</button>
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

        laydate.render({elem: "#sendDate", type: "date", trigger: 'click'});
        laydate.render({elem: '#checkDate', type: "date", trigger: 'click'});

        form.val("checkApply", initData);

        form.on('submit(check)', function (data) {
            okUtils.ajax("", "post", data.field,true).done(function (response) {

                okLayer.greenLaughMsg(response.content,function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (rep) {
                console.log(rep);
            });
            return false;
        });

        form.on('submit(reject)', function (data) {
            okUtils.ajax("/apply/rejectApply", "post", data.field,true).done(function (response) {
                okLayer.greenTickMsg(response.content, function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                });
            }).fail(function (rep) {
                console.log(rep);
            });
            return false;
        });

    });
</script>
</body>
</html>
