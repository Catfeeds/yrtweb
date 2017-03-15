<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/css/masterNew.css" rel="stylesheet" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>首页管理</a></li>
		<li><a>图片管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
			</div>
			<div class="box-content">
			<div class="index_photos" style="background-color: #fff;">
                 <div class="showPhotos">
	                 <c:forEach var="i" begin="1" end="9">
	                 	<c:set var="flag1" value="1" />
	                 	<c:forEach items="${images.items}" var="img" varStatus="status">
	                 	<c:if test="${img.sort==i}">
	                 	<c:set var="flag1" value="2" />
	                 	<img src="${el:filePath(img.f_src,img.to_oss)}" sort="${i}" onclick="select_iv_info('${img.iid}','${i}')" class="new_ph the_${i}" />
	                 	</c:if>
	                 	</c:forEach>
	                 	<c:if test="${flag1!=2}">
					    <img src="" sort="${i}" onclick="select_iv_info('','${i}')" class="new_ph the_${i}" />
						</c:if>
	                 </c:forEach>
                     <div class="clearfix"></div>
                 </div>
             </div>
             </div>
             <!-- <div class="form-actions" align="center">
				<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
				<a class="btn" onclick="ListPage.paginate()">取消</a>
			 </div> -->
		</div>
	</div><!--/col-->
</div><!--/row-->
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
var iframeIvInfo;
function select_iv_info(iid,sort){
	iframeIvInfo = layer.open({
	    type: 2,
	    title: '选择图片',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&type=image&sort='+sort //iframe的url
	}); 
}

function changeImage(iid,ivid,sort){
	if(sort&&ivid){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addFieldValue',
			data: {id:iid,oth_id:ivid,type:'image',sort:sort},
			cache: false,
			success: function(result){
				layer.close(iframeIvInfo);
				if (result.state=='success') {
					layer.msg("添加成功",{icon: 1});
					ListPage.enter();
                } else {
                	layer.msg("添加失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}
}
</script>
