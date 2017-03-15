<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">产品管理</a></li>
		<li><a href="">分类列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/shop/category/formJsp','#categoryEditForm','${ctx}/admin/shop/category/saveOrUpdate')" 
					style="cursor: pointer;">添加分类</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>分类名称: <input type="text" name="category_name" value="${params.category_name}"></label>
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
				<table id="category_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>分类名称</th>
							  <th>上级分类</th>
							  <th>分类头像</th>
							  <th>排序</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="pc">
						<tr>
							<td>${pc.category_name}</td>
							<td>${pc.parent_name}</td>
							<td>
							<div style="width: 60px;height: 60px;cursor: pointer;">
							<img src="${el:filePath(pc.category_header,'1')}" alt="无" onclick="showImage(this)"/>
							</div>
							</td>
							<td>${pc.category_sort}</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/shop/category/formJsp','#categoryEditForm','${ctx}/admin/shop/category/saveOrUpdate','${pc.category_id}')">
									<i class="fa fa-edit "> 修改</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/shop/category/delete','${pc.category_id}')">
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
<script type="text/javascript">
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

$(function(){
	fixImageWH("#category_table");
})
</script>

