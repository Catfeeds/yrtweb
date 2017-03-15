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
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

/**
 * @author GL
 * @date 2015年7月23日 下午4:30:19 
 */
public class WebAccessDeniedHandler implements AccessDeniedHandler  {
	
	private String accessDeniedUrl;  
	
	public WebAccessDeniedHandler(){
		
	}
	public WebAccessDeniedHandler(String accessDeniedUrl){
		this.accessDeniedUrl=accessDeniedUrl; 
	}

	@Override
	public void handle(HttpServletRequest request,
			HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException,
			ServletException {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		//如果是ajax请求  
        if (isAjax) {
        	ObjectMapper objectMapper = new ObjectMapper();
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(),
                    JsonEncoding.UTF8);
            try {
//                JsonData jsonData = new JsonData(2, null);
            	Map<String, Object> jsonData = new HashMap<String, Object>();
            	jsonData.put("secState", true);
                objectMapper.writeValue(jsonGenerator, jsonData);
            } catch (JsonProcessingException ex) {
                throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getMessage(), ex);
            }
        }else{  
	         String path = request.getContextPath();  
	         String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;  
	         response.sendRedirect(basePath+accessDeniedUrl);  
        } 
	}

	public String getAccessDeniedUrl() {
		return accessDeniedUrl;
	}

	public void setAccessDeniedUrl(String accessDeniedUrl) {
		this.accessDeniedUrl = accessDeniedUrl;
	}
	

}
