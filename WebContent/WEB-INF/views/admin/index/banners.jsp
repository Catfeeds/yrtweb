<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">首页管理</a></li>
		<li><a href="">轮播管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/indexBannerFormJsp','#indexBannerForm','${ctx}/admin/saveOrUpdateIndexBanner')"
				 	style="cursor: pointer;">添加轮播</a><span class="break"></span></h2>
				<%-- <div class="box-icon">
					<a href="table.html#" class="btn-setting"><i class="fa fa-wrench"></i></a>
					<a href="table.html#" class="btn-minimize"><i class="fa fa-chevron-up"></i></a>
					<a href="table.html#" class="btn-close"><i class="fa fa-times"></i></a>
				</div> --%>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>是否使用: 
								<select id="s_if_use" name="if_use">
									<option value="">全部</option>	
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
								<script type="text/javascript">$("#s_if_use").val('${params.if_use}');</script>
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
				<table id="index_banner_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="width: 230px;">图片</th>
							  <th>链接</th>
							  <th>是否新开窗口</th>
							  <th>是否使用</th>
							  <th>排序</th>
							  <th>创建时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="banners">
						<tr>
							<td>
							<div style="width: 100px;height: 40px;cursor: pointer;">
							<img src="${el:filePath(banners.img_src,'1')}" onclick="showImage(this)"/>
							</div>
							</td>
							<td>${banners.img_path}</td>
							<td>
								<c:if test="${banners.if_blank=='0'}">
								否
								</c:if>
								<c:if test="${banners.if_blank=='1'}">
								是
								</c:if>
							</td>
							<td>
								<c:if test="${banners.if_use=='0'}">
								否
								</c:if>
								<c:if test="${banners.if_use=='1'}">
								是
								</c:if>
							</td>
							<td>${banners.sort}</td>
							<td>${banners.create_time}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/indexBannerFormJsp','#indexBannerForm','${ctx}/admin/saveOrUpdateIndexBanner','${banners.id}')">
									<i class="fa fa-edit "> 编辑</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/deleteIndexBanner','${banners.id}')">
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
fixImageWH("#index_banner_table");

</script>
