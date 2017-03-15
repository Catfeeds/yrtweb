package com.yt.framework.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntPathRequestMatcher;
import org.springframework.security.web.util.RegexRequestMatcher;
import org.springframework.security.web.util.RequestMatcher;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.persistent.entity.RoleResources;
import com.yt.framework.service.SecurityService;


/**
 * @author GL
 * @date 2015年7月23日 下午4:30:42 
 */
@Service("webSecurityMetadataSource")
public class WebSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

	private static Map<String, Collection<ConfigAttribute>> resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
	
	//用于标示用户是否更改了角色资源关系，如果是，则更新角色资源关系集
	public static boolean hasChange = false;
	
	@Autowired
	private SecurityService securityService;
	
	/**
	 * 初始化资源配置
	 * 
	 * spring 调用该方法的方式有2种
	 * 方式1，方法上加注解：
	 * @PostConstruct
	 * 
	 * 方式2，配置文件中 init-method 属性指定：
	 * <beans:bean id="webSecurityMetadataSource" init-method="initResource" class="com.tavenli.security.WebSecurityMetadataSource"/>
	 */
	@PostConstruct
	public void initResource(){
		
		resourceMap.clear();
		//取得当前系统所有可用角色
		List<RoleResources> roles = securityService.queryRoleResources();
		System.out.println("roles:打印开始");
		for (RoleResources role : roles) {
			System.out.println(role);
			this.loadRole(role);
		}		
		System.out.println("roles:打印结束");
		
		//为超级管理员添加所有资源权限
		//this.initSuperUserResource();
		
		
	}
	
	private void loadRole(RoleResources role) {
		//这里的 role 参数为自己定义的，要和 UserDetailsService 中的 SimpleGrantedAuthority 参数对应
		//role 参数也可以直接使用角色名
		ConfigAttribute ca = new SecurityConfig(role.getRole_str());
		Set<Resources> resources = role.getResources();
		for (Resources resource : resources) {
			String resurl = resource.getRes_url();
			if(StringUtils.isBlank(resurl)){
				// 不是菜单地址，跳过
				continue;
			}
			if (resourceMap.containsKey(resurl)) {
				resourceMap.get(resurl).add(ca);
			} else {
				Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
				atts.add(ca);
				resourceMap.put(resurl, atts);
			}
		}
	}
	private void initSuperUserResource() {
		// 添加超级管理员角色
		//ROLE_SUPER 这个权限名字也是自己定义的
		ConfigAttribute superCA = new SecurityConfig("ROLE_ADMIN");
		List<Resources> resources = securityService.queryAllResources();
		for (Resources resource : resources) {
			String resurl = resource.getRes_url();
			if(StringUtils.isBlank(resurl)){
				// 不是菜单地址，跳过
				continue;
			}
			if (resourceMap.containsKey(resurl)) {
				resourceMap.get(resurl).add(superCA);
			} else {
				Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
				atts.add(superCA);
				resourceMap.put(resurl, atts);
			}
		}
	}


	@Override
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {
		HttpServletRequest request = ((FilterInvocation)object).getRequest();
        Iterator<String> ite = resourceMap.keySet().iterator();
        Collection<ConfigAttribute> ca =  null;
        while (ite.hasNext()) {
            String resourceURL = ite.next();
            //AntPathRequestMatcher : 来自于Ant项目，是一种简单易懂的路径匹配策略。
            //RegexRequestMatcher : 如果 AntPathRequestMatcher 无法满足需求，
            //还可以选择使用更强大的RegexRequestMatcher，它支持使用正则表达式对URL地址进行匹配
            /*RegexRequestMatcher rrm = new RegexRequestMatcher("^/.*$", null);
            if (rrm.matches(request)) {
            	ca =  resourceMap.get(resourceURL);
            	break;
            }*/
            RequestMatcher requestMatcher = new AntPathRequestMatcher(resourceURL);
            if (requestMatcher.matches(request)) {
            	ca =  resourceMap.get(resourceURL);
            	break;
            }
        }
        if (hasChange) {
    		initResource();
			hasChange = false;
		}
        return ca;
	}
	
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();
		
		for (Map.Entry<String, Collection<ConfigAttribute>> entry : resourceMap.entrySet()) {
            allAttributes.addAll(entry.getValue());
        }

        return allAttributes;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FilterInvocation.class.isAssignableFrom(clazz);
	}
	
	public Map<String, String> getRecources(){
		Map<String, String> resources = new HashMap<String, String>();
		
		for (String key : resourceMap.keySet()) {
			Collection<ConfigAttribute> res = resourceMap.get(key);
			String resStr ="";
			for (ConfigAttribute attribute : res) {
				if(attribute!=null&&!"".equals(attribute)){
					resStr+=(attribute+",");
				}
			}
			if(!"".equals(resStr)&&resStr.indexOf(",")>=0){
				resStr = resStr.substring(0,resStr.lastIndexOf(","));
				resources.put(key, resStr);
			}
		}
		return resources;
	}

}
