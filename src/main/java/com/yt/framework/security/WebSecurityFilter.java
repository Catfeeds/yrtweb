package com.yt.framework.security;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.web.FilterInvocation;

import com.yt.framework.utils.PropertiesUtils;


/**
 * 自己实现的过滤用户请求类，也可以直接使用 FilterSecurityInterceptor
 * 
 * AbstractSecurityInterceptor有三个派生类：
 * FilterSecurityInterceptor，负责处理FilterInvocation，实现对URL资源的拦截。
 * MethodSecurityInterceptor，负责处理MethodInvocation，实现对方法调用的拦截。
 * AspectJSecurityInterceptor，负责处理JoinPoint，主要是用于对切面方法(AOP)调用的拦截。
 * 
 * 还可以直接使用注解对Action方法进行拦截，例如在方法上加：
 * @PreAuthorize("hasRole('ROLE_SUPER')")
 * @author GL
 * @date 2015年7月23日 下午4:29:26 
 */
public class WebSecurityFilter extends AbstractSecurityInterceptor implements Filter {
	
	@Autowired
	private WebSecurityMetadataSource securityMetadataSource;
	@Autowired
	@Qualifier("webAuthenticationManager")
	private AuthenticationManager authenticationManager;
	@Autowired
	private WebAccessDecisionManager accessDecisionManager;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		FilterInvocation fi = new FilterInvocation(request, response, chain);
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		System.out.println("requestURL:" +fi.getRequestUrl());
		//added by bo.xie 输入门令才能进入网站	start
		/*String host = httpRequest.getHeader("Host");
		if(host.equals("www.11uniplay.com")||host.equals("11uniplay.com")){
			HttpSession session = httpRequest.getSession();
			Object active = session.getAttribute("ACTIVECODE");
			if(null == active || StringUtils.isBlank(active.toString())){
				HttpServletResponse servletResponse = (HttpServletResponse) response;
				httpRequest.getRequestDispatcher("/doorCode").forward(httpRequest, servletResponse);
			}
		}*/
		//added by bo.xie 输入门令才能进入网站	end
		Map<String, String> resources = securityMetadataSource.getRecources();
		httpRequest.setAttribute("resources", resources);
		//在执行doFilter之前，进行权限的检查		
        InterceptorStatusToken token = super.beforeInvocation(fi);
        try {
            fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
        } finally {
            super.afterInvocation(token, null);
        }
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void destroy() {
		
	}

	@Override
	public Class<?> getSecureObjectClass() {
		return FilterInvocation.class;
	}

	@Override
	public SecurityMetadataSource obtainSecurityMetadataSource() {
		return this.securityMetadataSource;
	}
	
	public WebSecurityMetadataSource getSecurityMetadataSource() {
		return securityMetadataSource;
	}

	public void setSecurityMetadataSource(
			WebSecurityMetadataSource securityMetadataSource) {
		this.securityMetadataSource = securityMetadataSource;
	}

}
