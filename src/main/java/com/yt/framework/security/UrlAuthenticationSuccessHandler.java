package com.yt.framework.security;

import java.io.IOException;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.security.web.util.TextEscapeUtils;
import org.springframework.util.StringUtils;

import com.yt.framework.mapper.BabyInfoMapper;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;

/**
 * 普通登录成功处理
 * 判断登录用户是否管理员
 * @author GL
 * @date 2015年7月30日 下午3:46:14 
 */
public class UrlAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	protected final Log logger = LogFactory.getLog(this.getClass());
	
	@Autowired
	private UserService userService;
	@Autowired
	private BabyService babyService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private LeagueService leagueService;

    private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {
        SavedRequest savedRequest = requestCache.getRequest(request, response);
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
        BabyInfo babyInfo = babyService.getBabyInfoByUserId(user.getId());
        if(babyInfo!=null){
        	request.getSession().setAttribute("session_baby_id",babyInfo.getId());
        }
        //判断当前登录用户是否属于俱乐部成员
        TeamInfo ti = teamInfoService.getTeamInfoByPUserID(user.getId());
        if(ti!=null){
        	TeamLeague teamLeague = leagueService.getTeamSignByLeague(ti.getId(), null);
        	if(null != teamLeague && null != teamLeague.getLeague_id()){
        		request.getSession().setAttribute("l_id",teamLeague.getLeague_id());
        	}
        }
        request.getSession().setAttribute("session_user_id",user.getId());
        request.getSession().setAttribute("session_usernick",TextEscapeUtils.escapeEntities(user.getUsernick()));
        if (savedRequest == null) {
        	String adminUrl = "";
            Collection<? extends GrantedAuthority> auths = userDetails.getAuthorities();
            for (GrantedAuthority auth : auths) {
    			if("ROLE_ADMIN".equals(auth.getAuthority())){
    				adminUrl = "/admin";
    				break;
    			}
    		}
            if("".equals(adminUrl)){
            	super.onAuthenticationSuccess(request, response, authentication);
            }else{
            	 getRedirectStrategy().sendRedirect(request, response, adminUrl);
            }
            return;
        }
        String targetUrlParameter = getTargetUrlParameter();
        if (isAlwaysUseDefaultTargetUrl() || (targetUrlParameter != null && StringUtils.hasText(request.getParameter(targetUrlParameter)))) {
            requestCache.removeRequest(request, response);
            super.onAuthenticationSuccess(request, response, authentication);

            return;
        }

        clearAuthenticationAttributes(request);

        // Use the DefaultSavedRequest URL
        String targetUrl = savedRequest.getRedirectUrl();
        List<String> req = savedRequest.getHeaderValues("X-Requested-With");
        if (req!=null&&req.size()>0&&"XMLHttpRequest".equals(savedRequest.getHeaderValues("X-Requested-With").get(0))){
        	targetUrl = request.getContextPath();
        } 

        logger.debug("Redirecting to DefaultSavedRequest Url: " + targetUrl);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    public void setRequestCache(RequestCache requestCache) {
        this.requestCache = requestCache;
    }
}
