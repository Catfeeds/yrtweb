<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">产品管理</a></li>
		<li><a href="">产品列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/shop/product/formJsp','#productEditForm','${ctx}/admin/shop/product/saveOrUpdate')"
					style="cursor: pointer;">添加商品</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>产品标题: <input type="text" name="product_title" value="${params.product_title}"></label>
							<label>产品货号: <input type="text" name="product_no" value="${params.product_no}"></label>
							<label>产品分类: <input id="category_id" type="hidden" name="category_id" value="${params.category_id}"/><input id="parent_name" name="parent_name" type="text" value="${params.parent_name}" readonly="readonly">
								<div id="select_tree" style="display:none;margin-left:63px;position:absolute;background:#fff none repeat scroll 0 0;border:1px solid #e5e5e5;cursor:pointer;z-index:5;">
								</div>
							</label>
							<label>是否上架: 
								<select id="s_n_product_status" name="product_status">
									<option value="">全部</option>	
									<option value="1">上架</option>
									<option value="0">未上架</option>
								</select>
								<script type="text/javascript">$("#s_n_product_status").val('${params.product_status}');</script>
							</label>
							<label>是否开启: 
								<select id="s_n_product_ifopen" name="product_ifopen">
									<option value="">全部</option>	
									<option value="0">未开启</option>
									<option value="1">开启中</option>
								</select>
								<script type="text/javascript">$("#s_n_product_ifopen").val('${params.product_ifopen}');</script>
							</label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table id="product_list_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>产品分类</th>
							  <th>产品标题</th>
							  <th>封面头像</th>
							  <th>产品货号</th>
							  <th>夺宝单价</th>
							  <th>夺宝总需人次</th>
							  <th>是否推荐</th>
							  <th>是否热销</th>
							  <th>推荐排序</th>
							  <th>备注</th>
							  <th>是否上架</th>
							  <th>是否开启</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="p">
						<tr>
							<td>${p.category_name}</td>
							<td>
							<a title="${p.product_title}" style="cursor: pointer;">
							<c:choose>
				            	<c:when test="${!empty p.product_title&&fn:length(p.product_title)>6}">
				            	${fn:substring(p.product_title, 0, 6)}...
				            	</c:when>
				            	<c:otherwise>
				            	${empty p.product_title?'':p.product_title}
				            	</c:otherwise>
				            </c:choose>
				            </a>
							</td>
							<td>
							<div style="width: 40px;height: 40px;cursor: pointer;">
							<img src="${el:filePath(p.product_header,'1')}" onclick="showImage(this)"/>
							</div>
							</td>
							<td>${p.product_no}</td>
							<td><fmt:formatNumber value="${p.product_single_price}" pattern="##0"/></td>
							<td>${p.product_total_count}</td>
							<td>
								<c:if test="${p.product_recommend=='0'}">
								<span style="color: red;">否</span>
								</c:if>
								<c:if test="${p.product_recommend=='1'}">
								<span style="color: green;">是</span>
								</c:if>
							</td>
							<td>
								<c:if test="${p.product_hot=='0'}">
								<span style="color: red;">否</span>
								</c:if>
								<c:if test="${p.product_hot=='1'}">
								<span style="color: green;">是</span>
								</c:if>
							</td>
							<td>${p.product_recommend_sort}</td>
							<td>
							<a title="${p.product_remark}" style="cursor: pointer;">
							<c:choose>
				            	<c:when test="${!empty p.product_remark&&fn:length(p.product_remark)>6}">
				            	${fn:substring(p.product_remark, 0, 6)}...
				            	</c:when>
				            	<c:otherwise>
				            	${empty p.product_remark?'无':p.product_remark}
				            	</c:otherwise>
				            </c:choose>
				            </a>
							</td>
							<td>
								<c:if test="${p.product_status=='0'}">
								<span style="color: red;">下架</span>
								</c:if>
								<c:if test="${p.product_status=='1'}">
								<span style="color: green;">上架</span>
								</c:if>
							</td>
							<td>
								<c:if test="${p.product_ifopen=='0'}">
								<a class="btn btn-success" onclick="ListPage.confirm('请确认是否开启？','${ctx}/admin/shop/product/openTheProduct',{product_id:'${p.product_id}'})">
									<i class="fa">开启</i>  
								</a>
								</c:if>
								<c:if test="${p.product_ifopen=='1'}">
								<span style="color: green;">开启中</span>
								</c:if>
							</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/shop/product/formJsp','#productEditForm','${ctx}/admin/shop/product/saveOrUpdate','${p.product_id}')">
									<i class="fa fa-edit "> 修改</i>  
								</a>
								<a class="btn btn-info" onclick="product_open('${p.product_id}','${p.product_title}')">
									<i class="fa fa-plus-circle"> 添加商品</i>  
								</a>
								<c:if test="${p.product_status=='0'}">
								<a class="btn btn-success" onclick="ListPage.confirm('请确认是否上架？','${ctx}/admin/shop/product/updateStatus',{id:'${p.product_id}',status:1})">
									<i class="fa fa-arrow-circle-o-up"> 上架</i>  
								</a>
								</c:if>
								<c:if test="${p.product_status=='1'}">
								<a class="btn btn-danger" onclick="ListPage.confirm('请确认是否下架？','${ctx}/admin/shop/product/updateStatus',{id:'${p.product_id}',status:0})">
									<i class="fa fa-arrow-circle-o-down"> 下架</i>  
								</a>
								</c:if>
								<a class="btn btn-info" title="轮次查询" onclick="ListPage.dialog('产品轮次','${ctx}/admin/shop/product/queryProductDatas',{product_id:'${p.product_id}'})">
									<i class="fa fa-list"> 轮次查询</i> 
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/shop/product/delete','${p.product_id}')">
									<i class="fa fa-trash-o "> 删除</i> 
								</a>
							</td>                                       
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<div id="product_open" class="row" style="display: none;width: 100%;height: 100%;margin-left: 0px;margin-right: 0px;">	
	<div class="col-lg-12">
		<div class="box">
			<form id="product_open_form" action="${ctx}/admin/shop/product/openTheProduct" method="post" class="form-horizontal">
			<input type="hidden" name="type" value="1"/>
			<input type="hidden" id="product_id" name="product_id" value=""/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品标题</span>
					<input type="text" id="d_product_title" value="" class="form-control" style="width: 220px;" readonly="readonly">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">添加轮数</span>
					<input type="text" id="d_open_num" name="open_num" valid="require numberByZero" value="0" class="form-control" style="width: 220px;" >
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">剩余轮数</span>
					<input type="text" id="d_have_num" value="0" class="form-control" style="width: 220px;" readonly="readonly">
				</div>	
			</div>
			<div class="form-actions" style="padding: 19px 130px 20px;">
			<a class="btn btn-primary" id="submit_open" onclick="ListPage.submit_dialog();">添加</a>
			<a class="btn" onclick="product_open_cancel()">取消</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div>
<script type="text/javascript">
ListPage.select_tree("#select_tree",{
	url:'${ctx}/admin/shop/queryCategorys',
	name:'category_name',
	idKey:'category_id',
	pIdKey:'parent_id',
	input_id:'parent_name'
},function(e,tid,treeNode){
	$("#category_id").val(treeNode.category_id);
	$("#parent_name").val(treeNode.category_name);
	$("#select_tree").hide();
});
jQuery.fn.center = function () {
	var h = this.height() == 0? 400 :this.height();
    this.css("position", "absolute");
    this.css("top", ($(window).height() - h) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

function fixImageWH(dom) {
	var parent = $(dom);
	var img = parent.find("img");
    var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    if (iw / ih > parent.width() / parent.height()) {
        img.css({
            width: '100%',
            height: 'auto'
        });
    } else {
        img.css({
            width: 'auto',
            height: '100%'
        });
    }
}

fixImageWH("#product_list_table");

var html = $("#product_open").get(0).outerHTML;
var model = $(html);
model.show();
model.attr("id","product_open_1");
model.find("#product_open_form").attr("id","product_open_form_1");
model.find("#product_id").attr("id","product_id_1");
model.find("#d_product_title").attr("id","d_product_title_1");
model.find("#d_open_num").attr("id","d_open_num_1");
model.find("#d_have_num").attr("id","d_have_num_1");
model.find("#submit_open").attr("id","submit_open_1");
var open_index;
function product_open(pid,title){
	$.post(base+'/admin/shop/product/getHaveNum',{pid:pid},function(result){
		if(result.state=="success"){
			open_index = layer.open({
			    type: 1,
			    skin: 'layui-layer-rim', //加上边框
			    area: ['420px', '300px'], //宽高
			    content: model.get(0).outerHTML
			});
			$("#product_id_1").val(pid);
			$("#d_product_title_1").val(title);
			$("#d_have_num_1").val(result.data.have_num);
			ListPage.formid='#product_open_form_1';
		}else{
			if(result.data){
				if(result.data.status=='no'){
				layer.msg("请先上架产品！",{icon: 0});
				}else if(result.data.status=='count'){
					layer.msg("夺宝总需人次必须大于0！",{icon: 0});	
				}
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		}
	});
}
function product_open_cancel(){
	//layer.close(open_index);
	layer.closeAll();
}
</script>
