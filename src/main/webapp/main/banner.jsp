<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script>

    $(function () {
        $("#bannerList").jqGrid({
            styleUI: "Bootstrap",//以bootStrap展示表格
            url: "${path}/banner/selectByPage",
            datatype: "json",
            autowidth: true,//全屏展示
            caption: "轮播图管理",
            pager: "#bannerPage",//展示共几页
            height: "60%",//高度占比
            rowNum: 3,//起始展示的条数
            rowList: [3, 6, 9],//可选每页展示的条数
            viewrecords: true,//右下角，展示总条数
            multiselect: true,//展示全选框，批量删除
            editurl: "${path}/banner/edit",
            cellEdit: false,
            colNames: ["主键", "标题", "状态", "描述", "创建日期", "图片路径"],
            colModel: [
                {
                    name: "id", hidden: true
                },
                {
                    name: "title", editable: true
                },
                {
                    name: "status", editable: true, edittype: "select", editoptions: {value: "0:展示;1:不展示"}
                },
                {
                    name: "des", editable: true
                },
                {
                    name: "create_date"
                },
                {
                    name: "imgPath", editable: true,
                    edittype: "file",
                    formatter: function (a, b, c) {
                        return "<img style='width: 100px;height: 30px' src='${path}/img/" + a + "'>"
                    }
                },
            ],
        }).jqGrid("navGrid", "#bannerPage",
            {
                //处理页面记得按钮的样式
                search: false
            },
            {
                //在编辑之前或者之后进行额外的操作
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#title").attr("readonly", true);
                    obj.find("#imgPath").attr("disabled", true);
                }

            },
            {
                //在添加数据之前或者之后进行额外的操作
                closeAfterAdd: true,//小窗口自动关闭
                afterSubmit: function (response) {
                    var bannerId = response.responseText;
                    $.ajaxFileUpload({
                        url: "${path}/banner/upload",
                        //需要上传文件域的Id
                        fileElementId: "imgPath",
                        data: {bannerId: bannerId},
                        success: function (data) {
                            $("#bannerList").trigger("reloadGrid")//自动刷新

                        }
                    });
                    return response
                }
            },
            {
                //在删除数据之前或者之后进行额外的操作
            }
        )
        /*$("#update").click(function () {
            var gr=$("#bannerList").jqGrid('getGridParam','selrow');
            if(gr !=null){
                $("#bannerList").jqGrid('getGridParam',gr,{
                    height:300,
                    reloadAfterSubmit:false
                });
            else
                alert("Please Select Row");
            }
        })*/

    })

    function out() {
        location.href = "${path}/banner/Easypoi";
    }

</script>

<div>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                  data-toggle="tab">轮播图列表</a></li>
        <li role="presentation"><a href="#profile" onclick="out()" aria-controls="profile" role="tab" data-toggle="tab">导出所有信息</a>
        </li>
    </ul>

</div>

<table id="bannerList"></table>
<div id="bannerPage"></div>