<%--
  Created by IntelliJ IDEA.
  User: windows
  Date: 2020/5/28
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>ok-admin v2.0 | 很赞的后台模版</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="ok-admin v2.0,ok-admin网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="ok-admin v2.0，顾名思义，很赞的后台模版，它是一款基于Layui框架的轻量级扁平化且完全免费开源的网站后台管理系统模板，适合中小型CMS后台系统。">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/static/css/oksub.css" media="all"/>
    <script type="text/javascript" src="/static/lib/loading/okLoading.js"></script>
    <script type="text/javascript" src="/static/lib/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="/static/lib/echarts/echarts.themez.js"></script>
</head>
<body class="console console1 ok-body-scroll">
<div class="ok-body home">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-xs6 layui-col-md3">
            <div class="ok-card layui-card">
                <div class="ok-card-body p0 clearfix cart-data">
                    <div class="data-body">
                        <div class="media-cont">
                            <p class="tit">现存设备</p>
                            <h5 class="num">系统错误</h5>
                        </div>
                    </div>
                    <div id="echIncome" class="line-home-a"></div>
                </div>
            </div>
        </div>

        <div class="layui-col-xs6 layui-col-md3">
            <div class="ok-card layui-card">
                <div class="ok-card-body p0 clearfix cart-data">
                    <div class="data-body">
                        <div class="media-cont">
                            <p class="tit">正在维修</p>
                            <h5 class="num">系统错误</h5>
                        </div>
                    </div>
                    <div id="echGoods" class="line-home-a"></div>
                </div>
            </div>
        </div>

        <div class="layui-col-xs6 layui-col-md3">
            <div class="ok-card layui-card">
                <div class="ok-card-body p0 clearfix cart-data">
                    <div class="data-body">
                        <div class="media-cont">
                            <p class="tit">已经报废</p>
                            <h5 class="num">系统错误</h5>
                        </div>

                    </div>
                    <div id="echBlogs" class="line-home-a"></div>
                </div>
            </div>
        </div>

        <div class="layui-col-xs6 layui-col-md3">
            <div class="ok-card layui-card">
                <div class="ok-card-body p0 clearfix cart-data">
                    <div class="data-body">
                        <div class="media-cont">
                            <p class="tit">正在申购</p>
                            <h5 class="num">系统错误</h5>
                        </div>
                    </div>
                    <div id="echUser" class="line-home-a"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="ok-card-title">实验室设备开支</div>
                </div>
                <div class="ok-card-body map-body">
                    <div style="height: 100%;" id="deviceIOChart"></div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="ok-card-title">实验室设备及类型</div>
                </div>
                <div class="ok-card-body map-body">
                    <div style="height: 100%;" id="deviceCategoryChart"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="ok-card-title">实验室设备类型及价值(元)</div>
                </div>
                <div class="ok-card-body clearfix">
                    <div class="map-china" id="deviceValueDataChart"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript" src="/static/lib/layui/layui.js"></script>
<script type="text/javascript" src="/static/js/console1.js"></script>
