<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; utf-8" %>
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

    <script src="kindeditor-all-min.js"></script>
    <script src="lang/zh-CN.js"></script>

    <script>
        KindEditor.ready(function (k) {
            window.editor = k.create('#editor_id', {
                uploadJson: "${path}/kindeditor/upload",//上传文件的路径
                filePostName: "img",//后台接收的文件的名字
                allowFileManager: true,//是否显示文件管理
                fileManagerJson: "${path}/kindeditor/allImages"//路径
            });
        });
    </script>
</head>
<body>
<textarea id="editor_id" name="content" style="width:700px;height:300px;">
        &lt;strong&gt;HTML内容&lt;/strong&gt;
    </textarea>

</body>
</html>