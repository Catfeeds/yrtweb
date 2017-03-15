<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<input type="hidden" id="comment_createTime" value=""/>
<!--评价-->
<div class="comment_col">
    <div class="title" style="width: 760px;">
        <span class="text-white f16 ms t">评价栏</span>
        <a href="javascript:void(0);" id="pla" style="
        float:right;
        margin-top:10px;
        margin-right:10px;
        width:45px;
        height:20px;
        line-height:20px;
        text-align:center;
        border: none;
        border-radius: 4px;
        background: #eb6100;
        color: #fff;">评价</a>
    </div>
    <!--没有数据-->
    <div id="comment_no_data" class="no_data" style="height: 400px;line-height: 400px;display: none;">
    	<c:choose>
    		<c:when test="${isme=='1'}">
        <span class="text-gray-s_999 f16 ms">还没有人对我留下评价</span>
    		</c:when>
    		<c:otherwise>
        <span class="text-gray-s_999 f16 ms">点击右上方的“评价”按钮，留下你对我的评价吧</span>
    		</c:otherwise>
    	</c:choose>
       <!--  <a href="#" class="new_btn_l">邀请好友，给我评价</a> -->
    </div>
    <div id="comment_list" class="comment_info">
        <div id="comment_model" class="c_i" style="display: none;">
            <!--楼主头像-->
            <div class="new_win_l">
                <img src="${el:headPath()}{{head_icon}}" alt="" />
            </div>
            <div class="new_win_r" style="position: relative;">
                <!--楼主主题-->
                <dl>
                    <dt>
                        <span class="sp_name" onmouseover="showUserInfo('{{user_id}}','#n_player_{{id}}')" onmouseout="hideUserInfo('#n_player_{{id}}',this)"  onclick="location.href=base+'/center/{{user_id}}'" style="cursor: pointer;">{{usernick}}：</span>
                        <span id="jl">
                            <!--名片-->
                            <div class="card" style="z-index: 120000000;" id="n_player_{{id}}">
                            </div>
                        </span>
                        <span class="sp_cen">{{content}}</span>
                    </dt>
                    <dd>
                        <span class="huifu_time" data-id="create_time"></span>
                        <span class="huifu_s" data-id="isme" onclick="show_huifu(this)">
                            <span data-id="xisme" class="huifu_ss"></span>
                        </span>
                        <div class="you_reply">
                        <form id="huifu_form_{{id}}" errorType="2" action="${ctx}/center/saveUserComment">
                        <input type="hidden" name="s_user_id" value="{{user_id}}"/>
                        <input type="hidden" name="c_user_id" value="${oth_user_id}"/>
						<input type="hidden" name="parent_id" value="{{id}}"/>
                            <textarea  name="content" valid="require len(0,280)" data-text="回复"></textarea>
                            <div class="btn_div">
                                <input type="button" onclick="$.ajaxSubmit('#huifu_form_{{id}}','#huifu_form_{{id}}',huifu_handler)" value="回复" class="new_btn_l" />
                            </div>
                        </form>
                        </div>
                    </dd>
                </dl>

                <!--其他人回复-->
                <div data-container="comment_childs_list" class="mt10">
                	<div data-tpl="comment_childs_model">
                    <div class="new_win_r_h">
                        <img src="${el:headPath()}{{head_icon}}" alt="">
                    </div>
                    <div class="new_win_r_h_sub" style="position: relative;">

                        <dl>
                            <dt>
                                <span class="sp_name_h" onmouseover="showUserInfo('{{user_id}}','#n_player_{{id}}_{{user_id}}')" onmouseout="hideUserInfo('#n_player_{{id}}_{{user_id}}')" onclick="location.href=base+'/center/{{user_id}}'" style="cursor: pointer;">{{usernick}}</span>
                                <span id="jl">
		                            <!--名片-->
		                            <div class="card" id="n_player_{{id}}_{{user_id}}">
		                            </div>
		                        </span>
                                <span class="huifu">回复了</span>
                                <span class="sp_name_h" onmouseover="showUserInfo('{{s_user_id}}','#n_player_{{id}}_{{s_user_id}}',this)" onmouseout="hideUserInfo('#n_player_{{id}}_{{s_user_id}}')" onclick="location.href=base+'/center/{{user_id}}'" onclick="location.href=base+'/center/{{s_user_id}}'" style="cursor: pointer;">{{susernick}}</span>
                                <span id="jl">
		                            <!--名片-->
		                            <div class="card" id="n_player_{{id}}_{{s_user_id}}">
		                            </div>
		                        </span>
                                <span class="sp_cen">{{content}}</span>
                            </dt>
                            <dd>
                                <span class="huifu_time" data-id="create_time"></span>
                                <span class="huifu_s" data-id="isme" onclick="show_huifu(this)">
		                            <span data-id="xisme" class="huifu_ss"></span>
		                        </span>
		                        <div class="you_reply">
                                    <form id="huifu_form_{{id}}" errorType="2" action="${ctx}/center/saveUserComment">
			                        <input type="hidden" name="s_user_id" value="{{user_id}}"/>
			                        <input type="hidden" name="c_user_id" value="${oth_user_id}"/>
									<input type="hidden" name="parent_id" value="{{parent_id}}"/>
			                            <textarea  name="content" valid="require len(0,280)" data-text="回复"></textarea>
			                            <div class="btn_div">
			                                <input type="button" onclick="$.ajaxSubmit('#huifu_form_{{id}}','#huifu_form_{{id}}',huifu_handler)" value="回复" class="new_btn_l" />
			                            </div>
			                        </form>
                                </div>
                            </dd>
                        </dl>

                    </div>
                    </div>
                    <div class="clearit"></div>
                </div>
            </div>
            <div class="clearit"></div>
            <ul class="the_paging">
                <div class="clearit"></div>
            </ul>
        </div>
    </div>
    <div id="comment_load_more" class="btn_div" onclick="load_more(this)" style="margin: -16px auto;display: none;"><a style="cursor: pointer;"  class="loading">加载更多 >></a></div>
</div>
<script>

//评价
$("#pla").click(function () {
	$("#pla_form").find("textarea").val('');
	var flag = check_user_role();
	if(!flag)return;
    $(".masker").height($(document).height()).fadeIn();
    $(".pla").center().show();
});

var comment_list = new List({url:base+'/center/queryComments',sendData:{oth_user_id:$("#oth_user_id").val(),currentPage:1,pageSize :3},listDataModel:$('#comment_model').get(0).outerHTML,listContainer:'#comment_list',
	dynamicVMHandler:function(one){
	var vm = $(comment_list.options.listDataModel);
   	vm.css('display','block');
   	vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
   	vm.attr("id","comment_model_"+one.id);
   	if(one.isme==1){
   		vm.find('[data-id=isme]').addClass("remove_s").removeClass("huifu_s").attr("onclick","delete_comment('"+one.id+"')");
   		vm.find('[data-id=xisme]').addClass("remove_ss").removeClass("huifu_ss");
   	}
   	return vm.get(0).outerHTML;
},
afterRenderList:function(c,v,d){
	huifu_event();
	for(var i in d){
		getComments(d[i].id,$("#comment_model_"+d[i].id));
	}
}});

function load_comment_list(){
	comment_list.loadListData().done(function(data){
		comment_isPageEnd(data.data.page);
		if(data.state=='success'&&data.data.page&&data.data.page.items.length>0){
			$("#comment_createTime").val(data.data.createTime);
			comment_list.renderList(data.data.page.items,'reloaded');
		}else{
			var no_data = $('#comment_no_data').get(0).outerHTML;
			$("#comment_list").empty().append($(no_data).css('display','block'));
		}
	});	
}

function comment_isPageEnd(page){
	if(page.currentPage*page.pageSize>=page.totalCount){
		$('#comment_load_more').hide();
	}else{
		$('#comment_load_more').show();
	}
}

function load_more(btn){
	comment_list.options.sendData.currentPage++;
	comment_list.options.sendData.createTime = $("#comment_createTime").val();
	comment_list.loadListData().done(function(data){
		comment_isPageEnd(data.data.page);
		if(data.state=='success'&&data.data.page&&data.data.page.items.length>0){
			comment_list.renderList(data.data.page.items,'append');
		}else{
			$(btn).hide();
		}
	});	
}

//回复消息
function huifu_event(){
	$(".huifu_s").mouseover(function () {
	    $(this).find(".huifu_ss").show();
	}).mouseout(function () {
	    $(this).find(".huifu_ss").hide();
	});
	$(".remove_s").mouseover(function () {
        $(this).find(".remove_ss").show();
    }).mouseout(function () {
        $(this).find(".remove_ss").hide();
    });
}
function show_huifu(dom){
	var flag = check_user_role();
	if(!flag)return;
	if ($(dom).next(".you_reply").is(":visible")) {
        $(dom).next(".you_reply").hide();
    } else {
        $(dom).next(".you_reply").show();
    }
}
var commenter = new Object();
var comment_tpl = $('[data-tpl=comment_childs_model]').get(0).outerHTML;
$('[data-tpl=comment_childs_model]').remove();
function getComments(did,obj){
	var container = obj.find('[data-container=comment_childs_list]');
	if(!commenter[did]){
		commenter[did] = new List({
		url:'${ctx}/center/queryCommentChilds',
  			sendData:{
  				currentPage:1,
  				pageSize :3,
  				parent_id:did
  	        },
  	     	listDataModel:comment_tpl,
  	     	listContainer:container,
  	     	dynamicVMHandler:function(one){
	   	     	var vm = $(commenter[did].options.listDataModel);
	   	     	vm.css('display','block');
	   	     	if(one.create_time){
	     			vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
	     		}
		   	    if(one.isme==1){
		   	   		vm.find('[data-id=isme]').addClass("remove_s").removeClass("huifu_s").attr("onclick","delete_comment('"+one.id+"','"+one.parent_id+"')");
		   	   		vm.find('[data-id=xisme]').addClass("remove_ss").removeClass("huifu_ss");
		   	   	}
	     		return vm.get(0).outerHTML;
  	     	},
  	     	afterRenderList:function(c,v){
  	     		huifu_event();
  	     		c.parents('[data-tpl]').removeAttr('style');
			/* c.parents('[data-tpl]').css({
				height:c.parents('[data-tpl]').height()+c.parents().find('[data-control]').get(0).scrollHeight+'px'
			}); */
  	     	}
	});
	commenter[did].loadListData().done(function(data){
		commenter[did].iniPageControl2(data.data.page);
		commenter[did].renderList(data.data.page.items,'reloaded');
	});
	}
}
function load_comment_reply(did,msg){
	var list = commenter[did];
	list.options.sendData.currentPage = 1;
	list.loadListData().done(function(data){
		yrt.msg(msg,{icon: 1});
		list.iniPageControl2(data.data.page);
		list.renderList(data.data.page.items,'reloaded');
	});
}
function huifu_handler(result){
	if(result.state=='success'){
		var did = result.data.comment.parent_id;
		$("#huifu_form_"+did).find("textarea").val('');
		$("#huifu_form_"+did).parent().hide();
		load_comment_reply(did,'回复成功');
	}else{
		layer.msg("回复失败",{icon: 2});
	}
}
function delete_comment(cid,pid){
	var flag = check_user_role();
	if(!flag)return;
	yrt.confirm('确定要删除这条评论吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/center/deleteUserComment',
			data: {id: cid},
			success: function(result){
				if(result.state=='success'){
					if(pid){
						load_comment_reply(pid,"删除成功");
					}else{
						yrt.msg("删除成功",{icon: 1});
						load_comment_list();
						commenter = new Object();
					}
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

$(function(){
	load_comment_list();
})
</script>