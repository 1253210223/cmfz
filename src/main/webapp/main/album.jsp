<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script>
    $(function () {
        $("#albumList").jqGrid({
            styleUI: "Bootstrap",//以bootStrap展示表格
            url: "${pageContext.request.contextPath}/album/findAll",
            datatype: "json",
            autowidth: true,//全屏展示
            caption: "专辑管理",
            pager: "#albumPager",//展示共几页
            height: "60%",//高度占比
            rowNum: 3,//起始展示的条数
            rownumbers: true,
            rowList: [3, 6, 9],//可选每页展示的条数
            viewrecords: true,//右下角，展示总条数
            multiselect: true,//展示全选框，批量删除
            editurl: "${path}/album/edit",
            cellEdit: false,
            colNames: ["主键", "标题", "分数", "作者", "播音", "集数", "内容简介", "发布日期", "封面路径"],
            colModel: [
                {
                    name: "id", hidden: true
                },
                {
                    name: "title", editable: true
                },
                {
                    name: "score", editable: true
                },
                {
                    name: "author", editable: true
                },
                {
                    name: "beam", editable: true
                },
                {
                    name: "count", editable: true
                },
                {
                    name: "content", editable: true
                },
                {
                    name: "publishDate"
                },
                {
                    name: "cover", editable: true,
                    edittype: "file",
                    formatter: function (a, b, c) {
                        return "<img style='width: 100px;height: 30px' src='${path}/img/" + a + "'>"
                    }
                },
            ],
            subGrid: true,
            subGridRowExpanded: function (subgrid_id, albumId) {
                addSubGrid(subgrid_id, albumId);
            }
        }).jqGrid("navGrid", "#albumPager",
            {
                //处理页面记得按钮的样式
                search: false
            },
            {
                //在编辑之前或者之后进行额外的操作
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#cover").attr("disabled", true);//让路径不可点击
                    obj.find("#score").attr("disabled", true);//让分数不可点击
                }

            },
            {
                //在添加数据之前或者之后进行额外的操作
                closeAfterAdd: true,//小窗口自动关闭
                afterSubmit: function (response) {
                    var bannerId = response.responseText;
                    $.ajaxFileUpload({
                        url: "${path}/album/upload",
                        //需要上传文件域的Id
                        fileElementId: "cover",
                        data: {bannerId: bannerId},
                        success: function (data) {
                            $("#albumList").trigger("reloadGrid")//自动刷新

                        }
                    });
                    return response
                }
            },
            {
                //在删除数据之前或者之后进行额外的操作
            }
        )
    });

    function addSubGrid(subgrid_id, albumId) {
        var tableId = subgrid_id + "table";
        var divId = subgrid_id + "div";
        $("#" + subgrid_id).html(
            "<table id='" + tableId + "'></table>" + "<div id='" + divId + "'></div>"
        );
        $("#" + tableId).jqGrid({
            styleUI: "Bootstrap",//以bootStrap展示表格
            url: "${path}/chapter/findAll?albumid=" + albumId,
            datatype: "json",
            autowidth: true,//全屏展示
            pager: "#" + divId,//展示共几页
            height: "60%",//高度占比
            rowNum: 3,//起始展示的条数
            rownumbers: true,
            rowList: [3, 6, 9],//可选每页展示的条数
            viewrecords: true,//右下角，展示总条数
            multiselect: true,//展示全选框，批量删除
            editurl: "${path}/chapter/edit?albumid=" + albumId,
            cellEdit: false,
            colNames: ["主键", "标题", "体积大小", "时长", "状态", "音频路径", "操作"],
            colModel: [
                {
                    name: "id", hidden: true
                },
                {
                    name: "title", editable: true
                },
                {
                    name: "size"
                },
                {
                    name: "timeLong"
                },
                {
                    name: "status", editable: true, edittype: "select", editoptions: {value: "0:展示;1:不展示"}
                },
                {
                    name: "filePath", editable: true,
                    edittype: "file",
                },
                {
                    name: "filePath",
                    formatter: function (cellValue, options, rowObject) {
                        return "<a onclick=\"playAudio('" + cellValue + "')\" href='#'><span class='glyphicon glyphicon-play-circle'></span></a>" + "                       " +
                            "<a onclick=\"downloadAudio('" + cellValue + "')\" href='#'><span class='glyphicon glyphicon-download'></span></a>"
                    }
                }
            ],
        }).jqGrid("navGrid", "#" + divId,
            {
                //处理页面记得按钮的样式
                search: false
            },
            {
                //在编辑之前或者之后进行额外的操作
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#filePath").attr("disabled", true);
                }

            },
            {
                //在添加数据之前或者之后进行额外的操作
                closeAfterAdd: true,
                afterSubmit: function (response) {
                    var chapterId = response.responseText;
                    $.ajaxFileUpload({
                        url: "${path}/chapter/upload?albumid=" + albumId,
                        fileElementId: "filePath",
                        data: {chapterId: chapterId},
                        success: function (data) {
                            $("#" + tableId).trigger("reloadGrid");
                            $("#albumList").trigger("reloadGrid");
                        }
                    });
                    return response
                }
            },
            {
                //在删除数据之前或者之后进行额外的操作
                afterSubmit: function () {
                    $("#" + tableId).trigger("reloadGrid");
                    $("#albumList").trigger("reloadGrid");
                    return "adf";
                }
            }
        )
    }

    function playAudio(d) {
        $("#dialogId").modal("show");
        $("#audioId").attr("src", "${path}/audio/" + d);
    }

    function downloadAudio(a) {
        location.href = "${path}/chapter/download?audioName=" + a;
    }

</script>

<div id="dialogId" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <audio id="audioId" controls src=""></audio>
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<table id="albumList"></table>
<div id="albumPager"></div>