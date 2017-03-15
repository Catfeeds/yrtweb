package com.yt.framework.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

/**
 *	Ajax登录失败处理
 * @author GL
 * @date 2015年7月30日 下午3:47:34 
 */
public class AjaxAuthenticationFailureHandler implements AuthenticationFailureHandler{

	public AjaxAuthenticationFailureHandler() {  
    }  
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		ObjectMapper objectMapper = new ObjectMapper();  
        response.setHeader("Content-Type", "application/json;charset=UTF-8");  
        JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),JsonEncoding.UTF8);  
        try {  
            //失败为1  
        	Map<String, Object> jsonData = new HashMap<String, Object>();
        	jsonData.put("loginState", 1);
            objectMapper.writeValue(jsonGenerator, jsonData);  
        } catch (JsonProcessingException ex) {  
            throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);  
        }  
		
	}

}
