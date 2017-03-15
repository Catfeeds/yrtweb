<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <div class="about">
    <div class="about_title">
        <span class="text-white ms f18 ml20">关于宇任拓</span>
    </div>
    <ul class="about_me">
        <li <c:if test="${currentPage eq 'ABOUTUS'}">class="active"</c:if>>
        	<a href="${ctx}/about/about_us"><span class="about_txt">关于我们</span></a>
        </li>
        <li <c:if test="${currentPage eq 'COOPERATION'}">class="active"</c:if>>
        	<a href="${ctx}/about/cooperation"><span class="about_txt">商务合作</span></a>
       	</li>
        <li <c:if test="${currentPage eq 'JOINUS'}">class="active"</c:if>>
        	<a href="${ctx}/about/join_us"><span class="about_txt">加入我们</span></a></li>
        <li <c:if test="${currentPage eq 'QUESTIONS'}">class="active"</c:if>>
        	<a href="${ctx}/about/questions"><span class="about_txt">常见问题</span></a>
        </li>
        <li <c:if test="${currentPage eq 'PAYHELP'}">class="active"</c:if>>
        	<a href="${ctx}/about/payhelp"><span class="about_txt">支付帮助</span></a>
       	</li>
        <li <c:if test="${currentPage eq 'CONTACTUS'}">class="active"</c:if>>
        	<a href="${ctx}/about/contact_us"><span class="about_txt">联系我们</span></a>
       	</li>
    </ul>
</div>