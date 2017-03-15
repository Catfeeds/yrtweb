<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<c:set var="currentPage" value="BBS"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${note.title}</title>
<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<style type="text/css">
body {
    font: 14px/20px "SimSun","宋体","Arial Narrow",HELVETICA!important;
}
</style>
</head>
<body>
    <div class="warp">
       <div class="masker" onclick="cancel()"></div>
       <!--举报-->
        <div class="report">
            <div class="title">
                <div class="closeBtn_1" onclick="cancel()"></div>
                <span class="text-white f14 ms">举&emsp;报</span>
            </div>
            <div class="zt">
                <form id="bbsTipForm">
                     <input id="bbsTipNoteId" name="note_id" value="${note_id }" type="hidden"/>
			         <input id="bbsTipBuserId" name="b_user_id" value="" type="hidden"/>
			         <input id="bbsTipNoteReplyId" name="note_reply_id" value="" type="hidden"/>
	                <p class="f16 ms text-white">违规类型</p>
	                <dl>
	                    <dd><input type="radio" value="1" name="type" /><span>广告推广</span></dd>
	                    <dd><input type="radio" value="2" name="type" /><span>色情内容</span></dd>
	                    <dd><input type="radio" value="3" name="type" /><span>言语辱骂/人身攻击</span></dd>
	                    <dd><input type="radio" value="4" name="type" /><span>讨论敏感话题</span></dd>
	                    <dd><input type="radio" value="5" name="type" checked="checked"/><span>其他</span></dd>
	                </dl>
	                <p class="f16 ms text-white mt10">违规描述</p>
	                <textarea class="r_cent" name="content"></textarea>
                </form>
            </div>
            <input type="button" value="提交" class="btn_l" onclick="submitBbsTip()" style="margin-left: 145px;" />
            <input type="button" name="name" value="取消" class="btn_g ml10" onclick="cancel()"/>
        </div>
       <!--头部-->
		<%@ include file="../common/header.jsp" %>
		<!--导航 start-->
		<%@ include file="../common/naver.jsp" %>
 
        <div class="bbs">
            <div class="title">
                <div class="pull-left ml15">
                    <span <c:if test="${empty status }">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${note.plate_id}'">全部</span><span>|</span>
                    <span <c:if test="${status eq 'PICK'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${note.plate_id}&status=PICK'">精华</span><span>|</span>
                    <span <c:if test="${focus eq 'focus'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/toMyBbsNotelist?plate_id=${note.plate_id}&focus=focus'" >关注</span><span>|</span>
                    <span <c:if test="${not empty session_user_id &&  my eq 'my' && empty focus}">class="active"</c:if> 
                              onclick="javascript:window.location='${ctx}/bbs/toMyBbsNotelist?plate_id=${note.plate_id}'">我的</span>
                    <c:if test="${ifLeader eq true}">
                    <span>|</span><span <c:if test="${if_del eq '1'}">class="active"</c:if> onclick="javascript:window.location='${ctx}/bbs/list?plate_id=${note.plate_id}&if_del=1'">回收站</span>
                    </c:if>
                </div>
                <div class="pull-right">
                	<c:choose>
                		<c:when test="${empty see_lz}">
		                    <input type="button" onclick="see_lz(this,1)" value="只看楼主" class="onlyU f14 ms ml10 mr10" />
                		</c:when>
                		<c:otherwise>
                			<input type="button" onclick="see_lz(this)" value="取消只看楼主" class="onlyU f14 ms ml10 mr10" />
                		</c:otherwise>
                	</c:choose>
                    <a type="button" class="onlyU f14 ms ml10 mr10" href="#send_reply" />回复</a>
                </div>
            </div>
            <div class="structure">
                <!--帖子标题-->
                <div class="post_title">
                	<input type="hidden" id="currentPage" value="${page.currentPage}"/>
                	<input type="hidden" id="note_id" value="${note.id}"/>
                	<input type="hidden" id="plate_id" value="${note.plate_id}"/>
                	<input type="hidden" id="note_if_lock" value="${note.if_lock}"/>
                    <a href="${ctx}/bbs/list?plate_id=${note.plate_id}" class="text-white f16 ms ml15">话题列表</a>
                    <span class="text-white f16 ml10">>></span>
                    <a href="javascript:void(0);" class="text-white f16 ms ml15">${note.title}</a>
                </div>
                <c:choose>
					<c:when test="${page.pageCount!=0}">
					<ul class="pagination" style="float: right;margin-top: 0;">
						<c:choose>
							<c:when test="${page.currentPage!=1}">
							<li data-command="prev" onclick="reload_not_details('${page.currentPage-1}','${see_lz}')"><a>上一页</a></li>
					        <li data-page-num="${page.currentPage-1}" onclick="reload_not_details('${page.currentPage-1}','${see_lz}')"><a>${page.currentPage-1}</a></li>
					        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
							</c:when>
							<c:when test="${page.currentPage==1}">
							<li data-command="prev"><a>上一页</a></li>
					        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
					        </c:when>
						</c:choose>
						<c:choose>
							<c:when test="${page.currentPage!=page.pageCount}">
							<li data-page-num="${page.currentPage+1}" onclick="reload_not_details('${page.currentPage+1}','${see_lz}')"><a>${page.currentPage+1}</a></li>
							<c:choose>
					            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
				            </c:choose>
				            <c:choose>
					            <c:when test="${(page.currentPage+1)!=page.pageCount}">
					            <li data-page-num="${page.pageCount}" onclick="reload_not_details('${page.pageCount}','${see_lz}')"><a>${page.pageCount}</a></li>
					            </c:when>
					        </c:choose>
					        <li data-command="next" onclick="reload_not_details('${page.currentPage+1}','${see_lz}')"><a>下一页</a></li>
							</c:when>
							<c:otherwise>
					    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
					    	</c:otherwise>
						</c:choose>
					</ul>
					</c:when>
					<c:otherwise>
						<ul class="pagination" style="float: right;margin-top: 0;">
							<li data-command="prev"><a>首页</a></li>
						</ul>
					</c:otherwise>
				</c:choose>
                <div class="clearit"></div>
                <table id="bbs_table" class="post_content">
                	<c:if test="${page.currentPage eq 1}">
                	<tr reply-time="${note.update_time}" note-id="${note.id}">
                        <td class="left">
                            <img src="${ctx}/resources/images/louzhu.png" alt="" class="louzhu" />
                            <ol class="dl">
                                <li><img src="${el:headPath()}${note.head_icon}" alt=""  class="avtar" id="${note.id}" onmouseover="showUserInfo('${note.user_id}','#n_player_${note.id}')" onmouseout="hideUserInfo('#n_player_${note.id}')" onclick="window.location='${ctx}/center/${note.user_id}'"/>
                                     <span id="jl">
	                                    <!--名片-->
	                                    <div class="card" id="n_player_${note.id}">
	                                    </div>
	                                </span></li>
	                             <li>
	                                <span class="username" onclick="javascript:window.location='${ctx}/center/${bbs.user_id}'" style="cursor: pointer;">${note.usernick}</span> 
	                             </li>
	                              <c:if test="${note.isme eq '0'}">
                                <li>
                                	<c:choose>
                                		<c:when test="${note.guanzhu eq '0'}">
                                   		 <input type="button" onclick="focus_user(this,'${note.user_id}')" title="关注" value="+&ensp;关注" class="btn_o" />
                                		</c:when>
                                		<c:otherwise>
	                                    <input type="button" onclick="focus_user(this,'${note.user_id}',true)" title="取消关注" value="已关注" class="btn_o" />
                                		</c:otherwise>
                                	</c:choose>
                                    <input type="button" onclick="openMsg('${note.user_id}','${note.usernick}')" value="私信" class="btn_o ml10" />
                                </li>
                                </c:if>
                            </ol>
                        </td>
                        <td class="right">
                        	<c:if test="${(note.isme eq '1' && note.if_del eq '2') || ifLeader eq tru}">
                        	<!--编辑删除user_txt_edit-->
                            <input type="button" onclick="location.href='${ctx}/bbs/editnote/${note.id}'" value="编辑" class="edit_btn mt10" />
                            <input type="button" onclick="delete_note('${note.id}')" value="删除" class="del_btn mt10 mr10" />
                            <div class="clearit"></div>
                        	</c:if>
                        	
                            <div id="bbs_content" class="user_txt">
                                <p class="text-white f14">
                                	<c:choose>
                                		<c:when test="${note.if_reply == 1 }">
                                			<c:choose>
                                				<c:when test="${replyCount >0 }">
                                				  ${note.content}
                                				</c:when>
                                				<c:otherwise>
		                                			${note.pre_content}
                                				 <p class="replytoshow ms mt20">本帖有回复可见内容，请回复后浏览。</p>
                                				</c:otherwise>
                                			</c:choose>
                                		</c:when>
                                		<c:otherwise>
			                                ${note.content}
                                		</c:otherwise>
                                	</c:choose>
                                </p>
                                <c:if test="${note.type eq '2' && !empty voteList}">
                                	<table class="tp">
                                		<c:forEach items="${voteList}" var="voteData">
		                                    <tr>
		                                        <td class="tp_left text-right" style="width: 230px;">
		                                            <span class="f14 text-white">${voteData.name}：</span>
		                                        </td>
		                                        <td class="tp_left" style="width: 370px;">
		                                            <div class="pro_bar">
		                                                <div class="pro" 
		                                                	<c:choose>
		                                                		<c:when test="${voteData.vote_count eq 0}">
		                                                			style="width:0px;"
		                                                		</c:when>
		                                                		<c:otherwise>
				                                                	style="width:<fmt:formatNumber value="${360*voteData.vote_count/voteCount}" pattern="#0"></fmt:formatNumber>px;"
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                                ></div>
		                                            </div>
		                                        </td>
		                                        <td class="tp_left text-left" style="width: 130px;">
		                                            <span class="text-white f14 pull-left">
		                                            	<c:choose>
		                                                		<c:when test="${voteData.vote_count eq 0}">
		                                                			0(0%)
		                                                		</c:when>
		                                                		<c:otherwise>
					                                            	${voteData.vote_count}(<fmt:formatNumber value="${voteData.vote_count*100/voteCount}" pattern="#0"></fmt:formatNumber>%)
		                                                		</c:otherwise>
		                                                	</c:choose>
		                                            </span>
		                                           	<c:if test="${ifVote eq false}">
			                                            	<c:if test="${voteData.end_time.time - nowDate.time>0}">
					                                            <c:choose>
					                                            	<c:when test="${voteData.type eq 1}">
							                                            <input type="radio" name="data_id" value="${voteData.id}" class="pull-right mt5" />
					                                            	</c:when>
					                                            	<c:otherwise>
					                                            		<input type="checkbox" name="data_id" value="${voteData.id}" class="pull-right mt5" />
					                                            	</c:otherwise>
					                                            </c:choose>
				                                            </c:if>
			                                            <div class="clearit"></div>
		                                        	</c:if>
		                                        </td>
		                                    </tr>
		                                 </c:forEach>   
	                                </table>
	                                 <c:if test="${ifVote eq false}">
	                                	<input type="button" name="vote_btn" value="投票" class="btn_l ml15 ms mt20" onclick="checkVote();"/>
                              		 </c:if>
                                </c:if>
                                <div class="down">
                                	<c:choose>
                                		<c:when test="${note.if_reply == 1 }">
                                			<c:choose>
                                				<c:when test="${replyCount >0 }">
	                                				  <c:choose>
					                                		<c:when test="${!empty session_user_id}">
																<c:choose>
																	<c:when test="${!empty charinfo}"><!-- 已购买附件 -->
																		<c:forEach items="${aces}" var="ace"><!-- 放置下载链接 -->
																			<c:choose>
																				<c:when test="${fn:contains(aceids,ace.id)}">
																					<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																					<span class="text-gray-s_999 ml10">已有${ace.buyCount}人购买此附件</span><br>
																				</c:when>
																				<c:otherwise>
																					 <c:choose>
																					 	<c:when test="${ace.price > 0}">
																					 	     <a href="javascript:buyalarm('请先购买')" class="d_link">${ace.name}</a>
																							 <span class="text-white ml10">下载此附件需要支付<fmt:formatNumber value="${ace.price}"/>宇拓币</span> 
											                                    			 <input type="button" name="name" value="购买" onclick="buyNoteAccess('${note.id}','${ace.price}','${ace.id }');" class="btn_l"/>
									                                    					 <span class="text-gray-s_999 ml10">已有${ace.buyCount}人购买此附件</span><br>
																					 	</c:when>
																					 	<c:otherwise>
																					 		<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																					 		<span class="text-gray-s_999 ml10">该附件已被下载${ace.download}次</span><br>
																					 	</c:otherwise>
																					 </c:choose>
																				</c:otherwise>
																			</c:choose>
																		</c:forEach>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${!empty aces}">
																			<c:forEach items="${aces}" var="ace">
																				 <span style="color: #999;">附件：</span>
																				 <c:choose>
																				 	<c:when test="${ace.price >0}">
																						 <a href="javascript:buyalarm('请先购买')" class="d_link">${ace.name}</a>
																						 <span class="text-white ml10">下载此附件需要支付${ace.price}宇拓币</span> 
										                                    			 <input type="button" name="name" value="购买" onclick="buyNoteAccess('${note.id}','${ace.price}','${ace.id }');" class="btn_l"/>
										                                    			 <span class="text-gray-s_999 ml10">已有${ace.buyCount}人购买此附件</span><br>
																				 	</c:when>
																				 	<c:otherwise>
																				 		<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																				 		<span class="text-gray-s_999 ml10">该附件已被下载${ace.download}次</span><br>
																				 	</c:otherwise>
																				 </c:choose>
																			</c:forEach>
						                                    			 </c:if>
																	</c:otherwise>
																</c:choose>
					                                		</c:when>
					                                		<c:otherwise>
				                                				<c:if test="${!empty aces}">
			                                					<span class="text-gray-s_999">请<a onclick="check_user_role()" class="text-white" style="cursor: pointer;">登录</a>查看附件</span>	
			                                					</c:if>
					                                		</c:otherwise>
					                                	</c:choose>
                                				</c:when>
                                				<c:otherwise>
                                					<c:if test="${!empty aces}">
			                                			<span style="color:#999 ;">此附件仅回复可见</span>
                                					</c:if>
                                				</c:otherwise>
                                			</c:choose>
                                		</c:when>
                                		<c:otherwise>
                                				<c:choose>
				                                		<c:when test="${!empty session_user_id}">
															<c:choose>
																<c:when test="${!empty charinfo}"><!-- 已购买附件 -->
																	<span style="color: #999;margin-left:-42px;">附件:</span> 
																	<c:forEach items="${aces}" var="ace"><!-- 放置下载链接 -->
																		<c:choose>
																			<c:when test="${fn:contains(aceids,ace.id)}">
																				<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																				<span class="text-gray-s_999 ml10">已有${ace.buyCount}人购买此附件</span><br>
																			</c:when>
																			<c:otherwise>
																				 <c:choose>
																				 	<c:when test="${ace.price > 0}">
																						 <a href="javascript:buyalarm('请先购买')" class="d_link">${ace.name}</a>
																						 <span class="text-white ml10 f12">下载此附件需要支付${ace.price}宇拓币</span> 
										                                    			 <input type="button" name="name" value="购买" onclick="buyNoteAccess('${note.id}','${ace.price}','${ace.id }');" class="btn_l"/>
										                                    			 <span class="text-gray-s_999 ml10 f12">已有${ace.buyCount}人购买此附件</span><br>
																				 	</c:when>
																				 	<c:otherwise>
																				 		<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																				 		<span class="text-gray-s_999 ml10">该附件已被下载${ace.download}次</span><br>
																				 	</c:otherwise>
																				 </c:choose>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<c:if test="${!empty aces}">
																		<c:choose>
																			<c:when test="${note.isme eq '1'}">
																				<span style="color: #999;margin-left:-42px;">附件:</span> 
																				<c:forEach items="${aces}" var="ace">
																					<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																					<c:choose>
																						<c:when test="${ace.price > 0}">
																							<span class="text-gray-s_999 ml10">已有${ace.buyCount}人购买此附件</span><br>
																						</c:when>
																						<c:otherwise>
																							<span class="text-gray-s_999 ml10">该附件已被下载${ace.download}次</span><br>
																						</c:otherwise>
																					</c:choose>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<span style="color: #999;margin-left:-42px;">附件:</span> 
																				<c:forEach items="${aces}" var="ace">
																				    
																				     <c:choose>
																				     	<c:when test="${ace.price > 0}">
																							 <a href="javascript:buyalarm('请先购买')" class="d_link">${ace.name}</a>
																							 <span class="text-white ml10 f12">下载此附件需要支付${ace.price}宇拓币</span> 
											                                    			 <input type="button" name="name" value="购买" onclick="buyNoteAccess('${note.id}','${ace.price}','${ace.id}');" class="btn_l"/>
											                                    			 <span class="text-gray-s_999 ml10 f12">已有${ace.buyCount}人购买此附件</span><br>
																				     	</c:when>
																				     	<c:otherwise>
																				     		<a href="javascript:downloadFile('${ace.id }','${ace.name}','${ace.file_url}')" class="d_link" title="点击下载">${ace.name}</a>
																				     		<span class="text-gray-s_999 ml10">该附件已被下载${ace.download}次</span><br>
																				     	</c:otherwise>
																				     </c:choose>
									                                    			
																				</c:forEach>
																			</c:otherwise>
																		</c:choose>
					                                    			 </c:if>
																</c:otherwise>
															</c:choose>
				                                		</c:when>
				                                		<c:otherwise>
				                                			<c:if test="${!empty aces}">
					                                			<span class="text-gray-s_999">请<a onclick="check_user_role()" class="text-white" style="cursor: pointer;">登录</a>查看附件</span>	
		                                					</c:if>
				                                		</c:otherwise>
				                                	</c:choose>
                                		</c:otherwise>
                                	</c:choose>	
                                </div>
                            </div>
                            <div class="clearit"></div>
                            <c:if test="${not empty note.update_time}">
                            <div class="edittime">
                                <span>${note.usernick}</span>
                                <span>于</span>
                                <span><fmt:formatDate value="${note.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <span>编辑</span>
                            </div>
                            </c:if>
                            <div class="tools">
                                  
                                    <div style="float: right">
	                            <c:choose>
				                	<c:when test="${note.praise=='1'}">
                               			<a class="support ml10" title="取消点赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,1,'${note.id}')" style="cursor: pointer;">${note.priase_count}</a>
				                	</c:when>
				                    <c:otherwise>
				                		<a class="support ml10" title="赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,1,'${note.id}')" style="cursor: pointer;">${note.priase_count}</a>
				                	</c:otherwise>
				                </c:choose>
				                <c:choose>
				                	<c:when test="${videos.unpraise=='2'}">
                                		<a class="opposition ml10" title="取消点踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,1,'${note.id}')" style="cursor: pointer;">${note.unpriase_count}</a>
				                	</c:when>
				                	<c:otherwise>
				                		<a class="opposition ml10" title="踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,1,'${note.id}')" style="cursor: pointer;">${note.unpriase_count}</a>
				                	</c:otherwise>
				                </c:choose>
                                <c:if test="${note.isme eq '0'}">
                                <a class="f14 text-gray-s_999 ml30" href="javascript:void(0);" onclick="showBbsTip('','${note.user_id }',1)">举报</a>
                                </c:if>
                                <span class="f14 text-gray-s_999 ml5">|</span>
                                <span class="f14 text-white ml5"><fmt:formatDate value="${note.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <span class="f14 text-white ml15 mr20">1楼</span>
                                </div>
                                  <div class="jiathis_style_24x24" style="float: right">
                                        <a class="jiathis_button_tsina"></a>
                                        <a class="jiathis_button_tqq"></a>
                                        <a class="jiathis_button_weixin"></a>
                                        <a class="jiathis_button_renren"></a>
                                    </div>
                                    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                                <div class="clearit"></div>
                            </div>
                        </td>
                    </tr>
                	</c:if>
                	<c:forEach items="${page.items}" var="bbs">
                	<tr reply-time='<fmt:formatDate value="${bbs.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/>' note-id="${bbs.id}">
                        <td class="left">
                        	<c:if test="${bbs.islz eq '1'}">
                        	<img src="${ctx}/resources/images/louzhu.png" alt="" class="louzhu" />
                        	</c:if>
                            <ol class="dl">
                                <li><img onmouseover="showUserInfo('${bbs.user_id}','#down_player_${bbs.id}')" onmouseout="hideUserInfo('#down_player_${bbs.id}')" src="${el:headPath()}${bbs.head_icon}" alt="" class="avtar" />
                                <span id="jl">
	                                    <!--名片-->
	                                    <div class="card" id="down_player_${bbs.id}">
	                                    </div>
	                                </span>
                                </li>
                                <li><span class="username" onclick="javascript:window.location='${ctx}/center/${bbs.user_id}'" style="cursor: pointer;">${bbs.usernick}</span></li>
                                <c:if test="${bbs.isme eq '0'}">
                                <li>
                                	<c:choose>
                                		<c:when test="${bbs.guanzhu eq '0'}">
                                   		 <input type="button" onclick="focus_user(this,'${bbs.user_id}')" title="关注" value="+&ensp;关注" class="btn_o" />
                                		</c:when>
                                		<c:otherwise>
	                                    <input type="button" onclick="focus_user(this,'${bbs.user_id}',true)" title="取消关注" value="已关注" class="btn_o" />
                                		</c:otherwise>
                                	</c:choose>
                                    <input type="button" onclick="openMsg('${bbs.user_id}','${bbs.usernick}')" value="私信" class="btn_o ml10" />
                                </li>
                                </c:if>
                            </ol>
                        </td>
                        <td class="right">
                        	
                        	<c:if test="${(bbs.isme eq '1' && bbs.if_del eq '1') || ifLeader eq true}">
	                        	<!--编辑删除user_txt_edit-->
	                        	<div id="reply_tools_${bbs.id}">
	                            <input type="button" onclick="edit_reply('${bbs.id}')" value="编辑" class="edit_btn mt10" />
	                            <input type="button" onclick="delete_reply('${bbs.id}')" value="删除" class="del_btn mt10 mr10" />
	                            </div>
	                            <div class="clearit"></div>
                        	</c:if>
                        
                            <div id="reply_text_${bbs.id}" class="user_txt">
                                <p class="text-white f14">
                                <c:choose>
                                	<c:when test="${bbs.if_del eq '2'}">
                                	<em style="color: #888888;">该回复已经被删除！</em>
                                	</c:when>
                                	<c:otherwise>
	                                ${bbs.content}
                                	</c:otherwise>
                                </c:choose>
                                </p>
                            </div>
                            <div class="clearit"></div>
                            <c:if test="${not empty bbs.update_time}">
                            <div class="edittime">
                                <span>${bbs.usernick}</span>
                                <span>于</span>
                                <span><fmt:formatDate value="${bbs.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <span>编辑</span>
                            </div>
                            </c:if>
                            <div class="tools">
                            	<c:if test="${bbs.if_del eq '1'}">
                                <c:choose>
				                	<c:when test="${bbs.praise=='1'}">
                               			<a class="support" title="取消点赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,2,'${bbs.id}')" style="cursor: pointer;">${bbs.priase_count}</a>
				                	</c:when>
				                	<c:otherwise>
				                		<a class="support" title="赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,2,'${bbs.id}')" style="cursor: pointer;">${bbs.priase_count}</a>
				                	</c:otherwise>
				                </c:choose>
				                <c:choose>
				                	<c:when test="${videos.unpraise=='2'}">
                                		<a class="opposition ml10" title="取消点踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,2,'${bbs.id}')" style="cursor: pointer;">${bbs.unpriase_count}</a>
				                	</c:when>
				                	<c:otherwise>
				                		<a class="opposition ml10" title="踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,2,'${bbs.id}')" style="cursor: pointer;">${bbs.unpriase_count}</a>
				                	</c:otherwise>
				                </c:choose>
                                <c:if test="${bbs.isme eq '0'}">
                                <a class="f14 text-gray-s_999 ml30" href="javascript:void(0);" onclick="showBbsTip('${bbs.id}','${bbs.user_id }',${bbs.floor_num})">举报</a>
                                </c:if>
                                <span class="f14 text-gray-s_999 ml5">|</span>
                            	</c:if>
                                <span class="f14 text-white ml5"><fmt:formatDate value="${bbs.reply_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <span class="f14 text-white ml15 mr30">${bbs.floor_num}楼</span>
                            </div>
                        </td>
                    </tr>
                	</c:forEach>
                </table>
                <div class="page_div">
                    <c:choose>
						<c:when test="${page.pageCount!=0}">
						<ul class="pagination">
							<c:choose>
								<c:when test="${page.currentPage!=1}">
								<li data-command="prev" onclick="reload_not_details('${page.currentPage-1}','${see_lz}')"><a>上一页</a></li>
						        <li data-page-num="${page.currentPage-1}" onclick="reload_not_details('${page.currentPage-1}','${see_lz}')"><a>${page.currentPage-1}</a></li>
						        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
								</c:when>
								<c:when test="${page.currentPage==1}">
								<li data-command="prev"><a>上一页</a></li>
						        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
						        </c:when>
							</c:choose>
							<c:choose>
								<c:when test="${page.currentPage!=page.pageCount}">
								<li data-page-num="${page.currentPage+1}" onclick="reload_not_details('${page.currentPage+1}','${see_lz}')"><a>${page.currentPage+1}</a></li>
								<c:choose>
						            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
					            </c:choose>
					            <c:choose>
						            <c:when test="${(page.currentPage+1)!=page.pageCount}">
						            <li data-page-num="${page.pageCount}" onclick="reload_not_details('${page.pageCount}','${see_lz}')"><a>${page.pageCount}</a></li>
						            </c:when>
						        </c:choose>
						        <li data-command="next" onclick="reload_not_details('${page.currentPage+1}','${see_lz}')"><a>下一页</a></li>
								</c:when>
								<c:otherwise>
						    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
						    	</c:otherwise>
							</c:choose>
						</ul>
						</c:when>
					</c:choose>
                </div>
                <c:choose>
                	<c:when test="${note.if_lock eq '1'}">
                	</c:when>
                	<c:otherwise>
                	<div class="publish_area">
	                    <div class="the_text">
	                        <form id="replyNoteForm">
	                    		<input type="hidden" name="note_id" value="${note.id}"/>
	                    		<input type="hidden" name="reply_id" value=""/>
		                       <span id="send_reply" href="javascript:void(0);" class="posting ml20 mt10">发表回复</span>
		                        <br />
		                        <div class="mt10"></div>
		                        <textarea id="content" name="content" style="height: 240px;" class="textbox"></textarea>
		                        <div class="publish">
		                            <input type="button" name="name" value="发表" onclick="saveReplyNote()" class="btn_l ml35 mr20" />
		                        </div>
		                        <div class="clearit"></div>
	                        </form>
	                    </div>
	                </div>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
	<%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/own/msg.js"></script>
    <script src="${ctx}/resources/ueditor/ueditor.config.reply.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ueditor/ueditor.all.min.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ckplayer/ckplayer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var ue;
$(function(){
	check_have_video();
	var if_lock = $("#note_if_lock").val();
	if(if_lock!='1'){
		if(ue){
	    	ue.destroy();
	    }
	    ue = UE.getEditor('content',{wordCount:false,elementPathEnabled:false});
	}
})

function reload_not_details(curPage,type){
	var url = base+ '/bbs/noteDetails/'+$("#note_id").val();
	if(!curPage){
		curPage = $("#currentPage").val();
	}
	var flag = true;
	if(curPage!=1){
		flag = false;
		url = url+'?page='+curPage;
	}
	if(type){
		if(flag){
			url = url+'?seeLz='+type;
		}else{
			url = url+'&seeLz='+type;
		}
	}
	location.href = url; 
}

function centerImage(dom) {
	var parent = $(dom);
	var img = parent.find("img");
    var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    if(120 < parent.width()&&ih<parent.height()){
    	var ml = (parent.width()-120)/2;
    	var mt = (parent.height()-ih)/2;
	    img.css({
	    	'margin-left': ml+'px',
	        'margin-top': mt+'px'
	    });
    }
}

function create_video(dom,src){
	var w = $(dom).attr('width');
	var h = $(dom).attr('height');
	var uid = (+new Date()).toString( 32 );
	$(dom).replaceWith('<a id="a1_'+uid+'"></a>');
	
	var flashvars = {
        f: src,
        c: 0,
        b: 1
    };
    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1_'+uid, 'ckplayer_a1', w, h, false, flashvars);
}

function check_have_video(){
	var trs = $("#bbs_table").find("tr");
	trs.each(function(){
		var id = $(this).attr("note-id");
		var ctime = $(this).attr("reply-time");
		change_video(this,id,ctime);
	});
}

function change_video(dom,nid,ctime){
	var vs = $(dom).find("video").hide();
	if(vs&&vs.length>0){
		var num = 0;
		vs.each(function(){
			var src = $(this).attr("src");
			if(src){
				num++;
				if(check_create_time(ctime,15)){
					var w = $(this).width();
					var h = $(this).height()
					$(this).before("<div id='ueditor_"+nid+num+"' style='display:inline-block;width:"+w+"px;height:"+h+"px;background-color: #666;'><img src='/resources/images/v0001.png' style='display:inline-block;'/></div>");
					centerImage("#ueditor_"+nid+num);
				}else{
					create_video(this,src);
				}
			}else{
				$(this).remove();
			}
		});
	}
}

function see_lz(dom,type){
	if(type){
		reload_not_details(1,type);
	}else{
		reload_not_details(1);
	}
}
var re_ue;
function edit_reply(rid){
	if(!check_user_role())return;
	if(re_ue&&re_ue.uid){
		layer.msg("请先保存当前编辑的回复！", {icon : 0});
		return;
    }
	$.post(base+'/bbs/getNoteReply',{rid:rid},function (data){
		if (data.state == 'success') {
			edit_reply_change(true,rid);
			$("#reply_text_"+rid).empty().css("height","240px");
			re_ue = UE.getEditor('reply_text_'+rid,{wordCount:false,elementPathEnabled:false});
			re_ue.ready(function() {
				re_ue.setContent(data.data.reply.content);
			});
		}else{
			layer.msg("操作失败", {icon : 2});
		}
	});
}

function cancel_reply(bid){
	$.post(base+'/bbs/getNoteReply',{rid:bid},function (data){
		if (data.state == 'success') {
			if(re_ue){
				re_ue.destroy();
		    }
			edit_reply_change(false,bid);
			$("#reply_text_"+bid).replaceWith('<div id="reply_text_'+bid+'" class="user_txt"></div>');
			$("#reply_text_"+bid).empty();
			$("#reply_text_"+bid).append('<p class="text-white f14">'+data.data.reply.content+'</p>');
			var tr = $("#reply_text_"+bid).parent().parent();
			change_video(tr,bid,data.data.reply.update_time);
		}else{
			layer.msg("操作失败", {icon : 2});
		}
	});
}

function update_reply(bid){
	var content = re_ue.getContent();
	if(!content){
		layer.msg("请输入回复内容！",{icon:2});
		return;
	}
	var str = re_ue.getContentTxt();
	var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
	if(len<5){
		layer.msg("请输入至少五个汉字!",{icon:2});
		return;
	}
	$.ajaxSec({
		type : 'POST',
		url : base+"/bbs/noteReply?random="+Math.random(),
		data : {reply_id : bid,note_id : $("#note_id").val(),content : re_ue.getContent()},
		success : function(data) {
			if (data.state == 'success') {
				layer.msg("修改成功！",{icon:1});
				cancel_reply(bid);
			}
		},
		error : $.ajaxError
	});
}

function delete_reply(id){
	if(!check_user_role())return;
	yrt.confirm('确定要删除这条回复吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true 
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/bbs/deleteNoteReply',
			data: {reply_id: id,note_id:$("#note_id").val(),plate_id:$("#plate_id").val()},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					reload_not_details();
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function edit_reply_change(flag,bid){
	var tool = $("#reply_tools_"+bid);
	tool.empty();
	if(flag){
		tool.append('<input type="button" onclick="cancel_reply(\''+bid+'\')" value="取消" class="edit_btn mt10" />');
		tool.append('<input type="button" onclick="update_reply(\''+bid+'\')" value="保存" class="del_btn mt10 mr10" />');
	}else{
		tool.append('<input type="button" onclick="edit_reply(\''+bid+'\')" value="编辑" class="edit_btn mt10" />');
		tool.append('<input type="button" onclick="delete_reply(\''+bid+'\')" value="删除" class="del_btn mt10 mr10" />');
	}
}

function delete_note(bid){
	if(!check_user_role())return;
	yrt.confirm('确定要删除这篇帖子吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true 
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/bbs/deleteNote',
			data: {note_id:$("#note_id").val(),plate_id:$("#plate_id").val()},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					location.href=base+"/bbs/list?plate_id="+$("#plate_id").val();
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}


	function do_praise(state, dom, type, bid) {
		var flag = $(dom).attr("flag");
		if (flag == 1) {
			$(dom).attr("flag", 0);
			$.ajaxSec({
				type : 'POST',
				url : base + '/bbs/praise',
				data : {b_id : bid,state : state,type : type},
				success : function(data) {
					if (data.state == 'success') {
						var str = state == 1 ? '赞' : '踩';
						var type = state == 1 ? 'good' : 'bad';
						$(dom).text(data.data.praiseCount);
						if (data.data.flag == 1) {
							$(dom).attr('title', '取消点' + str);
						} else {
							$(dom).attr('title', str);
						}
					} else {
						layer.msg("操作失败", {icon : 2});
					}
					$(dom).attr("flag", 1);
				},
				error : $.ajaxError
			});
		}
	}

	function focus_user(dom, uid, type) {
		$.ajaxSec({
			type : 'POST',
			url : base + "/ifLogin",
			dataType : "JSON",
			success : function(data) {
				if (data.state == 'error') {
					layer.msg(data.message.error[0]);
				} else {
					var url = base + '/user/focus';
					if (type) {
						url = base + '/user/cancel';
					}
					var flag = $(dom).attr("flag");
					if (!flag) {
						$(dom).attr("flag", "1");
						$.ajaxSec({
							type : 'POST',
							url : url,
							data : {f_user_id : uid,f_type : 0},
							cache : false,
							dataType : 'json',
							success : function(result) {
								if (result.state == 'success') {
									if (type) {
										$(dom).val("+ 关注").attr("title", "关注");
										$(dom).attr("onclick","focus_user(this,'"+ uid + "')");
									} else {
										$(dom).val("已关注").attr("title","取消关注");
										$(dom).attr("onclick","focus_user(this,'"+ uid+ "',true)");
									}
									layer.msg(result.message.success[0],{icon : 1});
								} else {
									layer.msg('操作失败', {icon : 2});
								}
								$(dom).removeAttr("flag");
							},
							error : $.ajaxError
						});
					}
				}
			}
		});
	}
	/**
	 *  举报相关js(zhangwei)
	 **/
	jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }

    function closerot() {
        $(".masker").fadeOut();
        $(".report").fadeOut();
    }
    function cancel(){
    	 closerot();
    }
    
    function showBbsTip(id,b_user_id,floor_num) {
    	if(!check_user_role())return;
		var datas = {note_id:"${note_id}",note_reply_id:id,b_user_id:b_user_id,floor_num:floor_num};
		$.ajax({
			type:"POST",
			url:base+"/bbs/ifHasBbsTip?random="+Math.random(),
			data:datas,
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					$("#bbsTipBuserId").attr("value",b_user_id);
					$("#bbsTipNoteReplyId").attr("value",id);//回复id
					$(".report").find("input[type=text]").val("");
					$(".report").find("textarea").val("");
					$(".masker").height($(document).height()).fadeIn();
				    $(".report").center().fadeIn();
				    $(".masker").height($(document).height());
				    $(".masker").fadeIn();
				}else{
					layer.msg(data.message.error[0],{icon:2});
					return;
				}
			}
		});
		
	};
	
	//举报提交
	function submitBbsTip(){
		$.ajaxSec({
			context:$("#bbsTipForm"),
			type:"POST",
			url:base+"/bbs/saveBbsTip?random="+Math.random(),
			data:$("#bbsTipForm").serialize(),
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg("感谢您的举报，我们将尽快处理！",{icon:1});
					 $(".masker").fadeOut();
					 $(".report").fadeOut();
				}else{
					layer.msg("举报失败！",{icon:1});
				}
			}
		});
	}
	
	//回复贴子
	function saveReplyNote(){
		var content = ue.getContent();
    	if(!content){
    		layer.msg("请输入回复内容！",{icon:2});
    		return;
    	}
    	var str = ue.getContentTxt();
    	var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
    	if(len<5||str.trim()==''){
    		layer.msg("请输入至少五个字符!",{icon:2});
    		return;
    	}
		$.ajaxSec({
			type:'post',
			url:base+"/bbs/noteReply?random="+Math.random(),
				data:$("#replyNoteForm").serialize(),
				dataType:'json',
				success:function(data){
					if(data.state=="success"){
						$("#content").val("");
						layer.msg("回复成功！",{icon:1});
						window.setTimeout(function(){
							reload_not_details();
						},1000);
					}
				},
		});
	}
	
	//购买贴子附件 note_id 贴子ID amount 金额
	function buyNoteAccess(note_id,amount,ace_id){
		if(!check_user_role())return;
		yrt.confirm('购买此附件需支付 '+amount+' 宇币,是否支付？', {
		    btn: ['支付','取消'], //按钮
		    shade: true,
		    cwidth:'80%'
		}, function(){
			$.ajaxSec({
				type:'post',
				url:base+"/bbs/buyNoteAcc?random="+Math.random(),
				data:{"note_id":note_id,"amount":amount,"acc_id":ace_id},
				dataType:'json',
				success:function(data){
					if(data.state=="success"){
						yrt.msg(data.message.success[0],{icon:1});
						window.setTimeout(function(){
	  						window.location.reload();
						},2000);
					}else{
						yrt.msg(data.message.error[0],{icon:2});
					}
					
				}
			});
		}, function(){});
		
	}
	
	//下载资源文件
	function downloadFile(ac_id,file_name,file_url){
		var url = base+"/bbs/download?random="+Math.random();
		post(url,{ac_id:ac_id,file_name:file_name,file_url:file_url});
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
	
function checkVote(){
	var ids = "";
	$("input[name='data_id']:checked").each(function(){
		ids = ids + this.value + ",";
	});
	if(ids == ""){
		layer.msg("请选择投票项目！",{icon:0});
	}else{
		$.ajaxSec({
			type:'post',
			url:base+"/bbs/saveVoteClick?random="+Math.random(),
			data:{"ids":ids,"note_id":'${note_id}'},
			dataType:'json',
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					window.location = base+"/bbs/noteDetails/${note_id}";
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
				
			}
		}); 
	}
	
}

function buyalarm(text){
	layer.msg(text,{icon:2});
}
//展示用户基本信息
function showUserInfo(user_id,area_id){
	$.ajax({
		type:'post',
		url:base+'/user/card_info?random='+Math.random(),
		data:{"user_id":user_id},
		dataType:'html',
		beforeSend:function(){
			$(area_id).empty();
			$(".card").each(function () {
                $(".card").hide();
            });
		},
		success:function(data){
			
			$(area_id).append(data);
			$(area_id).show();
			
			$(area_id).mouseover(function() {
				
	            $(area_id).show();
	        }).mouseout(function() {
	            $(area_id).hide();
	        });

			$(document).mouseover(function (e) {
	            if (!$(area_id).is(':has(' + e.target.localName + ')') && e.target.id != 'writers') {
	                $(area_id).hide();
	            }
	        });
		}
	})
}
//隐藏用户基本信息
function hideUserInfo(area_id) {
	
	
		
		 $(area_id).show();
     
}

$(".share").mouseover(function() {
    $(".shares").show();
});
$(document).click(function (e) {
    if (!$(".share").is(':has(' + e.target.localName + ')') && e.target.id != 'share') {
        $(".shares").hide();
    }
});
</script>
</body>
</html>