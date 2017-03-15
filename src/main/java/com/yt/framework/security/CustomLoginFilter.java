package com.yt.framework.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.TextEscapeUtils;

import com.yt.framework.utils.Md5Encrypt;

/**
 * 实现带验证码的登录验证，在这里还可以实现登录验证的其他参数接收和处理
 * 
 * 通过指定 filterProcessesUrl 属性，指定的Url会被Spring Security拦截，登录表单数据直接提交到这个Url (如果不指定，默认Url为：/j_spring_security_check)
 * 
 * 要自定义退出登录的地址，可以通过设置 logout-url 属性：(默认Url为：/j_spring_security_logout)
 * <logout logout-url="/u/logout" logout-success-url="/logout.jsp" invalidate-session="true"/>
 * 
 * invalidate-session 如果为true，在注销的时候会销毁会话
 * @author GL
 * @date 2015年7月23日 下午4:29:26 
 */
public class CustomLoginFilter extends UsernamePasswordAuthenticationFilter {

	public Authentication attemptAuthentication(HttpServletRequest request,
	        HttpServletResponse response) throws AuthenticationException {
	
	    // if (!request.getMethod().equals("POST")) {
	    // throw new AuthenticationServiceException(
	    // "Authentication method not supported: "
	    // + request.getMethod());
	    // }
	
	    String username = obtainUsername(request).trim();
	    String password = obtainPassword(request);
	    password = Md5Encrypt.md5(password);
	    UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(
	            username, password);
	 
	    
	    setDetails(request, authRequest);
	    
	    return this.getAuthenticationManager().authenticate(authRequest);
	}
}
