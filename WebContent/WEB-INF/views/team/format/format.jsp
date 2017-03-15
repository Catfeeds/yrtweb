<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<c:set var="qc" value="st,lw,rw"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="arrangement" id="arrangement">
                	<div class="closeBtn_1" onclick="closeWin()"></div>
                    <div class="titles">
                        <span class="ms f16">上阵选择</span>
                    </div>
                    <table class="t_title">
                        <tr>
                            <th style="width: 37px;"><span>选择</span></th>
                            <th style="width: 37px;"><span>号码</span></th>
                            <th style="width: 43px;"><span>姓名</span></th>
                            <th style="width: 38px;"><span>身高</span></th>
                            <th style="width: 37px;"><span>体重</span></th>
                            <th style="width: 104px;"><span>擅长位置</span></th>
                            <th style="width: 72px;"><span>综合能力</span></th>
                            <th style="width: 87px;"><span>身价</span></th>
                            <th style="width: 64px;"><span>状态</span></th>
                        </tr>
                    </table>
                    <div style="min-height: 599px;max-height: 600px;overflow:auto;">
                    	<form id="formFormat">
                        <table class="t_title" style="margin-top: 0px;width: 520px;">
                        	<c:forEach items="${tps}" var="tp" varStatus="num">
	                            <tr id="pnum_${tp.position_num }">
	                                <td style="width: 37px;">
	                                	<input type="hidden" data_name="user_id" name="pp[${num.index}].user_id" value="${tp.user_id}"/>
	                                	<c:choose>
	                                		<c:when test="${!empty tp.position_num}">
			                                	<input type="hidden" data_name="isCheck" name="pp[${num.index}].isCheck" value="1"/>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<input type="hidden" data_name="isCheck" name="pp[${num.index}].isCheck" value="0"/>
	                                		</c:otherwise>
	                                	</c:choose>
	                                	<input type="hidden" data_name="id" name="pp[${num.index}].id" value="${tp.id }"/>
	                                	<input type="hidden" data_name="position" name="pp[${num.index}].position" value="${tp.position}"/>
	                                	<input type="hidden" data_name="position_num" name="pp[${num.index}].position_num" value="${tp.position_num}"/>
	                                	<input type="hidden" data_name="head_icon" value="${el:headPath()}${tp.head_icon}"/>
	                                	<input type="checkbox" <c:if test="${!empty tp.position_num }">checked index="${tp.position_num}"</c:if> data_name="checkbox" name="checkbox" value="${ctx}/resources/images/l_head.png" onclick="oCheckbox(this)"/>
                                	</td>
	                                <td style="width: 37px;"><span>${tp.player_num }</span></td>
	                                <td style="width: 43px;"><span>${tp.username}</span></td>
	                                <td style="width: 38px;"><span>${tp.height}</span></td>
	                                <td style="width: 37px;"><span>${tp.weight}</span></td>
	                                <td style="width: 104px;">
	                                <span>
                                		<c:forEach items="${fn:split(tp.love_position,',')}" var="pos">
	                            			<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
		                            	</c:forEach>
	                                </span>
	                                </td>
	                                <td style="width: 72px;"><span>${tp.score}</span></td>
	                                <td style="width: 87px;"><span>${tp.current_price}</span></td>
	                                <td style="width: 64px;">
	                                	<c:choose>
	                                		<c:when test="${!empty tp.position_num}">
	                                			<span><yt:dict2Name nodeKey="p_position" key="${tp.position}"></yt:dict2Name></span>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<span>未上阵</span>
	                                		</c:otherwise>
	                                	</c:choose>
	                                </td>
	                            </tr>
                        	</c:forEach>
                        </table>
                        </form>
                    </div>
                    <div class="btn_tool">
                        <input type="button" name="name" value="确认" class="btn_l mt15 ms " onclick="savePosition()"/>
                        <input type="button" name="name" value="取消" class="btn_g mt15 ms cancel" style="margin-left: 20px;" onclick="closeWin()"/>
                    </div>
                </div>

                <div class="for_l">
                    <table>
                        <tr>
                            <th colspan="5"><span class="f20 ms">首发阵容</span></th>
                        </tr>
                        <tr>
                            <td><span class="text-gray-s_999">号码</span></td>
                            <td><span class="text-gray-s_999">球员</span></td>
                            <td><span class="text-gray-s_999">场上位置</span></td>
                            <td><span class="text-gray-s_999">综合能力</span></td>
                            <td><span class="text-gray-s_999">身价</span></td>
                        </tr>
                        <tbody id="bodyDatas">
	                       <c:choose>
								<c:when test="${!empty tps_format }">
									<c:forEach items="${tps_format}" var="tp">
										 <tr>
							                 <td><span class="f14 ms">${tp.player_num}</span></td>
							                 <td><span class="f14 ms">${tp.username}</span></td>
							                 <td><span class="f14 ms">
							  						<yt:dict2Name nodeKey="p_position" key="${tp.position}"></yt:dict2Name>               
							                	</span></td>
							                 <td><span class="f14 ms">${tp.score}</span></td>
							                 <td><span class="f14 ms">${tp.current_price}</span></td>
							             </tr>
									</c:forEach>
								</c:when>
							</c:choose>
                        </tbody>
                    </table>

                </div>
                <div class="select_form" style="">
                    <span class="f20 ms mt10">阵形选择</span>
                    <c:forEach begin="0" step="1" end="10" varStatus="num">
                    		<a href="javascript:void(0);" class="seat 
		                    	<c:if test="${num.index ==0}">one</c:if> 
		                    	<c:if test="${num.index ==1}">two</c:if>
		                    	<c:if test="${num.index ==2}">three</c:if> 
		                    	<c:if test="${num.index ==3}">four</c:if>
		                    	<c:if test="${num.index ==4}">five</c:if> 
		                    	<c:if test="${num.index ==5}">six</c:if> 
		                    	<c:if test="${num.index ==6}">seven</c:if> 
		                    	<c:if test="${num.index ==7}">eight</c:if>
		                    	<c:if test="${num.index ==8}">nine</c:if>
		                    	<c:if test="${num.index ==9}">ten</c:if> 
		                    	<c:if test="${num.index ==10}">eleven</c:if>" 
		                    	>
	                    	 <img src="${ctx}/resources/images/pos.png" 
	                  			<c:if test="${num.index ==0 }">alt="lf" title="左前锋"</c:if> 
		                    	<c:if test="${num.index ==1 }">alt="rf" title="右前锋"</c:if>
		                    	<c:if test="${num.index ==2 }">alt="lw" title="左边锋"</c:if> 
		                    	<c:if test="${num.index ==3 }">alt="lcm" title="左中场"</c:if>
		                    	<c:if test="${num.index ==4 }">alt="rcm" title="右中场"</c:if> 
		                    	<c:if test="${num.index ==5 }">alt="rw" title="右边锋"</c:if> 
		                    	<c:if test="${num.index ==6 }">alt="lb" title="左后卫"</c:if> 
		                    	<c:if test="${num.index ==7 }">alt="lcb" title="左中卫"</c:if>
		                    	<c:if test="${num.index ==8 }">alt="rcb" title="右中卫"</c:if>
		                    	<c:if test="${num.index ==9 }">alt="rb" title="右后卫"</c:if> 
		                    	<c:if test="${num.index ==10 }">alt="gk" title="守门员"</c:if> 
		                        index="${num.index}" />
		                    </a>
                    </c:forEach>
                </div>
                <div class="clearit"></div>
<script>
//关闭上阵选择
function shut() {
    $(".arrangement").fadeOut();
}

function closeWin(){
	 // shut();
	  window.location.reload();
}

//阵形设置功能
var aSeat = $(".seat").find("img");

var aindex;
var p_desc;//场上位置描述
aSeat.click(function () {
    aindex = $(this).attr("index");
    p_desc = $(this).attr("alt");
    $(".arrangement").fadeIn();
    return aindex;
});

function oCheckbox(dom) {
    if ($(dom).is(":checked")) {
    	if($("#formFormat input[data_name='position_num']").val()==aindex && $("#formFormat input[data_name='position']").val()==p_desc){
    		$("#pnum_"+aindex).children().children("input[data_name='position']").val("");
    		$("#pnum_"+aindex).children().children("input[data_name='position_num']").val("");
    		$("#pnum_"+aindex).children().children("input[data_name='isCheck']").val("0");
    		$("#pnum_"+aindex).children().children("input[data_name='checkbox']").removeAttr("checked");
    	}
        $(dom).attr("index", aindex);
		$(dom).parent().children("input[data_name='position']").val(p_desc);
		$(dom).parent().children("input[data_name='position_num']").val(aindex);
		$(dom).parent().children("input[data_name='isCheck']").val(1);
        //var path = $(dom).val();
        var path = $(dom).parent().children("input[data_name='head_icon']").val();
        aSeat[aindex].src = path;
    }else {
        var cindex = $(dom).attr("index");
        $(dom).parent().children("input[data_name='position']").val("");
		$(dom).parent().children("input[data_name='position_num']").val("");
		$(dom).parent().children("input[data_name='isCheck']").val(0);
        aSeat[cindex].src = base+'/resources/images/pos.png';
    }
}

//保存球队阵型位置
function savePosition(){
	$.ajax({
		type:'post',
		url:base+'/tformat/saveFormat?random='+Math.random(),
		data:$("#formFormat").serialize(),
		dataType:'json',
		success:function(data){
			if(data.state='success'){
				window.location.reload();
			}else{
				layer.msg(data.message.error[0],{icon:2});
			}
		},
	});
}
</script>