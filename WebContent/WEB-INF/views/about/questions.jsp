<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/about.css" rel="stylesheet" />
<title>常见问题</title>
<c:set var="currentPage" value="QUESTIONS"/>
</head>
<body>
<div class="warp">
        <!--头部-->
    	<%@ include file="../common/header.jsp" %>
    	<!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
           <%@ include file="left.jsp" %>    
            <div class="about_r">
                <div class="about_r_title">
                    <span class="f20 ms text-white"><a href="/" class="text-white">首页</a>>>常见问题</span>
                </div>
                <div class="about_content">
                  <p class="text-white fw text-red ms" style="font-size: 18px;text-indent:1em;">请使用IE10及以上、火狐、谷歌等主流浏览器确保各功能的正常使用。</p>
                    <p class="text-white fw">Q：如何注册？</p>
                    <p class="text-white">A：1、在网站右上方点击“注册”按钮；</p>
                    <p class="text-white">&emsp;&ensp;2、进入注册页面完成资料填写；3、点击“注册”按钮完成注册</p>
                    <p class="text-white">&emsp;&ensp;3、点击“注册”按钮完成注册</p>

                    <p class="text-white fw">Q：例行维护后，部分功能无法正常使用怎么办？</p>
                    <p class="text-white">A：1、首先尝试CTRL+F5，强制刷新页面；</p>
                    <p class="text-white">&emsp;&ensp;2、如还无法正常使用，可联系我们的客服人员，联系电话：028-86667832</p>

                    <p class="text-white fw">Q：如何成为“球员”</p>
                    <p class="text-white">A：1、点击导航中的“个人中心”，选择“球员个人中心”进入球员个人中心；</p>
                    <p class="text-white">&emsp;&ensp;2、点击“球员信息”中的“激活”按钮；</p>
                    <p class="text-white">&emsp;&ensp;3、完成“主要信息”的资料填写，点击“保存”按钮</p>

                    <p class="text-white fw">Q：如何成为“教练”</p>
                    <p class="text-white">A：1、点击导航中的“个人中心”，选择“球员个人中心”进入球员个人中心；</p>
                    <p class="text-white">&emsp;&ensp;2、点击“教练信息”中的“激活”按钮；</p>
                    <p class="text-white">&emsp;&ensp;3、完成“基本信息”的资料填写，点击“保存”按钮</p>

                    <p class="text-white fw">Q：如何成为“足球宝贝”</p>
                    <p class="text-white">A：1、点击导航中的“足球宝贝”按钮，进入“足球宝贝页面”；</p>
                    <p class="text-white">&emsp;&ensp;2、点击“成为宝贝”按钮，进入宝贝资料填写页面；</p>
                    <p class="text-white">&emsp;&ensp;3、完成宝贝资料的填写，点击“激活”按钮</p>

                    <p class="text-white fw">Q：我成为“球员”后可以做什么？</p>
                    <p class="text-white">成为“球员”后可以在您个人中心上传视频和图片，展示您的个人风采；您还可以加入或创建一支俱乐部。</p>

                    <p class="text-white fw">Q：如何创建俱乐部？</p>
                    <p class="text-white">A：1、点击导航中的“俱乐部”按钮，进入俱乐部页面；</p>
                    <p class="text-white">&emsp;&ensp;2、点击“创建”按钮，进入俱乐部创建页面；</p>
                    <p class="text-white">&emsp;&ensp;3、在俱乐部创建页面中完成资料填写及俱乐部LOGO的选择，点击“保存”按钮</p>

                    <p class="text-white fw">Q：为什么我无法创建俱乐部？</p>
                    <p class="text-white">A：1、您可能还没有激活球员角色，只有激活球员角色才可以创建俱乐部；</p>
                    <p class="text-white">&emsp;&ensp;2、您可能已加入或拥有一支俱乐部，每个用户只允许加入或拥有一支俱乐部</p>

                    <p class="text-white fw">Q：俱乐部能做什么？</p>
                    <p class="text-white">A：俱乐部在线上完成与其他俱乐部的对战预约，在俱乐部中展示您的比赛战绩；在俱乐部中上传视频及图片，展示本俱乐部的风采</p>

                    <p class="text-white fw">Q：如何进行线上对战预约？</p>
                    <p class="text-white">A：您可在俱乐部中的对战预告中，点击“对战PK”按钮，匹配您的对手；您还可以在俱乐部列表中选择俱乐部进行挑战</p>

                    <p class="text-white fw">Q：为什么我加入了俱乐部却无法进行对战预约？</p>
                    <p class="text-white">A：只有俱乐部队长才可以进行对战预约</p>

                    <p class="text-white fw">Q：我是俱乐部队长，为什么我无法进行对战预约？</p>
                    <p class="text-white">A：请您检查下，您的俱乐部是否有对战未完成或者上传的比赛结果双方未确认</p>

                    <p class="text-white fw">Q：我如何上传比赛结果？</p>
                    <p class="text-white">A：俱乐部管理员进入俱乐部页面，点击“上传结果”按钮可上传相关场次的数据，该数据在对战双方确认后生效</p>

                    <p class="text-white fw">Q：我为什么无法上传比赛结果？</p>
                    <p class="text-white">A：只有俱乐部管理员可以上传比赛结果</p>

                    <p class="text-white fw">Q：为什么会我明明完成了比赛，但是会显示该场比赛作废？</p>
                    <p class="text-white">A：比赛完成后7天，参赛双方都未上传比赛结果，该场比赛视为作废</p>
                    
                    <p class="text-white fw">Q：比赛作废会有什么影响吗？</p>
                    <p class="text-white">A：比赛作废场次达到一定数量，您的账号会被冻结</p>
                    
                    <p class="text-white fw">Q：成为“足球宝贝”后，我可以做什么？</p>
                    <p class="text-white">A：您可以在您的个人中心中上传图片和视频，您可以接受俱乐部的邀请，为俱乐部助威或代言</p>
                    
                    <p class="text-white fw">Q：我为什么无法为俱乐部代言？</p>
                    <p class="text-white">A：只有“足球宝贝”才能为俱乐部代言</p>
                    
                    <p class="text-white fw">Q：我为什么无法为俱乐部助威？</p>
                    <p class="text-white">：只有“足球宝贝”才能为俱乐部助威</p>
                    
                    <p class="text-white fw">Q：我可以同时为多个俱乐部代言吗？</p>
                    <p class="text-white">A：不能</p>
                    
                    <p class="text-white fw">Q：我可以同时为多个俱乐部助威吗？</p>
                    <p class="text-white">A：可以，但请您协调好自己的时间。</p>
                    
                    <p class="text-white fw">Q：我是俱乐部的管理员，为什么我无法邀请宝贝助威？</p>
                    <p class="text-white">A：只有在形成比赛预约后才可以邀请宝贝前往助威，一场比赛一个俱乐部只能邀请三位足球宝贝前往助威</p>
                    
                    <p class="text-white fw">Q：我是俱乐部的管理员，我如何邀请宝贝为俱乐部助威？</p>
                    <p class="text-white">A：当你形成对战预约后，可在宝贝列表中查询宝贝，并进入她的个人中心，向她发出助威邀请，宝贝同意后，会在比赛预告中展示出助威宝贝</p>
                    
                    <p class="text-white fw">Q：我是俱乐部的管理员，我如何邀请宝贝为俱乐部代言？</p>
                    <p class="text-white">A：您可在宝贝列表中查询宝贝，并进入她的个人中心，向她发出代言邀请，宝贝同意后会在“俱乐部的宝贝们”中展示</p>
                </div>
            </div>
            <div class="clearit"></div>
        </div>
    </div>
     <!--页脚-->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>