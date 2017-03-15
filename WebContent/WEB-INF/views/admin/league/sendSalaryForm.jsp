<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>奖金发放</a></li>
		<li><a>信息发送</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leagueForm" method="post" class="form-horizontal">
			<input type="hidden" name="league_id" value="${league.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					<input type="text" name="name" value="${league.name}" valid="require len(1,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">轮次</span>
						<select class="form-control" id="selectError3" name="rounds" onchange="loadTeams('${league.id}',this)">
								<option>--请选择轮次--</option>
								<c:forEach begin="0" step="1" end="${maxRounds-1}" var="rounds">
									<option value="${rounds+1}">${rounds+1}</option>
								</c:forEach>
					    </select>
				</div>
			</div>
			<div class="form-group" id="league_teams">
				
				
		    </div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="saveSalaryInfo()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
	//全选
	function allchecked(dom){
		if($(dom).is(":checked")){//选择全部
			$(dom).parent().find(".controls input").attr("checked","checked");
		}else{//取消选择全部
			$(dom).parent().find(".controls input").removeAttr("checked");
		}
	}
	
	function loadTeams(league_id,dom){
		var rounds = $(dom).val();
		var url = base+"/admin/league/teams?league_id="+league_id+"&rounds="+rounds;
		$("#league_teams").empty();
		$("#league_teams").load(url);
	}
	
	function saveSalaryInfo(){
		$.ajax({
			type:"post",
			url:base+"/admin/league/saveSalaryMsg?random="+Math.random(),
			data:$("#leagueForm").serializeObject(),
			dataType:'json',
			success:function(data){
				if(data.state=='success'){
					$("#content").load(base+'/admin/league/salaryManage?league_id=${league.id}');
				}else{
					layer.msg(data.data.message[0],{icon:2});
				}
			}
		})
	}
</script>