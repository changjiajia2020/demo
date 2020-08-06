<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布视频</title>

    <!-- 引入bootstrap css文件 -->
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.dropdown.hack.css" rel="stylesheet" />
    <!-- 引入bootstrap js文件 -->
    <script src="<%=request.getContextPath()%>/bootstrap/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>

    <!-- 引入bootbox相关js -->
    <script src="<%=request.getContextPath()%>/js/bootbox/bootbox.locales.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/bootbox/bootbox.min.js" type="text/javascript"></script>

    <!-- 引入fileinput文件上传插件的css文件和js文件 -->
    <link href="<%=request.getContextPath()%>/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet" />
    <script src="<%=request.getContextPath()%>/js/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap-fileinput/js/locales/zh.js"></script>


    <!-- 引入datatables表格插件的css文件和js文件 -->
    <link href="<%=request.getContextPath()%>/js/DataTables/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <script src="<%=request.getContextPath()%>/js/DataTables/js/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/DataTables/js/dataTables.bootstrap.min.js"></script>

    <!-- 引入datetimepicker日期插件的css文件和js文件 -->
    <link href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<h2>hello world</h2>
<br/>
<script>
    //页面加载事件
    $(function () {
        //初始化上传插件
        initFileInput();

    })

    function initFileInput() {
        //初始化文件域	#id 与下面保持一致
        $("#addVideoForm #avatar").fileinput({
            language:"zh",
            allowedFileTypes:["image"],
            maxFileCount:1,
            //设置上传文件的地址
            uploadUrl:"<%=request.getContextPath()%>/videoController/uploadFile.do"
        });

        //用于文件上传结果处理的回调函数，每上传一个文件就会调用一下这个函数
        $("#addVideoForm #avatar").on("fileuploaded",function(event,data,preView,index){
            //获取服务器返回的数据
            var result = data.response;
            if(result.success){
                $("#addVideoForm #imgPath").val(result.filePath);
                $("#addVideoForm #avatarImg").attr("src","<%=request.getContextPath()%>/" + result.filePath);
                //				alert(result.filePath)

            }else{
                alert("文件上传过程中出现异常，请联系管理员！");
            }
        });
    }
    //ajax请求 保存数据
    function savaData() {
        //取值
        var title=$("#title").val();
// 将路径保存在数据库中，而不是图片本身
        var path=$("#imgPath").val();
        //发起ajax请求
        /**
         *      $.get() 方法使用GET方法来进行异步请求的。$.post() 方法使用POST方法来 进行异步请求的。
         */
        $.post({
            url:"videoController/addVideo.do",
            data:{"title":title,"imgPath":path},
            dataType:"json",
            success:function (data) {
                location.href="/success.jsp";
            },error:function () {
                alert("发布数据失败");
            }
        });


    }

</script>
<body>
<br>
<div id="addVideoDiv">
    <form class="form-horizontal" id="addVideoForm">
        <div class="form-group">
            <label for="title" class="col-sm-2 control-label">主题</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="title"
                       placeholder="请输入主题">
            </div>
        </div>

        <div class="form-group">
            <label for="firstname" class="col-sm-2 control-label">图片</label>
            <div class="col-sm-8">
                <!-- 用于存放图片上传成功之后的相对路径的隐藏域  name="imgPath"重点！！！！！！！！！！！！-->
                <input type="text" id="imgPath" name="imgPath"/>
                <!-- 图片 -->
                <img id="avatarImg" style="width:50px">
                <input type="file" class="form-control" name="image" id="avatar" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" onclick="savaData()" class="btn btn-default">发布</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>

