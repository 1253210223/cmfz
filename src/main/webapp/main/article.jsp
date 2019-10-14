<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<script>
    $(function () {
        $("#articleList").jqGrid({
            url: "${path}/article/queryAll",
            datatype: "json",
            colNames: ["主键", "标题", "内容", "创建时间", "作者", "状态", "操作"],
            colModel: [
                {name: "id"},
                {name: "title"},
                {name: "content", hidden: true},
                {name: "createDate", formatter: "date"},
                {name: "author"},
                {name: "status"},
                {
                    name: "",
                    formatter: function (a, b, c) {
                        return "<a  href='#' onclick=\"lookModal('" + c.id + "')\" >查看详情</a>"
                    }
                }
            ],
            styleUI: "Bootstrap",
            autowidth: true,
            height: "60%",
            pager: "#articlePager",
            page: 1,
            rowNum: 2,
            multiselect: true,
            rowList: [2, 4, 6],
            viewrecords: true
        })
    });

    function showModal() {
        $("#myModal").modal('show');//显示模态框
        $("#addArticleFrom")[0].reset();//清空form表单里的内容
        KindEditor.html("#editor", "");//清空文本内容
        KindEditor.create('#editor', {
            uploadJson: "${path}/kindeditor/upload",//上传文件的路径
            filePostName: "img",//后台接收文件的名字
            allowFileManager: true,
            fileManagerJson: "${path}/kindeditor/allImages",
            afterBlur: function () {
                this.sync();
            }
        });
        $("#modal_footer").html(
            "<button type=\"button\" onclick=\"addArticle()\" class=\"btn btn-primary\">添加</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        )

    }

    function addArticle() {
        $.ajax({
            url: "${path}/article/add",
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                $("#myModal").modal('toggle');//添加完后消失
                $("#articleList").trigger("reloadGrid");//自动刷新
            }
        })
    }


    function lookModal(id) {
        $("#myModal").modal('show');//展示模态框
        $("#addArticleFrom")[0].reset();//清空form表单里的内容
        KindEditor.html("#editor", "");//清空文本内容
        var vlaue = $("#articleList").jqGrid("getRowData", id);
        $("#title").val(vlaue.title);
        $("#author").val(vlaue.author);
        $("#status").val(vlaue.status);
        $("#modal_footer").html(
            "<button type=\"button\" onclick=\"updateArticle('" + id + "')\" class=\"btn btn-primary\">修改</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        );

        KindEditor.create('#editor', {
            uploadJson: "${path}/kindeditor/upload",
            filePostName: "img",
            allowFileManager: true,
            fileManagerJson: "${path}/kindeditor/allImages",
            afterBlur: function () {
                this.sync();//失去焦点后，将文本域中的内容提交给form表单，然后由form表单提交给后台
            }
        });
        KindEditor.appendHtml("#editor", vlaue.content);
    }

    function updateArticle(id) {
        $.ajax({
            url: "${path}/article/update?id=" + id,
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                $("#myModal").modal('toggle');//修改完后消失
                $("#articleList").trigger("reloadGrid");//自动刷新
            }
        })
    }


</script>

<div>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                  data-toggle="tab">文章列表</a></li>
        <li role="presentation"><a href="#profile" onclick="showModal()" aria-controls="profile" role="tab"
                                   data-toggle="tab">添加文章</a></li>
    </ul>

</div>


<table id="articleList"></table>
<div id="articlePager"></div>

<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="width:750px">
            <!--模态框标题-->
            <div class="modal-header">
                <!--
                    用来关闭模态框的属性:data-dismiss="modal"
                -->
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">编辑用户信息</h4>
            </div>

            <!--模态框内容体-->
            <div class="modal-body">
                <form action="${path}/article/editArticle" class="form-horizontal"
                      id="addArticleFrom">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-5">
                            <input type="text" name="title" id="title" placeholder="请输入标题" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">作者</label>
                        <div class="col-sm-5">
                            <input type="text" name="author" id="author" placeholder="作者姓名" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">状态</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="status" id="status">
                                <option value="0">展示</option>
                                <option value="1">不展示</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea id="editor" name="content" style="width:700px;height:300px;"></textarea>
                        </div>
                    </div>
                    <input id="addInsertImg" name="insertImg" hidden>
                </form>
            </div>
            <!--模态页脚-->
            <div class="modal-footer" id="modal_footer">
                <%--<button type="button" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>--%>
            </div>
        </div>
    </div>
</div>
