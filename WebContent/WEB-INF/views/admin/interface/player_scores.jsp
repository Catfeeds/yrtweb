<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-content">
				<div class="row">
				<form id="searchForm">
				<input type="hidden" name="mid" value="${params.q_match_id}">
				<input type="hidden" name="pid" value="${params.q_user_id}">
				</form>
				</div>
				<!-- <hr style="margin:2px;height:1px"> -->
				<form id="quan_score_form" method="post" class="form-horizontal">
				<table id="q_p_score" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="text-align: center;">姓名</th>
							  <th style="text-align: center;">进球时间</th>
							  <th style="text-align: center;">操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${scores}" var="ps" varStatus="status">
					  	<tr>
					  		<td>
					  		<input type="hidden" sid name="scores[${status.index}].id" value="${ps.id}"/>
					  		<input type="hidden" name="scores[${status.index}].q_match_id" value="${ps.q_match_id}"/>
					  		<input type="hidden" name="scores[${status.index}].team_id" value="${ps.team_id}"/>
					  		<input type="hidden" name="scores[${status.index}].teaminfo_id" value="${ps.teaminfo_id}"/>
					  		<input type="hidden" name="scores[${status.index}].q_user_id" value="${ps.q_user_id}"/>
					  		<input type="hidden" name="scores[${status.index}].user_id" value="${ps.user_id}"/>
					  		<input type="hidden" name="scores[${status.index}].is_wulong" value="N"/>
					  		<input type="text" value="${ps.name}" readonly="readonly" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" jinqiu name="scores[${status.index}].jinqiu_time" valid="require" value="${ps.jinqiu_time}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="button" onclick="delete_score(this)" class="btn btn-danger" value="删除"/>
					  		</td>
					  	</tr>
					  	</c:forEach>
					  </tbody>
				 </table>  
				 <div class="row" style="text-align: center;">
				 	<input type="button" onclick="add_score()" class="btn btn-info" value="添加"/>
				 	&emsp;
					<input type="button" onclick="update_scores()" class="btn btn-info" value="保存"/>
					&emsp;
					<input type="button" onclick="window.parent.closeScoreInfo()" class="btn" value="关闭"/>
				 </div>
				 </form>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">

function update_scores(){
	$.ajaxSec({
		context:$("#quan_score_form"),
		type: 'POST',
		url: '/admin/interface/updateScores',
		data: $("#quan_score_form").serializeObjects(),
		cache: false,
		success: function(result){
			if(result.state=='success'){
				ListPage.paginate(ListPage.currentPage);
				layer.msg("保存 成功",{icon: 1});
			}else{
				layer.msg("保存失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}

function add_score(){
	var t = $("#q_p_score").find("tbody");
	var tr = t.find("tr").get(0).outerHTML;
	var num = t.find("tr").length;
	if(tr){
		var trmodel = $(tr);
		trmodel.find("[jinqiu]").val("");
		trmodel.find("[sid]").val("");
		trmodel.find('[name]').each(function(){
			var nval = $(this).attr('name');
			var n = 'scores['+num+']';
			var v = nval.substring(nval.indexOf('.'));
			$(this).attr('name',n+v);
		});
		t.append(trmodel);
	}
}

function delete_score(dom){
	var id = $(dom).parent().parent().find("[sid]").val();
	if(id){
		ListPage.remove('${ctx}/admin/interface/deleteScore',id)
	}else{
		$(dom).parent().parent().remove();
	}
}

</script>
