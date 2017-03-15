<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a>市场球员</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="auctionForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${auctionForm.id}"/>
			<input type="hidden" name="s_id" value="${leagueCfg.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员</span>
						<input type="text" name="user_name" class="ui_timepicker form-control" value="${player.username}" readonly="readonly">
						<input type="hidden" name="user_id" id="user_id" value="${auctionForm.user_id}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">初始竞拍价</span>
						<input type="text" name="init_price" value="${auctionForm.init_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">得拍价</span>
						<input type="text" name="bid_price"  class="form-control" value="${auctionForm.bid_price}" readonly="readonly">
						<input type="hidden" name="bidder" value="${auctionForm.bidder}"/>
						<input type="hidden" name="r_id" value="${auctionForm.r_id}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">到期时间</span>
					<input type="text" name="end_time" class="ui_timepicker form-control" value="<fmt:formatDate value='${auctionForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">竞拍轮次</span>
					<select class="form-control" name="turn_num" onchange="getCfg('${leagueCfg.id}',this);">
						<option value="">请选择</option>
						<c:forEach items="${cfgList}" var="cfg">
							<option value="${cfg.turn_num}" <c:if test="${cfg.turn_num eq auctionForm.turn_num}">selected</c:if>>${cfg.turn_num}</option>
						</c:forEach>
					</select>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否选中</span>
					<yt:dictSelect name="status" nodeKey="status" value="${auctionForm.status}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否流拍</span>
					<yt:dictSelect name="if_sold" nodeKey="status" value="${auctionForm.if_sold}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否上架</span>
					<yt:dictSelect name="if_up" nodeKey="status" value="${auctionForm.if_up}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script src="${ctx}/resources/js/Utils.js"></script>
<script type="text/javascript">
    $(function () {
        $(".ui_timepicker").datetimepicker({
            //showOn: "button",
            //buttonImage: "./css/images/icon_calendar.gif",
            //buttonImageOnly: true,
            showSecond: true,
            timeFormat: 'hh:mm:ss',
            stepHour: 1,
            stepMinute: 1,
            stepSecond: 1
        })
    })
    
    function getCfg(id,dom){
    	var num = $(dom).val();
    	if(num != ''){
    		$.ajax({
    			type: 'POST',
    			url: base+"/admin/auction/queryCfgs",
    			data:{"cfg_id":id,"turn_num":num,"user_id":$("#user_id").val()},
    			dataType:"JSON",
    			success: function(data){
    				if(data.state=='error'){	
    					layer.msg(data.message.error[0]);
    				}else{
    					$("input[name='end_time']").val(Filter.formatDate(data.data.end_time,"yyyy-MM-dd hh:mm:ss"));
    					getRandom(data.data.init_price,data.data.add_price);
    				}
    			},
    			error: $.ajaxError
    		});	
    	}else{
    		$("input[name='end_time']").val("");
    		$("input[name='init_price']").val(0);
    	}
    	
    }
    
    function getRandom(i,j){
    	var r = 0;
    	var price = fRandomBy(1, (j/100),"int");
    	r = parseInt(i)+parseInt(price*100);
    	$("input[name='init_price']").val(r);
    }
    </script>
