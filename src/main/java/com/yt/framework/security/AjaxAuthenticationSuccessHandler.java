package com.yt.framework.security;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.util.TextEscapeUtils;

import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.UserService;

/**
 * Ajax登录成功处理
 * @author GL
 * @date 2015年7月30日 下午3:47:18 
 */
public class AjaxAuthenticationSuccessHandler implements AuthenticationSuccessHandler{
	
	@Autowired
	private UserService userService;
	
	public AjaxAuthenticationSuccessHandler() {  
    }  

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		ObjectMapper objectMapper = new ObjectMapper();  
        response.setHeader("Content-Type", "application/json;charset=UTF-8");
        JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),JsonEncoding.UTF8);
        try {  
        	Cookie cookie = new Cookie("j", null);
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            
        	Authentication authtion = SecurityContextHolder.getContext().getAuthentication();
        	WebAuthenticationDetails details = (WebAuthenticationDetails) authtion.getDetails();
        	WebUserDetails userDetails = (WebUserDetails) authtion.getPrincipal();
        	User user = userService.getEntityById(userDetails.getUserId());
            user.setLast_login(new Date());
            user.setLast_login_ip(details.getRemoteAddress());
            userService.update(user);
            request.getSession().setAttribute("session_user_id",TextEscapeUtils.escapeEntities(String.valueOf(user.getId())));
            request.getSession().setAttribute("session_usernick",TextEscapeUtils.escapeEntities(user.getUsernick()));
            //成功为0  
        	Map<String, Object> jsonData = new HashMap<String, Object>();
        	jsonData.put("loginState", 0);
        	objectMapper.writeValue(jsonGenerator, jsonData);  
		} catch (JsonProcessingException ex) {  
			throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);  
		}  
	}

	
}
