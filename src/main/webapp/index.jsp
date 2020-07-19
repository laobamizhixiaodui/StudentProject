<%--
  Created by IntelliJ IDEA.
  User: yzw
  Date: 2020/4/11
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ZH-CN">
<head>
    <meta charset="utf-8">
    <title>实验室设备管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="ok-admin v2.0,ok-admin网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="ok-admin v2.0，顾名思义，很赞的后台模版，它是一款基于Layui框架的轻量级扁平化且完全免费开源的网站后台管理系统模板，适合中小型CMS后台系统。">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/okadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/loading/okLoading.css" />
</head>
<body class="layui-layout-body">
<!-- 更换主体 Eg:orange_theme|blue_theme -->
<div class="layui-layout layui-layout-admin okadmin blue_theme">
    <!--头部导航-->
    <div class="layui-header okadmin-header">
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a class="ok-menu ok-show-menu" href="javascript:" title="菜单切换">
                    <i class="layui-icon layui-icon-shrink-right"></i>
                </a>
            </li>
            <!--天气信息-->

            <li class="ok-nav-item ok-hide-md">
                <div class="weather-ok">
                    <iframe frameborder="0" scrolling="no" class="iframe-style" src="${pageContext.request.contextPath}/weather.html" frameborder="0"></iframe>
                </div>
            </li>

        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item ok-input-search">
                <input type="text" placeholder="搜索..." class="layui-input layui-input-search"/>
            </li>
            <li class="layui-nav-item">
                <a class="ok-refresh" href="javascript:" title="刷新">
                    <i class="layui-icon layui-icon-refresh-3"></i>
                </a>
            </li>
            <li class="no-line layui-nav-item layui-hide-xs">
                <a id="notice" class="flex-vc pr10 pl10" href="javascript:">
                    <i class="ok-icon ok-icon-notice icon-head-i" title="系统公告"></i>
                    <span class="layui-badge-dot"></span>s
                    <cite></cite>
                </a>
            </li>

            <li class="no-line layui-nav-item layui-hide-xs">
                <a id="lock" class="flex-vc pr10 pl10" href="javascript:">
                    <i class="ok-icon ok-icon-lock icon-head-i" title="锁屏"></i><cite></cite>
                </a>
            </li>

            <!-- 全屏 -->
            <li class="layui-nav-item layui-hide-xs">
                <a id="fullScreen" class=" pr10 pl10" href="javascript:">
                    <i class="layui-icon layui-icon-screen-full"></i>
                </a>
            </li>

            <li class="no-line layui-nav-item">
                <a href="javascript:">
                    <img src="${pageContext.request.contextPath}/static/images/logo1.jpg" class="layui-nav-img">
                   <%-- ${USER.username}--%>
                </a>
                <dl id="userInfo" class="layui-nav-child">
                    <dd><a href="javascript:void(0)">个人中心</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/logout" id="logout">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <!--遮罩层-->
    <div class="ok-make"></div>
    <!--左侧导航区域-->
    <div class="layui-side layui-side-menu okadmin-bg-20222A ok-left">
        <div class="layui-side-scroll okadmin-side">
            <div class="okadmin-logo">实验室设备管理系统</div>
            <div class="user-photo">
                <a class="img" title="我的头像">
                    <img src="${pageContext.request.contextPath}/static/images/logo1.jpg" class="userAvatar">
                </a>
                <p>你好！<span class="userName"><%--${USER.username}--%></span>, 欢迎登录</p>
            </div>
            <!--左侧导航菜单-->
            <ul id="navBar" class="layui-nav okadmin-nav okadmin-bg-20222A layui-nav-tree">
                <li class="layui-nav-item layui-this">
                    <a href="javascript:" lay-id="1" data-url="/console">
                        <i is-close=false class="ok-icon">&#xe654;</i>
                        控制台
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- 内容主体区域 -->
    <div class="content-body">
        <div class="layui-tab ok-tab" lay-filter="ok-tab" lay-allowClose="true" lay-unauto>
            <div data-id="left" id="okLeftMove"
                 class="ok-icon ok-icon-back okadmin-tabs-control move-left okNavMove"></div>
            <div data-id="right" id="okRightMove"
                 class="ok-icon ok-icon-right okadmin-tabs-control move-right okNavMove"></div>
            <div class="layui-icon okadmin-tabs-control ok-right-nav-menu" style="right: 0;">
                <ul class="okadmin-tab">
                    <li class="no-line okadmin-tab-item">
                        <div class="okadmin-link layui-icon-down" href="javascript:;"></div>
                        <dl id="tabAction" class="okadmin-tab-child layui-anim-upbit layui-anim">
                            <dd><a data-num="1" href="javascript:">关闭当前标签页</a></dd>
                            <dd><a data-num="2" href="javascript:">关闭其他标签页</a></dd>
                            <dd><a data-num="3" href="javascript:">关闭所有标签页</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>

            <ul id="tabTitle" class="layui-tab-title ok-tab-title not-scroll">
                <li class="layui-this" lay-id="1" tab="index">
                    <i class="ok-icon">&#xe654;</i>
                    <cite is-close=false>控制台</cite>
                </li>
            </ul>

            <div id="tabContent" class="layui-tab-content ok-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe src='/console.html' frameborder="0" scrolling="yes" width="100%"
                            height="100%"></iframe>
                </div>
            </div>
        </div>
    </div>

    <!--底部信息-->
    <div class="layui-footer okadmin-text-center">
        Copyright ©2018-©2019 ok-admin v2.0 All Rights Reserved
        <button class="layui-btn layui-btn-danger layui-btn-xs donate">捐赠作者</button>
        <button class="layui-btn layui-btn-danger layui-btn-xs communication">QQ群交流</button>
    </div>
</div>
<div class="yy"></div>
<!--js逻辑-->
<script src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/js/okadmin.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/loading/okLoading.js"></script>
</body>
</html>
