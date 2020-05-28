<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/19
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<div class="layui-row">
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">设备类型</label>
            <div class="layui-input-inline">
                <select name="level1" lay-filter="level1" lay-verify="required">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="level2" lay-filter="level2" lay-verify="required">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="level3" lay-filter="level3" lay-verify="required">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
    </form>
</div>

</body>
<script>
    $.post('',{"pid":0},function (data) {
        if (data.message === "success"){
            let html = "";
            if (data.content != null){
                $.each(data.content,function (index,item) {
                    html += "<option value='" + item.id + "'>" + item.title + "</option>"
                });

                $("select[name=level1]").append(html);

                form.render('select')
            }else {
                layer.msg(data.content, {icon: 7, time: 2000});
            }
        }
    });

    form.on('select(level1)',function (data) {
        let level2 = $('select[name=level2]');
        let html = '<option value="">请选择</option>';
        let level3 = $('select[name=level3]');
        level2.html(html);
        level3.html(html);
        $.post('',{"pid":data.value},function (data) {
            if (data.message === "success"){
                html = "";
                if (data.content != null){
                    $.each(data.content,function (index,item) {
                        html += "<option value='" + item.id + "'>" + item.title + "</option>"
                    })
                }
                level2.append(html);
                form.render('select')
            }else{
                layer.msg(data.content, {icon: 7, time: 2000});
            }
        });

    });

    form.on('select(level2)',function (data) {
        let level3 = $('select[name=level3]');
        let html = '<option value="">请选择</option>';
        level3.html(html);
        $.post('',{"pid":data.value},function (data) {
            if (data.message === "success"){
                html = "";
                if (data.content != null){
                    $.each(data.content,function (index,item) {
                        html += "<option value='" + item.id + "'>" + item.title + "</option>"
                    })
                }
                level3.append(html);
                form.render('select')
            }else{
                layer.msg(data.content, {icon: 7, time: 2000});
            }
        });

    });
</script>
</html>



<div class="layui-form-item">
    <label class="layui-form-label">数量</label>
    <div class="layui-input-block">
        <input type="text" name="count" placeholder="请输入数量" autocomplete="off"
               class="layui-input"  lay-verify="required">
    </div>
</div>

<div class="layui-form-item">
    <label class="layui-form-label">生产厂家</label>
    <div class="layui-input-block">
        <input type="text" name="factory" placeholder="请输入单价" autocomplete="off" class="layui-input"
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