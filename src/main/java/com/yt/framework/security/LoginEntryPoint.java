package com.yt.framework.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

/**
 * 拦截需要登录的URL 判断是普通请求还是Ajax请求
 * @author GL
 * @date 2015年7月23日 下午4:29:48 
 */
@SuppressWarnings("deprecation")
public class LoginEntryPoint extends LoginUrlAuthenticationEntryPoint {

	private static final Log logger = LogFactory.getLog(LoginEntryPoint.class);
	 
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException, ServletException {
 
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String url = request.getRequestURI();
        if (logger.isDebugEnabled()) {
            logger.debug("url:" + url);
        }
        // 非ajax请求
        if (!"XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))){
        	request.getSession().setAttribute("login_url", url);
        	super.commence(request, response, authException);
        } else {
            // ajax请求，返回json，替代redirect到login page
            if (logger.isDebugEnabled()) {
                logger.debug("ajax request or post");
            }
 
            ObjectMapper objectMapper = new ObjectMapper();
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),
                    JsonEncoding.UTF8);
            try {
//                JsonData jsonData = new JsonData(2, null);
            	Map<String, Object> jsonData = new HashMap<String, Object>();
            	jsonData.put("loginState", 2);
                objectMapper.writeValue(jsonGenerator, jsonData);
            } catch (JsonProcessingException ex) {
                throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);
            }
        }
    }
    
    
    /*@Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest)request;
//        System.out.println(httpRequest.getHeader("X-Requested-With"));
        if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))){
        	ObjectMapper objectMapper = new ObjectMapper();
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),
                    JsonEncoding.UTF8);
            try {
            	Map<String, Object> jsonData = new HashMap<String, Object>();
            	jsonData.put("loginState", true);
                objectMapper.writeValue(jsonGenerator, jsonData);
            } catch (JsonProcessingException ex) {
                throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);
            }
        } else{
            super.commence(request, response, authException);
        }
    }*/
}
