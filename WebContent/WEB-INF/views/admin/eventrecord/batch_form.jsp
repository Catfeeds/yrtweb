<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>${league.name}</a></li>
		<li><a>赛程导入</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="_itemEditForm" action="${ctx}/admin/eventRecord/uploadFile" method="post" class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" id="league_id" name="league_id" value="${league.id}"/>
			<fieldset class="col-sm-12">	
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">联&emsp;&emsp;赛</span>
							<span class="form-control">${league.name}</span>	
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">分&emsp;&emsp;组</span>
							<select class="form-control" id="group_sel" name="group_id"  valid="require">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">文&emsp;&emsp;件</span>
							<input type="file"  id="file"  name="file" class="form-control"/>
						</div>	
					</div>
					<div class="form-actions">
						<input type="button" name="upload" value="开始上传"class="btn btn-primary" onclick="ajaxUpload();"/> 
						<a class="btn" onclick="ListPage.paginate()">返回</a>
					</div>		
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
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
    });
    
	query_groups('#league_id','${event.group_id}');
})
function query_groups(dom,gid){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/leagueGroup/queryGroupByLid',
		data: {lid: $(dom).val()},
		success: function(data){
			if(data.data.groups&&data.data.groups.length>0){
				$("#group_sel").empty();
				for(i in data.data.groups){
					if(gid&&gid==data.data.groups[i].id){
						$("#group_sel").append('<option selected="selected" value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
						$("#group_sel").attr("disabled",true);
					}else{
						$("#group_sel").append('<option value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
					}
				}
			}else{
				$("#group_sel").empty().append('<option value=""></option>');
			}
		},
		error: $.ajaxError
	});
}

function ajaxUpload(){
	var formData = new FormData();	
	formData.append("file",document.getElementById("file").files[0]);
	formData.append("league_id","${league.id}");
	formData.append("group_id",$("#group_sel").val());
	$.ajax({ 
		url : base + "/admin/eventRecord/uploadFile", 
		type : 'POST', 
		data : formData, 
		// 告诉jQuery不要去处理发送的数据
		processData : false, 
		// 告诉jQuery不要去设置Content-Type请求头
		contentType : false,
		beforeSend:function(){
			console.log("正在进行，请稍候...");
		},
		success : function(data) { 
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				//ListPage.enter({context:'#content',url:'${ctx}/admin/eventRecord/eventList?id=${league.id}',searchForm:'#searchForm'});
				ListPage.paginate();
			}
		}
	});
}

</script>