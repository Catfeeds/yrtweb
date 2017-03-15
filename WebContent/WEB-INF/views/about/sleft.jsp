<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <div class="about">
    <div class="about_title">
        <span class="text-white ms f18 ml20">关于宇任拓</span>
    </div>
    <ul class="about_me">
        <li <c:if test="${currentPage eq 'PROCESS'}">class="active"</c:if>>
        	<a href="${ctx}/about/process"><span class="about_txt">夺宝流程</span></a>
        </li>
        <li <c:if test="${currentPage eq 'AGREEMENT'}">class="active"</c:if>>
        	<a href="${ctx}/about/agreement"><span class="about_txt">夺宝协议</span></a>
        </li>
        <li <c:if test="${currentPage eq 'DOUBT'}">class="active"</c:if>>
        	<a href="${ctx}/about/doubt"><span class="about_txt">常见问题</span></a>
       	</li>
    </ul>
</div>