<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="currentPage" value="BBS"/>
<title>论坛列表</title>
<style>
   #edui1_iframeholder{
      height:180px;
   }
</style>
</head>
<body>
<div class="warp">
        <div class="masker" style="z-index: 1000;"></div>
        <!--附件收费-->
        <div class="pay_enc">
            <div class="title">
                <div class="closeBtn_1" onclick="cannelPayEnc()"></div>
                <span class="f18 ms text-white">提　示</span>
            </div>
            <div class="pay_region">
            	<input type="hidden" id="attrc_uid" value=""/>
                <p class="f16 ms">附件上传成功</p>
                <p class="mt15"><input type="checkbox" name="name" value="" id="shezhi"/><span class="ml5">下载附件是否收费</span></p>
                <div class="setting">
                    <span>附件价格：</span><input type="text" id="attrc_price" value="0" style="width: 100px;"/><span class="ml10">宇币</span>
                </div>
                <input type="button" onclick="submitPayEnc()" value="确认" class="btn_l mt25" />
                <input type="button" onclick="cannelPayEnc()" value="取消" class="btn_l mt25 ml15" />
            </div>
        </div>
        <!--设置回复可见-->
        <div class="back_visible">
            <div class="closeBtn_1" onclick="cannelPreContent();"></div>
            <div class="set_back">
                <p class="text-white">如果您的帖子设置了回复可见，请在此处设置回复前的可见内容： </p>
                <textarea class="hidetxt" id="set_content" name="pre_content"></textarea>
                <input type="button" name="name" value="设置" onclick="setPreContent()" class="btn_l mt20 ml150" /><input type="button" name="name" value="取消" onclick="cannelPreContent()" class="btn_g mt20 ml25" />
            </div>
        </div>
         <!--头部-->
        <%@ include file="../common/header.jsp" %> 
        <!--导航-->
        <%@ include file="../common/naver.jsp" %>  
		
		<!-- 隐藏域 -->
		<input type="hidden" id="NoteStatus" value="${status}"/>
		<input type="hidden" id="note_if_del" value="${if_del}"/>
		<input type="hidden" id="note_if_show" value="1"/>
        <div class="bbs">
            <div class="title">
                <div class="pull-left ml15">
                    <span <c:if test="${empty status && empty my && empty focus && empty if_del}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${plate_id}'">全部</span><span>|</span>
                    <span <c:if test="${status eq 'PICK'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${plate_id}&status=PICK'">精华</span><span>|</span>
                    <span <c:if test="${focus eq 'focus'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/toMyBbsNotelist?plate_id=${plate_id}&focus=focus'" >关注</span><span>|</span>
                    <span <c:if test="${not empty session_user_id &&  my eq 'my' && empty focus}">class="active"</c:if> 
                              onclick="javascript:window.location='${ctx}/bbs/toMyBbsNotelist?plate_id=${plate_id}'">我的</span>
                    <c:if test="${ifLeader eq true}">
                    <span>|</span><span <c:if test="${if_del eq '1'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${plate_id}&if_del=1'">回收站</span>
                    </c:if>
                </div>
                <div class="pull-right">
                    <input type="text" id="searchTitle" name="title" value="" class="searches_txt" />
                    <input type="button" name="name" value="搜索" class="searches ml10 mr10" onclick="searchResult()"/>
                    <a href="#fabu" class="pot f12 mr10">发表新帖</a>
                    <a href="javascript:window.location='/bbs/toVotePage?plate_id=1nO7UrefT7nD2ffffd1'" class="pot f12 mr10">发起投票</a>
                </div>
                <div class="clearit"></div>
            </div>

            <table class="toptab">
             <tr>
             		<c:if test="${ifLeader eq true}">
                    <th class="w50">
                        <span class="text-gray-s_666">操作</span>
                    </th>
                    </c:if>
                    <th class="w90">
                        <span class="text-gray-s_666">楼层</span>
                    </th>
                    <th class="w500">
                        <span class="text-gray-s_666">主题</span>
                    </th>
                    <th class="text-left w160">
                        <span class="text-gray-s_666">主题作者</span>
                    </th>
                    <th class="text-left w160">
                        <span class="text-gray-s_666">最后回复人</span>
                    </th>
                </tr>
                <tbody id="toptabArea">
	            	<c:forEach items="${topdatas.items}" var="item" varStatus="num">
	                <tr>
	                <c:if test="${ifLeader eq true}">	
	                 <td class="w50">
	                        <a href="javascript:void(0);" class="sting"></a>
	                        <div class="bztool">
	                            <ul>
	                                <li>
	                                   <c:if test="${item.if_top == 1 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_top',2,'${item.plate_id }')">取消置顶</a>
	                                   </c:if>
	                                   <c:if test="${item.if_top == 2 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_top',1,'${item.plate_id }')">置顶</a>
	                                   </c:if>
	                                </li>
	                                <li>
	                                   <c:if test="${item.if_pick == 1 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_pick',2,'${item.plate_id }')">取消精华</a>
	                                   </c:if>
	                                   <c:if test="${item.if_pick == 2 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_pick',1,'${item.plate_id }')">精华</a>
	                                   </c:if>
	                                </li>
	                                <li>
	                                   <c:if test="${item.if_lock == 2 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_lock',1,'${item.plate_id }')">锁定</a>
	                                   </c:if>
	                                </li>
	                                <li>
	                                   <c:if test="${item.if_show == 1 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_show',2),'${item.plate_id }'">屏蔽</a>
	                                   </c:if>
	                                </li>
	                                <li>
	                                   <c:if test="${item.if_del == 2 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_del',1),'${item.plate_id }'">删除</a>
	                                   </c:if>
	                                   <c:if test="${item.if_del == 1 }">
	                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_del',2),'${item.plate_id }'">取消删除</a>
	                                   </c:if>
	                                </li>
	                            </ul>
	                        </div>
	                    </td>
	                    </c:if>
	                    <td class="w90"><span class="louceng" title="楼层数">${item.sumFloor+1}</span></td>
	                    <td class="w500">
	                        <a class="motif" href="${ctx}/bbs/noteDetails/${item.id}">${item.title}</a>
	                         <c:if test="${item.if_pick ==1}">
		                        <span class="jing">精</span>
	                         </c:if>
	                         <c:if test="${item.type eq '2'}">
		                        <span class="tou">投</span>
	                         </c:if>
	                        <span class="d">顶</span>
	                         <c:if test="${item.if_lock ==1}">
	                      	    <span class="suo">锁</span>
	                         </c:if>
	                    </td>
	                    <td class="w160">
	                        <dl>
	                            <dt>
	                                <span class="writers" title="主题作者：${item.usernick}" id="user" onmouseover="showUserInfo('${item.user_id}','#n_player_${num.index}')" onmouseout="hideUserInfo('#n_player_${num.index}')" onclick="window.location='${ctx}/center/${item.user_id}'">${item.usernick}</span>
	                                <span id="jl">
	                                    <!--名片-->
	                                    <div class="card" id="n_player_${num.index}">
	                                    </div>
	                                </span>
	                            </dt>
	                            <dd>
	                            	<span class="times ml20">
	                            		<fmt:formatDate value="${item.create_time}" pattern="HH:mm:ss"/>
	                            	</span>
	                           	</dd>
	                        </dl>
	                    </td>
	                    <td class="w160">
	                        <dl>
	                            <dt><span class="reflex" onmouseover="showUserInfo('${item.last_reply_user_id}','#ren_player_${num.index}')" onmouseout="hideUserInfo('#ren_player_${num.index}')" onclick="window.location='${ctx}/center/${item.last_reply_user_id}'">${item.last_reply_usernick}</span>
	                            <span id="jl">
	                                    <!--名片-->
	                                    <div class="card" id="ren_player_${num.index}">
	                                    </div>
	                                </span>
	                            </dt>
	                            <dd>
	                            	<span class="times ml20">
	                            		<c:if test="${not empty item.last_reply_user_id}">
	                            		<fmt:formatDate value="${item.last_reply_time}" pattern="HH:mm:ss"/>
	                            		</c:if>
	                            	</span>
	                           	</dd>
	                        </dl>
	                    </td>
	                </tr>
	            	</c:forEach>
                </tbody>
            </table>
            		<c:choose>
            			<c:when test="${if_del eq '1'}">
            			<div id="back_tools">
					<span class="f14 text-white ms ml25" onclick="staus_change(this,1)" id="bankuai">删除主题</span>
					<span class="f14 text-white ms ml25" id="bankuai" onclick="staus_change(this,2)" style="color: #999;cursor: pointer;">屏蔽主题</span>
						</div>
            			</c:when>
            			<c:otherwise>
					<span class="f14 text-white ms ml25" id="bankuai">版块主题</span>
            			</c:otherwise>
            		</c:choose>
		            <div class="fenge" id="fenge"></div>
		            <div id="bottabData">
		            	<!-- 第二层列表数据 -->
		            </div>
		            <c:choose>
		            	<c:when test="${if_del eq '1'}">
		            	<input type="hidden" id="plate_id" name="plate_id" value="${plate_id}"/>
		            	</c:when>
		            	<c:otherwise>
		    	      		<c:choose>
						    	<c:when test="${empty session_user_id}">
						    	 <input type="hidden" id="plate_id" name="plate_id" value="${plate_id}"/>
						    		<div class="nologin">
						                <span>你需要登录才能发帖</span>
						                <a onclick="check_user_role()" style="cursor: pointer;" class="text-orange ml10">登录</a><span>|</span><a href="${ctx}/register/registerAccount" class="text-orange">注册</a>
						            </div>
						    	</c:when>
						    	<c:otherwise>
						    		<div class="publish_area">
						                <span href="javascript:void(0);" class="ft active" id="fabu">发表新帖</a><span class="text-gray-s_999 ml15">|</span><a href="javascript:window.location='${ctx}/bbs/toVotePage?plate_id=${plate_id}'" class="ft ml15">发起投票</a>
						              <form id="noteForm">
						                <input type="hidden" id="plate_id" name="plate_id" value="${plate_id}"/>
						                <input type="hidden" id="pre_content" name="pre_content" value=""/>
						                <input type="hidden" name="type" value="1"/>
						                <input type="hidden" name="note_id" value=""/>
						                <input type="text" id="title" name="title" value="" valid="require len(0,60)" placeholder="请填写标题" class="headings" />
						                <div class="the_text">
						                    <textarea id="content" name="content" class="textbox"></textarea>
						                    <div class="attachment">
						                    	<!--附件上传后需要把附件地址设置到此处  -->
						                        <ol id="attrc_ol">
						                        </ol>
						                    </div>
						                    <div class="publish">
						                        <!-- <input type="checkbox" name="charge" value="1" id="pay_down"/><span class="text-white ml5">用户下载需要支付宇币</span> -->
						                        <input type="checkbox" name="reply_look" value="1" class="ml15" id="hide_on"/><span class="text-white ml5">内容回复可见</span>
						                        <a onclick="upload_attrc()" style="cursor: pointer;" class="up ml10">上传附件</a>
						                        <input type="file" name="file" id="file_upload" style="display: none;" value="附件" />
						                        <input type="button" name="name" value="发表" class="btn_l ml15 mr20" onclick="saveNote()"/>
						                    </div>
						                    <div class="clearit"></div>
						                </div>
						              </form> 
						            </div>
						    	</c:otherwise>
					  		  </c:choose>  
            			</c:otherwise>
           			</c:choose>
        </div>
    </div>
 	<%@ include file="../common/footer.jsp" %>
	<script src="${ctx}/resources/ueditor/ueditor.config.web.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ueditor/ueditor.all.min.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/jquery.fileupload.js" type="text/javascript"></script>
	<script src="${ctx}/resources/js/person_info.js" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }
        var ue;
        $(function(){
        	searchResult();
        	var note_if_del = $("#note_if_del").val();
        	if(note_if_del!=1){
        		if('${session_user_id}'!=null && '${session_user_id}'!=''){
		        	if(ue){
		            	ue.destroy();
		            }
		            ue = UE.getEditor('content');
        		}
	            create_uploadify();
        	}
            //$(".uploadify").css({ "display": "inline-block","width":"75px","height":"20px" });
        });
        
        function searchResult(){
        	var my = "${my}";
        	var focus = "${focus}";
        	if(my == "" &&  focus == ""){
        		loadNotes(1);
        	}else{
        		loadMyNotes(1);
        	}
        }
        
        function upload_attrc(){
        	if(!check_user_role())return;
        	$('#file_upload').trigger('click');
        }
        
        function create_uploadify(){
        	var uid = (+new Date()).toString( 32 );
        	var ol = $("#attrc_ol");
        	$('#file_upload').fileupload({
        		url:"${ctx}/imageVideo/uploadImgTemp",
        		formData:{filetype:'attac',size:100},
        		dataType: 'json',
        		fileSingleSizeLimit:100*1024*1024,
        		messages:{fileSingleSizeLimit:'上传文件大小不能大于100M'},
        		add: function (e, data) {
        			var num = ol.find("li").length;
        			if(num>=7){
        				layer.msg("上传附件不能超过 7 个！",{icon: 2});
        			}
                    if (e.isDefaultPrevented()) {
                        return false;
                    }
                    if (data.autoUpload || (data.autoUpload !== false &&
                            $(this).fileupload('option', 'autoUpload'))) {
                        data.process().done(function () {
                            data.submit();
                        });
                    }
                    var file = data.files[0];
                    ol.append('<li id="attrc_li_'+uid+'"><a href="javascript:void(0);" class="fj">'+file.name+'</a><span id="attrc_pro_'+uid+'" class="ml10 text-white">0%</span></li>');
                    
                },
        		done: function (e, data) {
        			var res = data.result;
        			if(res.state=='success'){
        				var num = ol.find("li").length-1;
        				var file = data.files[0];
        				show_pay_enc(uid);
        				var li = $("#attrc_li_"+uid);
        				li.append('<input type="hidden" name="attrcs['+num+'].name" value="'+file.name+'"/>');
        				li.append('<input type="hidden" id="file_url_'+uid+'" name="attrcs['+num+'].file_url" value="'+res.data.filename+'"/>');
        				li.append('<input type="hidden" name="attrcs['+num+'].size" value="'+file.size+'"/>');
        			}else{
        				$("#attrc_li_"+uid).remove();
        				layer.msg(res.message.error[0],{icon: 2});
        			}
        			uid = (+new Date()).toString( 32 );
        		},
        		progressall: function (e, data) {
        			var progress = parseInt(data.loaded / data.total * 100, 10);
        			$("#attrc_pro_"+uid).text(progress+"%");
        		}
        	});
        }
        //设置附件价格 gl
        function show_pay_enc(uid){
        	$(".masker").height($(document).height()).fadeIn();
            $(".pay_enc").center().fadeIn();
            $("#shezhi").attr("checked", false);
            $(".pay_region .setting").hide();
            $("#attrc_uid").val(uid);
        }
        $("#shezhi").click(function() {
            if ($("#shezhi").is(":checked")) {
                $(".pay_region .setting").show();
            } else {
                $(".pay_region .setting").hide();
                $("#attrc_price").val("0");
            }
        });
        
        function submitPayEnc(){
        	var num = $("#attrc_ol").find("li").length-1;
        	var price = $("#attrc_price").val();
        	if (new RegExp('[^0-9]').test(price)) {
        		layer.tips('请输入大于0的正整数!', '#attrc_price',{
    				tips: [2, '#c00'],
    				time: 3000
    			});
                return;
            }
        	$("#attrc_price").val("0");
        	$("#shezhi").attr("checked", false);
        	var uid =  $("#attrc_uid").val();
        	close();
        	var li = $("#attrc_li_"+uid);
        	li.append('<input type="hidden" name="attrcs['+num+'].price" value="'+price+'"/>');
        	li.append('<span class="ml10 text-white">售价：'+price+' 宇币</span>');
			li.append('<a  onclick="deletePayEnc(this,\''+uid+'\')" style="cursor: pointer;" class="text-red ml10">删除</a></li>');
        }
        
        function cannelPayEnc(){
        	var num = $("#attrc_ol").find("li").length-1;
        	$("#attrc_price").val("0");
        	$("#shezhi").attr("checked", false);
        	var uid =  $("#attrc_uid").val();
        	close();
        	var li = $("#attrc_li_"+uid);
        	li.append('<input type="hidden" name="attrcs['+num+'].price" value="0"/>');
        	li.append('<span class="ml10 text-white">售价：0 宇币</span>');
			li.append('<a onclick="deletePayEnc(this,\''+uid+'\')" style="cursor: pointer;" class="text-red ml10">删除</a></li>');
        }
        
        function deletePayEnc(dom,uid){
        	var path = $("#file_url_"+uid).val();
        	if(path){
	        	$.ajax({
	                cache: false,
	                //async: false,
	                type: 'POST',
	                dataType: 'json',
	                data: { "src": path},
	                url: base + "/imageVideo/deleteFile",
	                success: function (data) {
	                	$("#attrc_li_"+uid).remove();
	                },
	                error: function () {
	                    layer.msg('删除失败',{icon: 2});
	                }
	            });
        	}
        }

        //设置价格弹出
        $("#pay_down").click(function() {
            if ($("#pay_down").is(":checked")) {
                if ($("#ac_file_url").val() == "") {
                        layer.msg("你没有上传附件！", { icon: 2 });
                        $("#pay_down").attr("checked", false);
                    }
                }
                if($("#ac_file_url").val() != ""){
                	  $(".masker").height($(document).height()).fadeIn();
                      $(".pay_download").center().fadeIn();
                }
              
            
        });

        $("#hide_on").click(function () {
            if ($(this).is(":checked")) {
                $(".masker").height($(document).height()).fadeIn();
                $(".back_visible").center().fadeIn();
            }
        });

        function close() {
        	$(".pay_enc").fadeOut();
            $(".pay_download").fadeOut();
            $(".masker").fadeOut();
            $(".back_visible").fadeOut();

            $("#pay_down").attr("checked", false);
            $("#hide_on").attr("checked", false);
        }

        $(".masker").click(function () {
            //close();
        });
        
        /**加载我的及我关注的用户的帖子*/
        function loadMyNotes(currentPage){
        	if(typeof(currentPage) == "undefined"){
        		var pIndex = $("#pIndex").val();
        		if(pIndex == ""){
        			layer.msg("输入框为空！",{icon:2});
        			return false;
        		}else if(isNaN(pIndex)){
        			layer.msg("输入必须为数字！",{icon:2});
        			return false;
        		}
        		currentPage = pIndex;
        	}
        	
        	var focus = "${focus}";
        	if(focus == ""){
        		focus = "";
        	}else{
        		focus = "focus="+focus+"&";
        	}
        	
        	var load_html = '<img alt="数据加载中" loading src="${ctx}/resources/images/loading.gif" style="position: relative; width: 40px;height: 40px;left: 468px;margin-top:40px;">';
        	
        	$.ajax({
    			type :'POST',
    			url : base+"/bbs/myBbsNotelist?"+focus+"random="+Math.random(),
    			data : {"plate_id":$("#plate_id").val(),"title":$("#searchTitle").val(),"currentPage":currentPage,"pageSize":22},
    			dataType:"HTML",
    			beforeSend:function(){
    				$("#bottabData").empty();
    				$("#bottabData").html(load_html);
    			},
    			success : function(result) {
    				if(result.state=='error'){
    					layer.msg(result.message.error[0]);
    				}else{
    					$("#bottabData").empty();
    					$("#bottabData").html(result);
    					$("#bankuai").hide();
    					$("#fenge").hide();
    				}
    			},
    			error : $.ajaxError
    		});
        }
        //加载贴子数据列表
        function loadNotes(currentPage){
        	if(typeof(currentPage) == "undefined"){
        		var pIndex = $("#pIndex").val();
        		if(pIndex == ""){
        			layer.msg("输入框为空！",{icon:2});
        			return false;
        		}else if(isNaN(pIndex)){
        			layer.msg("输入必须为数字！",{icon:2});
        			return false;
        		}
        		currentPage = pIndex;
        	}
        	var pageSize=22;
        	if(currentPage!=1){
        		$("#toptabArea").hide();
        		//pageSize=22;
        	}else{
        		$("#toptabArea").show();
        	}
        	//贴子状态
        	var status = $("#NoteStatus").val();
        	var if_del = $("#note_if_del").val();
        	var if_show = $("#note_if_show").val();
        	
        	var load_html = '<img alt="数据加载中" loading src="${ctx}/resources/images/loading.gif" style="position: relative; width: 40px;height: 40px;left: 468px;margin-top:40px;">';
        	
        	$.ajax({
    			type :'POST',
    			url : base+"/bbs/listData?random="+Math.random(),
    			data : {"plate_id":$("#plate_id").val(),"title":$("#searchTitle").val(),"status":status,"if_del":if_del,"if_show":if_show,"currentPage":currentPage,"pageSize":pageSize},
    			dataType:"HTML",
    			beforeSend:function(){
    				$("#bottabData").empty();
    				$("#bottabData").html(load_html);
    			},
    			success : function(result) {
    				if(result.state=='error'){
    					layer.msg(result.message.error[0]);
    				}else{
    					$("#bottabData").empty();
    					$("#bottabData").html(result);
    				}
    			},
    			error : $.ajaxError
    		});
        }
        
        //设置勾选内容回复可见内容
        function setPreContent(){
        	var content = $("#set_content").val();
        	if(content==null || content==''){
        		layer.msg("内容不能为空！",{icon:2});
        	}
        	$("#pre_content").val(content);
            $(".masker").fadeOut();
            $(".back_visible").fadeOut();
        	 $("#hide_on").attr("checked", "checked");
        }
        
        //设置附件购买价格
        function setPrice(){
        	var price = $("#set_price").val();
        	if(price==null || price==''){
        		layer.msg("价格不能为空！",{icon:2});
        	}
        	$("#ac_price").val(price);
        	  $(".masker").fadeOut();
        	  $(".pay_download").fadeOut();
        	$("#pay_down").attr("checked", "checked");
        }
        
        //保存贴子
        function saveNote(){
        	var content = ue.getContent();
        	if(!content){
        		layer.msg("请输入帖子内容！",{icon:2});
        		return;
        	}
        	var str = ue.getContentTxt();
        	var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
        	if(len<5||str.trim()==''){
        		layer.msg("请输入至少五个字符!",{icon:2});
        		return;
        	}
        	
        	$.ajaxSec({
        		context:$("#noteForm"),
        		type:'post',
        		url:base+"/bbs/saveOrUpNote?random="+Math.random(),
      			data:$("#noteForm").serialize(),
      			dataType:"json",
      			success:function(data){
      				if(data.state=="success"){
      					$("#title").val("");
      					$("#content").val("");
      					layer.msg("发布成功！",{icon:1});
      					window.setTimeout(function(){
	      					window.location.reload();
      						//loadNotes(1);
      					},2000);
      				}
      			},
        	});
        }
        function cannelPrice() {
            close();
        }

        function cannelPreContent() {
        	$("#set_content").val("");
            close();
        }

        $(".sting").each(function() {
            $(this).click(function() {
                $(this).next().show();
            });
        });
        
        /**设置帖子置顶等功能*/
        function setNoteTop(id,type,status,plate_id){
        	if(id == ''){
        		 layer.msg("id不能为空",{icon: 2});
        		 return;
        	 }
        	 $.ajaxSec({
        			type: 'POST',
        			url: base+'/bbs/setNoteIfStatus',
        			data: {id: id,type:type,status:status,plate_id:plate_id},
        			success: function(data){
        				if (data.state=='success') {
        					layer.msg("设置成功",{icon: 1});
        					$(".bztool").hide();
        					window.location.reload();
        				}else{
        					$(".bztool").hide();
        					layer.msg(data.message.error[0],{icon: 2});
        				}
        		    },
        		   error: $.ajaxError
        	  });
        	
        }
        $(document).click(function (e) {
            if (!$(".bztool").is(':has(' + e.target.localName + ')') && e.target.id != 'sting') {
                $(".bztool").hide();
            }
        });
        
        function staus_change(dom,type){
        	$("#back_tools").find("span").css("color","#999").css("cursor","pointer");
        	$(dom).removeAttr("style");
        	if(type==2){
        		$("#note_if_show").val(2);
        	}else{
        		$("#note_if_show").val(1);
        	}
        	loadNotes(1);
        }
        
    </script>
</body>
</html>