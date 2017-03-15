package com.yt.framework.security;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

/**
 * 访问决策器，决定某个用户具有的角色，是否有足够的权限去访问某个资源
 * 
 * 另外还可以参考一下 AbstractAccessDecisionManager
 * @author GL
 * @date 2015年7月23日 下午4:29:26 
 */
@Service("webAccessDecisionManager")
public class WebAccessDecisionManager implements AccessDecisionManager {

	@Override
	public void decide(Authentication authentication, Object object,
			Collection<ConfigAttribute> configAttributes)
			throws AccessDeniedException, InsufficientAuthenticationException {
		if(configAttributes == null){
            return ;
        }
		System.out.println("------------decide-------");
		System.out.println("当前用户的的角色集合:" + authentication.getAuthorities());
		System.out.println("当前URL可以访问角色集合:" + configAttributes);
		System.out.println("object封装了request response信息:" + object);
		
		Iterator<ConfigAttribute> ite=configAttributes.iterator();
        while(ite.hasNext()){
            ConfigAttribute ca=ite.next();
            String needRole=((SecurityConfig)ca).getAttribute();
			for (GrantedAuthority ga : authentication.getAuthorities()) {
                if(needRole.equals(ga.getAuthority())){
                    return;
                }
            }
        }
        
        throw new AccessDeniedException("No Right");
	}

	@Override
	public boolean supports(ConfigAttribute attribute) {
		System.out.println("attribute:" + attribute);
		return true;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		System.out.println("clazz:" + clazz);
		return true;
	}

}
