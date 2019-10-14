<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

</head>
<body>
<%--为ECharts准备一个具备大小(宽高)的DOM--%>
<div id="main" style="width: 600px;height:400px;"></div>

<script type="text/javascript">
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    //指定图表的配置项和数据
    var option = {
        title: {
            text: '用户近7天折线图'
        },
        tooltip: {},
        legend: {
            data: ['注册量']
        },
        xAxis: {
            data: ["六天前", "五天前", "四天前", "三天前", "两天前", "一天前"]
        },
        yAxis: {},
        series: [{
            name: '注册量',
            type: 'line'
        }]
    };

    //使用刚指定的配置项和数据显示图表
    myChart.setOption(option);

    $.ajax({
        url: "${path}/user/query",
        datatype: "json",
        type: "post",
        success: function (da) {
            myChart.setOption({
                series: [{data: da}]
            });
        }
    });

    /*var goEasy = new GoEasy({
        appkey: "BC-2997b746c3234932ab0e0a9dfbe92782"
        BC-41105467e17d4745869fc7051df656ee
    });
    goEasy.subscribe({
        channel: "cmfz",
        onMessage: function (message) {
            var data = JSON.parse(message.content);
            myChart.setOption({
                series:[{data:data}]
            });
        }
    });*/


</script>

</body>
</html>