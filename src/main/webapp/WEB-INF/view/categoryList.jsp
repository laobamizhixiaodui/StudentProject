<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/14
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>设备类型类别</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/oksub.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</head>
<body>
<div class="ok-body">

    <div class="layui-row" style="margin-bottom: 20px">
        <button type="button" id="allowAdd" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加</button>
        <button type="button" id="allowUpdate" class="layui-btn layui-btn-warm"><i class="layui-icon">&#xe642;</i>修改</button>
        <button type="button" id="deleteCategory" class="layui-btn layui-btn-danger"><i class="layui-icon">&#xe640;</i>删除</button>
    </div>

    <fieldset class="layui-elem-field layui-field-title">
        <legend>实验室设备类型</legend>
        <div class="layui-field-box">

            <div class="layui-row">


                <div class="layui-col-xs12 layui-col-sm3 layui-col-md3" id="categoryTree"></div>

                <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <form class="layui-form" lay-filter="category">
                        <div class="layui-form-item">
                            <label class="layui-form-label">ID</label>
                            <div class="layui-input-block">
                                <input type="text" name="id" lay-verify="id" autocomplete="off" placeholder="id"
                                       class="layui-input" disabled>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-block">
                                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="标题"
                                       class="layui-input" disabled>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">是否根节点</label>
                            <div class="layui-input-block">
                                <input type="checkbox" name="root" lay-skin="switch" lay-text="是|否" disabled>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">父节点ID</label>
                            <div class="layui-input-block">
                                <input type="text" name="pid" lay-verify="pid" autocomplete="off" placeholder="父节点ID"
                                       class="layui-input" disabled>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">层级</label>
                            <div class="layui-input-block">
                                <input type="text" name="level" lay-verify="level" autocomplete="off" placeholder="层级"
                                       class="layui-input" disabled>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn layui-btn-disabled" id="addCategory" lay-submit lay-filter="add">添加</button>
                                <button class="layui-btn layui-btn-warm layui-btn-disabled" id="updateCategory" lay-submit
                                        lay-filter="update">修改
                                </button>
                            </div>
                        </div>

                    </form>
                </div>

            </div>

        </div>

    </fieldset>


</div>
<!--js逻辑-->
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script>
    layui.use(["element", "jquery", "form", "okLayer", "okUtils", "tree"], function () {

        let form = layui.form;
        let okLayer = layui.okLayer;
        let okUtils = layui.okUtils;
        let $ = layui.jquery;
        let tree = layui.tree;

        okLoading.close();


        $('#deleteCategory').click(function () {
            let data = form.val('category');
            $.get('' + data.id, function (data) {
                if (data.message === "success") {
                    okLayer.greenTickMsg(data.content, function () {
                        treeReload();
                    });
                } else {
                    layer.msg(data.content, {icon: 7, time: 2000});
                }
            });
        });


        okUtils.ajax("", "get", null, true).done(function (rep) {

            let categoryTree = tree.render({
                elem: '#categoryTree',
                data: rep.content,
                text: {
                    defaultNodeName: '未命名',
                    none: '无数据或数据加载失败'
                },
                accordion: true,
                click: function (obj) {
                    fromDisabled();
                    $('#updateCategory').addClass('layui-btn-disabled');
                    $('#addCategory').addClass('layui-btn-disabled');
                    form.val('category', {
                        "id": obj.data.id,
                        "title": obj.data.title,
                        "pid": obj.data.pid,
                        "level": obj.data.level,
                        "root": obj.data.pid === 0
                    });
                }
            });
        }).fail(function (rep) {
            console.log(rep);
        });

        $('#allowAdd').click(function () {
            $('#addCategory').removeClass('layui-btn-disabled');
            $('input[name=pid]').removeAttr('disabled');
            $('input[name=title]').removeAttr('disabled');
            $('input[name=level]').removeAttr('disabled');
            $('input[name=root]').removeAttr('disabled');
            form.val('category', {
                "id": "",
                "title": "",
                "pid": "",
                "level": "",
                "root": 0
            });
            $('#updateCategory').addClass('layui-btn-disabled');

        });

        $('#allowUpdate').click(function () {
            $('#updateCategory').removeClass('layui-btn-disabled');
            $('input[name=title]').removeAttr('disabled');
            $('#addCategory').addClass('layui-btn-disabled');
        });


        function fromDisabled() {
            $('input[name=pid]').attr('disabled', true);
            $('input[name=id]').attr('disabled', true);
            $('input[name=title]').attr('disabled', true);
            $('input[name=level]').attr('disabled', true);
            $('input[name=root]').attr('disabled', true);
        }

        form.on('submit(add)', function (data) {

            okUtils.ajax("", "post", data.field, true).done(function (rep) {
                if (rep.message === "success") {
                    okLayer.greenTickMsg(rep.content, function () {
                        $.get('', function (repData) {
                            treeReload()

                        });

                    });
                } else {
                    layer.msg(rep.content, {icon: 7, time: 2000});
                }
            }).fail(function (rep) {
                console.log(rep);
            });

            return false;
        });

        form.on('submit(update)', function (data) {
            okUtils.ajax("", "post", data.field, true).done(function (rep) {
                if (rep.message === "success") {
                    okLayer.greenTickMsg(rep.content, function () {
                        $.get('', function (repData) {
                           treeReload();
                        });
                    });
                } else {
                    layer.msg(rep.content, {icon: 7, time: 2000});
                }
            }).fail(function (rep) {
                console.log(rep);
            });
            return false;
        });

        function treeReload(){
            let categoryTree = tree.render({
                elem: '#categoryTree',
                data: rep.content,
                text: {
                    defaultNodeName: '未命名',
                    none: '无数据或数据加载失败'
                },
                accordion: true,
                click: function (obj) {
                    fromDisabled();
                    $('#updateCategory').addClass('layui-btn-disabled');
                    $('#addCategory').addClass('layui-btn-disabled');
                    form.val('category', {
                        "id": obj.data.id,
                        "title": obj.data.title,
                        "pid": obj.data.pid,
                        "level": obj.data.level,
                        "root": obj.data.pid === 0
                    });
                }
            });
        }

        form.verify({
            title: function (value,item) {
                if (!new RegExp("^[\\s\\S]*.*[^\\s][\\s\\S]*$").test(value)){
                    return "标题不能为空";
                }
            },
            pid:function (value,item) {
                if (!new RegExp("[/^[0-9]*$").test(value)){
                    return "pid数值非法"
                }
                if (!new RegExp("^[\\s\\S]*.*[^\\s][\\s\\S]*$").test(value)){
                    return "pid不能为空";
                }
            },
            level: function (value,item) {
                if (!new RegExp("[/^[0-9]*$").test(value)){
                    return "level数值非法"
                }
                if (!new RegExp("^[\\s\\S]*.*[^\\s][\\s\\S]*$").test(value)){
                    return "level不能为空";
                }
            }
        });

    });


</script>


</body>
</html>
