<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="title">
    <span class="text-white f16 ms t">球员能力</span>
    <div class="pull-right mr15">
        <a href="javascript:save_player_info()" class="new_btn_l" style="color: white;">保存</a>  <a href="javascript:center_player_data()" class="new_btn_l" style="color: white;">取消</a>
    </div>
    <div class="clearit"></div>
</div>
<!--能力编辑-->
<table class="ability" style="display: ;">
    <tr>
        <td class="w115"><span>身&emsp;&emsp;高 /</span></td>
        <td><input type="text" name="height" value="${info.height}" valid="require numberScope(100,230)" style="width: 165px;"/>&ensp;CM</td>
        <td class="w115"><span>体&emsp;&emsp;重 /</span></td>
        <td><input type="text" name="weight" value="<fmt:formatNumber value="${info.weight}" pattern="0"/>" valid="require numberFloatScope(25,150)" style="width: 165px;"/>&ensp;KG</td>
        <td class="w115"><span>&emsp;惯用脚 /</span></td>
        <td>
        	<input type="hidden" id="p_foot" name="cfoot" value="${info.cfoot}"/>
            <input type="text"  value="" id="foot" readonly="readonly" valid="require"/>
            <div id="select_foot" class="select_foot">
                <dl>
                    <dd>
                        <span class="f12" value="lrfoot">不限</span>
                    </dd>

                    <dd>
                        <span class="f12" value="lfoot">左脚</span>
                    </dd>
                    <dd>
                        <span class="f12" value="rfoot">右脚</span>
                    </dd>
                </dl>
            </div>
        </td>
    </tr>
    <tr>
        <td class="w115"><span>场上位置 /</span></td>
        <td>
            <select id="p_position" name="p_position" sel="${info.position}" class="form-control" data-placeholder=" " valid="require" multiple="" style="width: 180px;" data-rel="chosen">
              	<c:forEach items="${paramMap.get('p_position')}" var="pos">
				<option value="${pos.dict_value}">${pos.dict_value_desc}</option>
				</c:forEach>
			  </select>
        </td>
        <td class="w115"><span>类&emsp;&emsp;型 /</span></td>
        <td>
        	<input type="hidden" id="p_type" name="type" value="${info.type}"/>
         	<input type="text" value="" class="shuju" maxlength="15" readonly="readonly" id="type" style="width: 165px;" />
         	<div id="select_type" class="select_type">
                 <dl>
                 	<c:forEach items="${paramMap.get('p_type')}" var="pos">
                     <dd>
                         <span class="f12" style="width: 125px;display: inline-block;" value="${pos.dict_value}">${pos.dict_value_desc}</span>
                     </dd>
                     </c:forEach>
                 </dl>
             </div>
        </td>
        <td class="w115"><span>擅长赛制 /</span></td>
        <td>
            <input type="radio" name="ball_format" <c:if test="${info.ball_format!=7&&info.ball_format!=11}">checked="checked"</c:if> value="5" />5人
            <input type="radio" name="ball_format" <c:if test="${info.ball_format==7}">checked="checked"</c:if> value="7" />7/8/9人
            <input type="radio" name="ball_format" <c:if test="${info.ball_format==11}">checked="checked"</c:if> value="11" />11人
        </td>
    </tr>
    <tr>
        <td class="w115"><span>特长能力 /</span></td>
        <td>
        	<input type="hidden" id="p_tags" name="tags" value="${info.tags}"/>
            <input type="text" value="" maxlength="15" readonly="readonly" id="pp_tag" style="width: 165px;" />
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
        <td class="w115"><span>我的号码 /</span></td>
        <td>
            <input type="text" name="love_num" value="${info.love_num}" valid="numberScope(0,99)" style="width: 165px;"/>&ensp;号
        </td>
    </tr>
</table>
<script type="text/javascript">
$(function(){
	$("#select_tag dd span").each(function(){
		var otxt = $(this).text();
		var val = $(this).attr("value");
		var v = $("#p_tags").val();
		if(v==val){
			$("#pp_tag").val(otxt);
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
	$("#p_position_chosen").css('color','#000');
	$(".select_type dd span").each(function () {
	    var otxt = $(this).text();
	    var val = $(this).attr("value");
	    var v = $("#p_type").val();
		if(v==val){
			$("#type").val(otxt);
		}
	});
	
	$(".select_foot dd span").each(function () {
	    var otxt = $(this).text();
	    var val = $(this).attr("value");
	    var v = $("#p_foot").val();
		if(v==val){
			$("#foot").val(otxt);
		}
	});
})
//释放鼠标
$(document).click(function (e) {
    if (!$(".select_type").is(':has(' + e.target.localName + ')') && e.target.id != 'type') {
        $(".select_type").hide();
    }
    if (!$(".select_tag").is(':has(' + e.target.localName + ')') && e.target.id != 'pp_tag') {
        $(".select_tag").hide();
    }
    if (!$(".select_foot").is(':has(' + e.target.localName + ')') && e.target.id != 'foot') {
        $(".select_foot").hide();
    }
});
//选择类型
$("#type").click(function () {
    $(".select_type").show();
});
$(".select_type dd span").click(function () {
    var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_type").val(val);
    $("#type").val(otxt);
    $(".select_type").hide();
});

//选择标签
$("#pp_tag").click(function () {
    $(".select_tag").show();
});
$(".select_tag dd span").click(function () {
	var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_tags").val(val);
    $("#pp_tag").val(otxt);
    $(".select_tag").hide();
});
//选择左右脚
$("#foot").click(function () {
    $(".select_foot").show();
});
$(".select_foot dd span").click(function () {
    var otxt = $(this).text();
    var val = $(this).attr("value");
    $("#p_foot").val(val);
    $("#foot").val(otxt);
    $(".select_foot").hide();
});
</script>