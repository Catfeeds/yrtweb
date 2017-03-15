<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:forEach items="${rf.items}" var="msg" varStatus="msgIndex"> 
 <table>
     <tr>
         <td>
             <img src="${el:headPath()}${msg.head_icon}" onclick="javascript:window.location='${ctx}/center/${msg.s_user_id}'" style="cursor:pointer;"/>
         </td>
	         <td class="w85">
	             <span class="f12">${msg.content}</span>
	         </td>
         <td class="w65">
         	 <c:choose>
	             <c:when test="${msg.type == 'ptaq' || msg.type == 'ptaj' || msg.type == 'atpq' || msg.type == 'atpj' 
	             	|| msg.type == 'ttpa' || msg.type == 'ipk'|| msg.type == 'trial'|| msg.type == 'bbout'}">
		             <input type="button" name="name" value="同意" class="letter_btn ms" onclick="checkMsg('${msg.id}','${msg.s_user_id}','${msg.relate_id}','${msg.type}','yes');"/>
		             <input type="button" name="name" value="拒绝" class="letter_btn ms" onclick="checkMsg('${msg.id}','${msg.s_user_id}','${msg.relate_id}','${msg.type}','no');"/>
	             </c:when>
	             <c:otherwise>
	              	<input type="button" name="name" value="已阅" class="letter_btn ms" onclick="checkMsg('${msg.id}','${msg.s_user_id}','${msg.relate_id}','${msg.type}','');"/>
	             </c:otherwise>
	         </c:choose>
             <c:choose>
             	<c:when test="${session_user_id eq msg.s_user_id}">
             		<input type="button" id="msgBtn" value="私信" class="letter_btn ms" />
             	</c:when>
             	<c:otherwise>
	        	 	<input type="button" id="msgBtn" onclick="openMsg('${msg.s_user_id}','${msg.usernick}');" value="私信" class="letter_btn ms" />
             	</c:otherwise>
             </c:choose>
         </td>
     </tr>
 </table>
 </c:forEach>
 <div class="navpage">
 	<c:choose>
 		<c:when test="${rf.pageCount!=0}">
 			 	<c:if test="${rf.havePrePage eq true}">
	 			 <a href="javascript:void(0)" class="arr_l" onclick="loadSysMsg(${rf.currentPage-1})"></a>
 			 	</c:if>
 			 	<c:if test="${rf.haveNextPage eq true}">
	             <a href="javascript:void(0)" class="arr_r" onclick="loadSysMsg(${rf.currentPage+1})"></a>
 			 	</c:if>
 		</c:when>
 	</c:choose>
  <%-- <c:choose>
    <c:when test="${rf.pageCount!=0}">
      <c:choose>
        <c:when test="${rf.currentPage!=1}"> <a href="javascript:void(0)" onclick="loadSysMsg(1)">&laquo;</a> <a href="javascript:void(0)" onclick="loadSysMsg(${rf.currentPage-1})">${rf.currentPage-1}</a> <b>${rf.currentPage}</b> </c:when>
        <c:when test="${rf.currentPage==1}"> <b>1</b> </c:when>
      </c:choose>
      <c:choose>
        <c:when test="${rf.currentPage!=rf.pageCount}"> <a href="javascript:void(0)" onclick="loadSysMsg(${rf.currentPage+1})">${rf.currentPage+1}</a>
          <c:choose>
            <c:when test="${(rf.currentPage+2)<rf.pageCount}"> <i>...</i> </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <a href="javascript:void(0)"  onclick="loadSysMsg(${rf.pageCount})">${rf.pageCount}</a> </c:when>
          </c:choose>
          <a href="javascript:void(0)" onclick="loadSysMsg(${rf.pageCount})">&raquo;</a> </c:when>
      </c:choose>
    </c:when>
  </c:choose> --%>
</div> 