<%@page isELIgnored="false" contentType="text/html; utf-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>持名法洲</title>
    <link rel="icon" href="${path}/img/favicon.ico">
    <%--引入bootstrap的css--%>
    <link rel="stylesheet" href="${path}/statics/boot/css/bootstrap.min.css">
    <%--引入bootstrap和jqgrid的核心css--%>
    <link rel="stylesheet" href="${path}/statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <%--引入jquery的css--%>
    <script src="${path}/statics/boot/jquery-3.3.1.min.js"></script>
    <%--引入bootstrap的js--%>
    <script src="${path}/statics/boot/js/bootstrap.min.js"></script>
    <%--引入jqgrid的核心js--%>
    <script src="${path}/statics/jqgrid/js/trirand/src/jquery.jqGrid.js"></script>
    <%--引入jqgridg国际化js--%>
    <script src="${path}/statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="${path}/boot/js/ajaxfileupload.js"></script>

    <script src="${path}/echarts/echarts.min.js"></script>
    <script src="${path}/echarts/china.js"></script>
    <script src=" http://cdn-hangzhou.goeasy.io/goeasy.js"></script>

    <script>

        $(function () {
            $("#myCarousel").carousel({
                interval: 1000,  //毫秒
            })
        })

    </script>

</head>
<body>
<%--导航栏--%>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">持名法洲管理系统</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎:<span style="color: #2e6da4">${sessionScope.username}</span></a></li>
                <li><a href="${path}/admin/adminEsc">退出登陆&nbsp;<span class="glyphicon glyphicon-log-out"></span></a>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<%--手风琴--%>
<div class="container-fluid">
    <div class="row">
        <!--左侧手风琴-->
        <div class="col-sm-2">
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseOne">
                                用户管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse ">
                        <div class="panel-body">
                            <a href="javascript:$('#changeContent').load('echartsMap.jsp')">用户分布图</a>
                        </div>
                        <div class="panel-body">
                            <a href="javascript:$('#changeContent').load('echarts.jsp')">用户近7天注册折线图</a>
                        </div>

                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseTwo">
                                上师管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse">
                        <div class="panel-body">
                            <a href="">上师列表</a>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseThree">
                                文章管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse">
                        <div class="panel-body">
                            <a href="javascript:$('#changeContent').load('article.jsp')">文章列表</a>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseFour">
                                专辑管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse">
                        <div class="panel-body">
                            <a href="javascript:$('#changeContent').load('album.jsp')">专辑列表</a>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion"
                               href="#collapseFive">
                                轮播图管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse">
                        <div class="panel-body">
                            <a href="javascript:$('#changeContent').load('banner.jsp')">轮播图列表</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="changeContent" class="col-sm-10" id="lay-right">
            <div class="jumbotron">
                <h4>欢迎来到持名法洲后台管理系统</h4>
            </div>

            <!--右侧默认轮播图-->
            <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="${path}/img/shouye.jpg" alt="First slide">
                    </div>
                    <%--<div class="item">
                        <img src="${path}/img/A2.jpg" alt="Second slide">
                    </div>--%>
                </div>
                <%--<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                     <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                     <span class="sr-only">Previous</span>
                 </a>
                 <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                     <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                     <span class="sr-only">Next</span>
                 </a>--%>
            </div>
        </div>
    </div>
</div>
<!--模态框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Modal title</h4>
            </div>
            <div class="modal-body">
                <p>One fine body&hellip;</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<%--页脚--%>
<br/>
<div class="panel panel-default">
    <div style="text-align: center" class="panel-body">
        百知教育@zpark.com.cn
    </div>
</div>
</body>
</html>