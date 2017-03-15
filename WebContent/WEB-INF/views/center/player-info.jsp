<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input type="hidden" name="id" value="${info.id}"/>
	<div style="width: 378px;float: left;">
        <div class="theMain ml10 clearfix">
            <span class="fw text-white pull-left ml15">球员属性</span> <!-- <span onclick="$.ajaxSubmit('#editInfo','#editInfo',reloadInfo)" title="保存" class="pull-right yt_save"></span> -->
        </div>
        <div class="clearit"></div>
        <!--编辑框-->
        <table class="theMain_1" style="display:;">
            <tr>
                <td class="w140">
                    <span>身　　高<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158">
                    <input type="text" name="height" value="${info.height}" valid="require numberScope(100,230)" class="shuju" maxlength="15" />
                    <span class="text-warn">CM</span>
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span>体　　重<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158">
                    <input type="text" name="weight" value="${info.weight}" valid="require numberFloatScope(25,150)" class="shuju" maxlength="15" />
                    <span class="text-warn">KG</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span>场上位置<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158" style="color:black;">
                <select id="p_position" name="p_position" sel="${info.position}" class="form-control" data-placeholder=" " valid="require" multiple="" style="width: 144px;" data-rel="chosen">
                	<c:forEach items="${paramMap.get('p_position')}" var="pos">
					<option value="${pos.dict_value}">${pos.dict_value_desc}</option>
					</c:forEach>
				  </select>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span>类　　型 ：</span>
                </td>
                <td class="w158">
                    <input type="hidden" id="p_type" name="type" value="${info.type}"/>
                	<input type="text" value="" class="shuju" maxlength="15" readonly="readonly" onclick="showSelect('#select_type')" id="type" />
                	<div id="select_type" class="select_tag">
                        <dl>
                        	<c:forEach items="${paramMap.get('p_type')}" var="pos">
                            <dd>
                                <span class="f12" style="width: 125px;display: inline-block;" value="${pos.dict_value}">${pos.dict_value_desc}</span>
                            </dd>
                            </c:forEach>
                        </dl>
                    </div>
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span>百米成绩 ：</span>
                </td>
                <td class="w158">
                    <input type="text" name="results" value="${info.results}" valid="numberFloatScope(10,30)" class="shuju" maxlength="15" />
                    <span class="text-warn">S</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span>特长能力 ：</span>
                </td>
                <td class="w158">
                	<input type="hidden" id="p_tags" name="tags" value="${info.tags}"/>
                    <input type="text" value="" class="shuju" maxlength="15" readonly="readonly" id="tag" onclick="showSelect('#select_tag')" />
                    <div id="select_tag" class="select_tag">
                        <dl>
                            <c:forEach items="${paramMap.get('p_tags')}" var="pos">
                            <dd>
                                <span class="f12" style="width: 125px;display: inline-block;" value="${pos.dict_value}">${pos.dict_value_desc}</span>
                            </dd>
                            </c:forEach>
                        </dl>

                    </div>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span>职业状态<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158">
                    <input type="radio" <c:if test="${!info.pro_status}">checked="checked"</c:if> name="pro_status" value="0" />非职业
                    <input type="radio" <c:if test="${info.pro_status}">checked="checked"</c:if> name="pro_status" value="1" />职业 
                    <span class="text-warn"></span>
                </td>

            </tr>
           <tr>
                <td class="w140">
                    <span>惯 用 脚<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158">
                    <input type="radio" name="cfoot" <c:if test="${info.cfoot!='lfoot'&&info.cfoot!='lrfoot'}">checked="checked"</c:if> value="rfoot" />右脚
                    <input type="radio" name="cfoot" <c:if test="${info.cfoot=='lfoot'}">checked="checked"</c:if> value="lfoot" />左脚
                    <span class="text-warn"></span>
                </td>
            </tr>
           <tr>
                <td class="w140">
                    <span>常踢赛制<span style="color: red;">*</span>：</span>
                </td>
                <td class="w158">
                    <input type="radio" name="ball_format" <c:if test="${info.ball_format!=7&&info.ball_format!=11}">checked="checked"</c:if> value="5" />5人
                    <input type="radio" name="ball_format" <c:if test="${info.ball_format==7}">checked="checked"</c:if> value="7" />7/8/9人
                    <input type="radio" name="ball_format" <c:if test="${info.ball_format==11}">checked="checked"</c:if> value="11" />11人
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span>组队邀请 ：</span>
                </td>
                <td class="w158">
                    <input type="radio" name="invitat_team" <c:if test="${info.invitat_team || (empty info.invitat_team)}">checked="checked"</c:if> value="1" />是
                    <input type="radio" name="invitat_team" <c:if test="${!info.invitat_team&& (!empty info.invitat_team)}">checked="checked"</c:if> value="0" />否
                </td>
            </tr>
            
            <%-- <tr>
                <td class="w140">
                    <span>颠球数：</span>
                </td>
                <td class="w158">
                    <input type="text" name="bou_count" value="${info.bou_count}" valid="numberNotZero" class="shuju" maxlength="15" />
                </td>
            </tr> --%>
            <%-- <tr>
                <td class="w140">
                    <span>球员模版 ：</span>
                </td>
                <td class="w158">
                    <input type="text" name="player_temp" value="${info.player_temp}" valid="len(0,80)" class="shuju" maxlength="15" />
                    <span class="text-warn"></span>
                </td>
            </tr> 
           
            <tr>
                <td class="w140">
                    <span>伤 病 史 ：</span>
                </td>
                <td class="w158">
                	<input type="text" name="injured_area" value="${info.injured_area}" valid="len(0,80)" class="shuju" maxlength="40" />
                </td>
            </tr>--%>
            
            
           
            
        </table>
    </div>
<script type="text/javascript">
$(function(){
	$("#select_tag dd span").each(function(){
		var otxt = $(this).text();
		var val = $(this).attr("value");
		var v = $("#p_tags").val();
		if(v==val){
			$("#tag").val(otxt);
		}
	});
	var pos_val = $("#p_position").attr('sel');
	var hh=new Array();
	if(pos_val) hh = pos_val.split(',');
	$("#p_position").children().each(function(){
  		 for(var i=0;i<hh.length;i++){
  			 if($(this).attr('value')==hh[i]){
  				 $(this).attr('selected','selected');
  			 }
  		 }
	});
	var positions = $('[data-rel="chosen"],[rel="chosen"]').chosen({max_selected_options: 2,no_results_text : "未找到此选项!"});

	$("#select_type dd span").each(function () {
	    var otxt = $(this).text();
	    var val = $(this).attr("value");
	    var v = $("#p_type").val();
		if(v==val){
			$("#type").val(otxt);
		}
	});

	$("#select_injured_area dd span").each(function () {
	    var otxt = $(this).text();
	    var val = $(this).attr("value");
	    var v = $("#p_injured_area").val();
		if(v==val){
			$("#injured_area").val(otxt);
		}
	});
})
function showSelect(sid){
	$(sid).show();
}

$("#select_tag dd span").click(function () {
    var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_tags").val(val);
    $("#tag").val(otxt);
    //alert($("#tag").val());
    $("#select_tag").hide();
});


$("#select_type dd span").click(function () {
    var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_type").val(val);
    $("#type").val(otxt);
    //alert($("#tag").val());
    $("#select_type").hide();
});

$("#select_injured_area dd span").click(function () {
    var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_injured_area").val(val);
    $("#injured_area").val(otxt);
    //alert($("#tag").val());
    $("#select_injured_area").hide();
});

$(document).click(function(e) {
	if(!$("#select_tag").is(':has('+e.target.localName+')')&&e.target.id!='tag'){
		$("#select_tag").hide();
	}
	if(!$("#select_type").is(':has('+e.target.localName+')')&&e.target.id!='type'){
		$("#select_type").hide();
	}
	
	if(!$("#select_injured_area").is(':has('+e.target.localName+')')&&e.target.id!='injured_area'){
		$("#select_injured_area").hide();
	}
});

function reloadInfo(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		playerinfo.renderModel(result.data.data.data,'reloaded');
		praise_count(result.data.data.praiseCount);
		$("#player_ability").attr("onclick","update_player_info(this)");
		$("#player_ability").attr("class","yt_editer text-white pull-right");
		$(".scale").css("background","none");
		$("#edit_state").val(1);
		//edit_ability();
		//playerinfo.renderModel(result.data.data.data,'reloaded');
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}
</script>

