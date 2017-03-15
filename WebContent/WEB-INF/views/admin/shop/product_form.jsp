<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">产品管理</a></li>
		<li><a href="">产品编辑</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="productEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="product_id" value="${product.product_id}"/>
			<input type="hidden" name="product_status" value="${product.product_status}"/>
			<input type="hidden" name="product_type" value="user"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品分类</span>
					<input type="hidden" id="category_id" name="category_id" value="${product.category_id}"/>
					<input id="parent_name" name="parent_name" type="text" value="${parent_name}" onkeyup="clean_input(this)" valid="require"  class="form-control">
					<div id="select_tree" style="display:none;position:absolute;background:#fff none repeat scroll 0 0;border:1px solid #e5e5e5;cursor:pointer;z-index:5;"></div>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品货号</span>
					<input type="text" name="product_no" value="${product.product_no}" valid="require len(1,50)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品标题</span>
					<input type="text" name="product_title" value="${product.product_title}" valid="require len(1,100)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品简介</span>
					<%-- <input type="text" name="product_second_title" value="${product.product_second_title}" valid="require len(1,1000)" style="width: 600px;" class="form-control"> --%>
					<textarea name="product_second_title" placeholder="最多输入500个字" valid="require len(1,1000)" class="form-control">${product.product_second_title}</textarea>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品头像</span>
					<div id="product_header_img">
                 		<c:if test="${!empty product.product_header}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${product.product_header}">
                  			<input type="hidden" name="product_header" value="${product.product_header}">
               			</div>
             			</c:if>
                   	</div>
				</div>
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;请上传一张头像(图片大小不能大于2M)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品轮播</span>
                   	<div id="product_banner_img">
						<c:if test="${!empty product.product_banner}">
						<c:forEach items="${fn:split(product.product_banner, ',')}" var="banner" >
               			<div class="fileUploader-item">
               				<img src="${el:headPath()}${banner}">
                  			<input type="hidden" name="product_banner" value="${banner}">
               			</div>
               			</c:forEach>
             			</c:if>
                    </div>
				</div>
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;请至少上传一张轮播图片，最多上传4张(图片大小不能大于2M)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品详情</span>
					<div id="product_desc_img">
						<c:if test="${!empty product.product_desc}">
						<c:forEach items="${fn:split(product.product_desc, ',')}" var="descs">
               			<div class="fileUploader-item">
               				<img src="${el:headPath()}${descs}">
                  			<input type="hidden" name="product_desc" value="${descs}">
               			</div>
               			</c:forEach>
             			</c:if>
                    </div>
				</div>
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;请至少上传一张详情图片，最多上传10张(图片大小不能大于2M)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品进价</span>
					<input type="text" name="product_in_price" value="<fmt:formatNumber value="${empty product.product_in_price?0:product.product_in_price}" pattern="##0.0#"/>" valid="require number" class="form-control">
				</div>	
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;人民币(RMB)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">夺宝单价</span>
					<select class="form-control" id="product_single_price" name="product_single_price" onchange="reckonTotalCount()">
						<option value="0">0</option>
						<option value="100">100</option>
						<option value="200">200</option>
						<option value="500">500</option>
						<option value="1000">1000</option>
						<option value="5000">5000</option>
						<option value="10000">10000</option>
					</select>
					<script type="text/javascript">$("#product_single_price").val('<fmt:formatNumber value="${empty product.product_single_price?0:product.product_single_price}" pattern="##0"/>')</script>
				</div>	
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;宇币(YB)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">夺宝总价</span>
					<input id="product_total_price" type="text" onkeyup="reckonTotalCount()" name="product_total_price" value="<fmt:formatNumber value="${empty product.product_total_price?0:product.product_total_price}" pattern="##0.0#"/>" valid="require number" class="form-control">
				</div>	
				<span style="font-size: 12px;color:#888;">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;人民币(RMB)</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">&emsp;溢价率</span>
					<select class="form-control" id="product_rate" name="product_rate" onchange="reckonTotalCount(1)">
						<option value="1">0</option>
						<option value="1.1">10%</option>
						<option value="1.15">15%</option>
						<option value="1.2">20%</option>
					</select>
					<script type="text/javascript">$("#product_rate").val('${empty product.product_rate?1:product.product_rate}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">溢后总价</span>
					<input id="product_final_price" type="text"  name="product_final_price" value="<fmt:formatNumber value="${empty product.product_final_price?0:product.product_final_price}" pattern="##0.0#"/>" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">总需人次</span>
					<input type="text" id="product_total_count" name="product_total_count" value="${empty product.product_total_count?0:product.product_total_count}" valid="require numberByZero" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否推荐</span>
					<select class="form-control" id="product_recommend" name="product_recommend" >
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
					<script type="text/javascript">$("#product_recommend").val('${empty product.product_recommend?0:product.product_recommend}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">推荐排序</span>
					<input type="text" name="product_recommend_sort" value="${empty product.product_recommend_sort?0:product.product_recommend_sort}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否热销</span>
					<select class="form-control" id="product_hot" name="product_hot" >
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
					<script type="text/javascript">$("#product_hot").val('${empty product.product_hot?0:product.product_hot}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">&emsp;关键字</span>
					<input type="text" name="product_keyword" value="${product.product_keyword}" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品备注</span>
					<%-- <input type="text" name="product_second_title" value="${product.product_second_title}" valid="require len(1,1000)" style="width: 600px;" class="form-control"> --%>
					<textarea name="product_remark" placeholder="最多输入500个字" valid="len(0,1000)" class="form-control">${product.product_remark}</textarea>
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submitByMore()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
ListPage.select_tree("#select_tree",{
	url:'${ctx}/admin/shop/queryCategorys',
	params:{},
	name:'category_name',
	idKey:'category_id',
	pIdKey:'parent_id',
	input_id:'parent_name'
},function(e,tid,treeNode){
	$("#category_id").val(treeNode.category_id);
	$("#parent_name").val(treeNode.category_name);
	$("#select_tree").hide();
});

function clean_input(dom){
	$(dom).val('');
	$("#category_id").val('');
}

$('#product_header_img').fileUploader($.extend({},ListPage.uploadFile(80,1,2,'product_picture'),{inputName:'product_header'}));
$('#product_banner_img').fileUploader($.extend({},ListPage.uploadFile(80,4,2,'product_picture'),{inputName:'product_banner'}));
$('#product_desc_img').fileUploader($.extend({},ListPage.uploadFile(80,10,2,'product_picture'),{inputName:'product_desc'}));

function mul(a, b) {
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {}
    try {
        c += e.split(".")[1].length;
    } catch (f) {}
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}

function div(a, b) {
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {}
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {}
    return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), c / d * Math.pow(10, f - e);
}

function reckonTotalCount(type){
	var sin = $("#product_single_price").val();
	var tot = $("#product_total_price").val();
	var rate = $("#product_rate").val();
	var t = $("#product_total_price").val();
	if(sin && sin>0 && tot && tot>0){
		tot = mul(tot,rate);
		var count = div(tot,div(sin,100));
		$("#product_total_count").val(count);
	}else{
		$("#product_total_count").val(0);
	}
	$("#product_final_price").val(mul(t,rate));
}
</script>