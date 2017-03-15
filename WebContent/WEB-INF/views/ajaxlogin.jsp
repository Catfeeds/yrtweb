<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div id="login_masker" class="login_masker"></div>
<div class="login" id="ajax_login" style="z-index: 1000;display: none;">
    <div class="closeBtn_1" id="ax_close"></div>
    <div class="windows">
        <div class="span">
            <span class="f20 ms ml10">登录</span>
        </div>
        <form id="ajax_loginForm" errorType="2" method="post">
            <input type="hidden" id='captcha_ajax_flag' name="captcha_flag" value="true" />
            <dl>
                <dt>
                    <input type="text" name="username" valid="require len(1,40)" value="${username}" data-text="用户名" placeholder="用户名" maxlength="40" id="user" class="username ms f14" />
                </dt>
                <dd>
                    <input type="password" name="password" valid="require len(1,40)" value="" data-text="密码" placeholder="密&emsp;码" maxlength="20" id="user" class="password ms f14" />
                </dd>
                <dd class="ml10 mt10">
                    <input type="text" id='j_ajax_captcha' name="j_captcha" valid="" value=""  placeholder="输入验证码" maxlength="6" class="captxt ms f14" style="display: none;" />

                    <img src="" id="captchaImgAjax" alt="验证码" class="cap" style="display: none;" />
                    <div class="clearit"></div>
                </dd>
                <dd>
                    <input type="button" onclick="loginSubmit('#ajax_loginForm');getCookie();" value="登录" class="pull-left ml10 mt10 ms f18 lgnsignbtn" />
                    <div id="w_ajax_captcha" style="display: none;"><a onclick="refreshCaptcha()" style="cursor: pointer;" class="ml20 text-white">看不清？换一个</a></div>
                    <br />
                    <a href="${ctx}/register/registerAccount" class="pull-left  ml70 text-white f12 ms">注册</a>
                    <a href="${ctx}/find/way" target="_blank;" class="pull-left  ml15 text-white f12 ms">忘记密码</a>
                    <div class="clear"></div>
                </dd>
            </dl>
        </form>
    </div>
</div>
