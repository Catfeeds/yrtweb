<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="currentPage" value="BBS"/>
<title>编辑贴子</title>
</head>
<body>
 <div class="warp">
        <div class="masker"></div>
        <!--附件设置价格-->
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
            <div class="closeBtn_1" onclick="cannelPreContent()"></div>
            <div class="set_back">
                <p class="text-white">如果您的帖子设置了回复可见，请在此处设置回复前的可见内容： </p>
                <textarea class="hidetxt" id="set_content" name="pre_content">${bbsNote.pre_content}</textarea>
                <input type="button" name="name" value="设置" onclick="setPreContent()" class="btn_l mt20 ml150" /><input type="button" name="name" value="取消" onclick="cannelPreContent()" class="btn_g mt20 ml25" />
            </div>
        </div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %> 
        <!--导航-->
        <%@ include file="../common/naver.jsp" %>  
        <div class="bbs">
            <div class="title">
                <div class="pull-left ml15">
                    <span class="active">编辑主题</span>
                </div>
                <div class="clearit"></div>
            </div>
           
            <div class="publish_area">
             <form id="noteForm">
                <input type="hidden" id="plate_id" name="plate_id" value="${bbsNote.plate_id}"/>
                <input type="hidden" id="pre_content" name="pre_content" value="${bbsNote.pre_content}"/>
                <input type="hidden" name="type" value="1"/>
                <input type="hidden" name="note_id" value="${bbsNote.id}"/>
                <div class="the_text">
                	<input type="hidden" id="title" name="title" value="${bbsNote.title}"/>
                    <p class="text-white mt20 ml20 f14"><span style="font-size: 16px;">标题：</span>${bbsNote.title}</p>
                    <div class="mt10"></div>
                     <textarea id="content" name="content" class="textbox" style="height: 300px;">${bbsNote.content}</textarea>
                    <div class="attachment">
                 	    <!--附件上传后需要把附件地址设置到此处  -->
                        <ol id=attrc_ol>
                        	<c:forEach items="${bbsAccessories}" var="acc">
	                            <li>
	                            	<a href="javascript:downloadFile('${acc.id }','${acc.name}','${acc.file_url}')" class="fj">${acc.name}</a>
	                            	<span class="ml10 text-white">售价：<fmt:formatNumber value="${acc.price}" pattern="0"/> 宇币</span>
	                            	<a onclick="delete_attrc(this,'${acc.id}')" style="cursor: pointer;" class="text-red ml10">删除</a>
                            	</li>
                        	</c:forEach>
                        </ol>
                    </div>
                    <div class="publish">
                    	<%-- <c:if test="${!empty bbsAccessories}">
                        <input attrc type="checkbox" name="charge" <c:if test="${sumAmount>0}">checked="checked"</c:if> value="1" id="pay_down"/><span attrc class="text-white ml5">用户下载需要支付宇币</span>
                    	</c:if> --%>
                        <input type="checkbox" name="reply_look" <c:if test="${bbsNote.if_reply==1}">checked="checked"</c:if> value="1" class="ml15" id="hide_on"/>
                        <span class="text-white ml5">内容回复可见</span>
                        <a onclick="upload_attrc()" style="cursor: pointer;" class="up ml10">上传附件</a>
                        <input type="file" name="file" id="file_upload" style="display: none;" value="附件" />
                        <input type="button" name="name" value="发表" class="btn_l ml15 " onclick="saveNote()"/>
                        <input type="button" name="name" value="返回" class="btn_l ml15 mr20" onclick="javascript:history.back(-1);"/>
                    </div>
                    <div class="clearit"></div>
                </div>
              </form>  
            </div>   
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
	<script src="${ctx}/resources/ueditor/ueditor.config.web.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ueditor/ueditor.all.min.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="${ctx}/resources/jfileupload/js/jquery.fileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ue = UE.getEditor("content");

        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }
        $(function(){
        	create_uploadify();
        })
        function upload_attrc(){
        	if(!check_user_role())return;
        	$('#file_upload').trigger('click');
        }
        
        function create_uploadify(){
        	var uid = (+new Date()).toString( 32 );
        	var ol = $("#attrc_ol");
        	$('#file_upload').fileupload({
        		url:"${ctx}/imageVideo/uploadImgTemp",
        		formData:{filetype:'attac',size:20},
        		dataType: 'json',
        		fileSingleSizeLimit:20*1024*1024,
        		messages:{fileSingleSizeLimit:'上传文件大小不能大于20M'},
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

        $("#user").mouseover(function () {
            $("#n_player").show();
        });

        $("#n_player").mouseout(function () {
            function hide() {
                $("#n_player").hide();
            }
            setTimeout(hide, 2500);
        });

        //设置价格弹出
        $("#pay_down").click(function () {
            if ($(this).is(":checked")) {
                $(".masker").height($(document).height()).fadeIn().css({"z-index":1000});
                $(".pay_download").center().fadeIn().css({"z-index":1001});
            }
        });

        $("#hide_on").click(function () {
            if ($(this).is(":checked")) {
                $(".masker").height($(document).height()).fadeIn();
                $(".back_visible").center().fadeIn().css({ "z-index": 1001 });
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

        function cannelPrice() {
            close();
        }
        
        function cannelPreContent() {
            close();
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
        function post(URL, PARAMS) {        
            var temp = document.createElement("form");        
            temp.action = URL;        
            temp.method = "post";        
            temp.style.display = "none";        
            for (var x in PARAMS) {        
                var opt = document.createElement("textarea");        
                opt.name = x;        
                opt.value = PARAMS[x];        
                temp.appendChild(opt);        
            }        
            document.body.appendChild(temp);        
            temp.submit();        
            return temp;        
        }
        
        function downloadFile(ac_id,file_name,file_url){
    		var url = base+"/bbs/download?random="+Math.random();
    		post(url,{ac_id:ac_id,file_name:file_name,file_url:file_url});
    	}
        
        function delete_attrc(dom,aid){
        	yrt.confirm('确定要删除该附件吗？', {
        	    btn: ['确定','取消'], //按钮
        	    shade: true
        	}, function(){
        		$.ajaxSec({
            		type:'post',
            		url:base+"/bbs/deleteAccessories?random="+Math.random(),
          			data:{aid:aid},
          			dataType:"json",
          			success:function(data){
          				if(data.state=="success"){
          					yrt.msg("删除成功！",{icon:1});
          					$(dom).parent().remove();
          				}else{
          					yrt.msg("删除失败！",{icon:2});
          				}
          			}
            	});
        	}, function(){});
        }
        
        //更新贴子
        function saveNote(){
        	var content = ue.getContent();
        	if(!content){
        		layer.msg("请输入帖子内容！",{icon:2});
        		return;
        	}
        	var str = ue.getContentTxt();
        	var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
        	if(len<5){
        		layer.msg("请输入至少五个字符!",{icon:2});
        		return;
        	}
        	$.ajaxSec({
        		type:'post',
        		url:base+"/bbs/saveOrUpNote?random="+Math.random(),
      			data:$("#noteForm").serialize(),
      			dataType:"json",
      			success:function(data){
      				if(data.state=="success"){
      					layer.msg("更新成功！",{icon:1});
      					window.setTimeout(function(){
	      					window.location=base+"/bbs/noteDetails/${bbsNote.id}";
      					},2000);
      				}
      			}
        	});
        }

    </script>
</body>
</html>