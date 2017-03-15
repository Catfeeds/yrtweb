<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<c:choose>
	<c:when test="${!empty careers}">
		<input type="hidden" id="careers_size" value="${careers.size()}"/>
		<c:forEach items="${careers}" var="career" varStatus="num">
			<div class="career_1"  style="position: relative;">
				<form>
					<input type="hidden" name="id" value="${career.id}"/>
					<input type="hidden" name="user_id" value="${career.user_id}"/>
					<span class="yt_del ml10 pull-right" onclick="deleteCareer('${career.id}')"></span> 
					<span class="yt_saver_s pull-right" onclick="saveCareer(this,'/coach/saveOrUpdateCareer')"></span>  
				      <table class="carer_info">
				          <tr>
							<td class="w120">
					              <span class="f12">俱乐部名称：</span>
					          </td>
							 <td>
							 	<span class="f12">
							 		<input type="text" name="name" class="shuju" value="${career.name }" valid="require len(1,60)"/>
							 	</span>
							</td>
						  </tr>
				          <tr>
							<td class="w120">
					              <span class="f12">任职时间：</span>
					          </td>
							 <td>
							 	<fmt:formatDate value="${career.bg_time }" var="bg" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${career.ed_time }" var="ed" pattern="yyyy-MM-dd"/>
							 	<span class="f12">
							 		<input id="bg_time" name="bg_time" class="form-control" type="text" value="${bg}" readonly="readonly"/>
							 		~
							 		<input id="ed_time" name="ed_time" class="form-control" type="text" value="${ed}" readonly="readonly"/>
							 	</span>
							</td>
						  </tr>
						  <tr>
							<td class="w120">
				              <span class="f12">俱乐部描述:</span>
				            </td>
							<td colspan="3" style="text-indent:0;">
								<span class="f12"><textarea style="width: 450px;height: 60px;" name="describle">${career.describle}</textarea></span>
							</td>
						  </tr>
			      </table>
			      </form>
			  </div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<input type="hidden" id="careers_size" value="0"/>
		<div style="position: relative;" class="career_1">
			<form>
			<span class="yt_saver_s pull-right" onclick="saveCareer(this,'/coach/saveOrUpdateCareer')"></span>
			<table class="carer_info">
				<tbody>
					<tr>
						<td class="w120"><span class="f12">俱乐部名称：</span></td>
						<td><span class="f12"><input type="text" valid="require len(0,60)" value="" class="shuju" name="name"></span></td>
					</tr>
					<tr>
						<td class="w120">
							<span class="f12">任职时间：</span>
						</td>
						<td>
						<span class="f12">
						<input id="bg_time" name="bg_time" class="form-control" type="text" readonly="readonly"/>
							 		~
				 		<input id="ed_time" name="ed_time" class="form-control" type="text" readonly="readonly"/>
						</span>
						</td>
					</tr>
					<tr>
						<td class="w120">
							<span class="f12">俱乐部描述:</span>
						</td>
						<td style="text-indent:0;" colspan="3">
							<span class="f12">
								<textarea name="describle" style="width: 450px;height: 60px;"></textarea>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</c:otherwise>
</c:choose>
<div id="careerMore"></div>
  <input type="button" name="name" value="" class="pull-right yt_add ms f16" onclick="addMoreCareer()"/>
  <div class="clearit"></div>
<script type="text/javascript">

$("#bg_time").ccCanlendar({
	iniValue:false,
	startYear:1970,
	hasHourPanel:false,
	hasMinitePanel:false,
	autoSetMinLimit:false,
	showNextMonth:false
});
$("#ed_time").ccCanlendar({
	iniValue:false,
	startYear:1970,
	hasHourPanel:false,
	hasMinitePanel:false,
	autoSetMinLimit:false,
	showNextMonth:false
});

var careers_size = $("#careers_size").val();

function createCanlend(dom){
	$(dom).ccCanlendar({
		iniValue:false,
		startYear:1970,
		hasHourPanel:false,
		hasMinitePanel:false,
		autoSetMinLimit:false,
		showNextMonth:false
	});
}

//添加更多荣誉
function addMoreCareer(){
	careers_size++;
	var html ='<div class="career_1"  style="position: relative;">';
		html+='<form>';
		html+='<span class="yt_saver_s pull-right" onclick="saveCareer(this,'+"'/coach/saveOrUpdateCareer'"+')"></span>';
		html+='<table class="carer_info">';
		html+='<tr><td class="w120"><span class="f12">俱乐部名称：</span></td>';
		html+='<td><span class="f12"><input type="text" name="name" class="shuju" value="" valid="require len(0,60)"/></span></td></tr>';
		html+='<tr><td class="w120"><span class="f12">任职时间：</span></td>';
		html+='<td><span class="f12"><input id="bg_time_'+careers_size+'" name="bg_time" class="form-control" type="text" readonly="readonly"/>';
		html+='~<input id="ed_time_'+careers_size+'" name="ed_time" class="form-control" type="text" readonly="readonly"/></span></td></tr>';
		html+='<tr><td class="w120"><span class="f12">俱乐部描述:</span></td>';
		html+='<td colspan="3" style="text-indent:0;"><span class="f12"><textarea style="width: 450px;height: 60px;" name="describle"></textarea></span></td>';
		html+='</tr></table></form></div>';

		$("#careerMore").append(html);
		createCanlend("#bg_time_"+careers_size);
		createCanlend("#ed_time_"+careers_size);
}
</script>  