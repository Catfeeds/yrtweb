<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宇任拓-联赛协议</title>
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
<style>
        .container {
            padding-top: 5%;
        }

        .center {
            text-align: center;
        }

        .s {
            width: 100%;
            height: 55px;
            line-height: 55px;
            background: #00bfff;
            color: #fff;
            font-size: 18px;
        }

        .ms {
            font-family: "Microsoft YaHei";
        }

        .form-group {
            word-break: break-all;
            display: inline-block;
        }

        .t2 {
            text-indent: 2em;
        }

        .sumit {
            width: 100%;
            position: fixed;
            background: #fff;
            bottom: 0;
        }

        #sumit {
            width: 90%;
        }

        .ml10 {
            margin-left: 10px;
        }
        .xieyi {
            position: relative;
            width: 600px;
            padding: 10px 25px;
            color: #fff;
            font-size: 12px;
        }
        .xieyi p.n {
            text-align: center;
        }
        .closeBtn_1 {
            position: absolute;
            right: 0px;
            top: 0px;
            width: 30px;
            height: 30px;
            background: url(images/closebtn_1.png) no-repeat;
            cursor: pointer;
        }
        .agree_btn {
            padding: 4px 15px;
            border: 1px solid #eb6100;
            background: #eb6100;
            color: #fff;
            border-radius: 4px;
        }
        .cannel_btn {
            padding: 4px 15px;
            border: 1px solid #999;
            background: #999;
            color: #fff;
            border-radius: 4px;
        }
    </style>
</head>
<body style="background: url(${ctx}/resources/images/bb_bg.png) repeat-y;">
	<div class="xieyi">
			<input type="hidden" id="cfg_id" value="${cfgid}"/>
			<input type="hidden" id="type" value="${type}"/>
            <!-- <p class="n">联赛协议</p> -->
            <div class="form-group" style="padding-bottom: 55px;">
                <p class="t2">
                    一、赛事介绍
                </p>
                <p class="t2">
                    宇任拓足球超级联赛（英文名Uniplay Super League，简称宇超或USL）是由成都宇任拓网络科技有限公司发起创办，成都电视台联合主办，在成都市足球协会指导下，结合互联网平台，针对业余足球运动员的首个O2O足球赛事。业余俱乐部和业余球员将在宇超获得如职业足球一般的美妙体验。首届宇超联赛将于2015年12月26日开始在成都谢菲联足球基地举行，为期两个月。
                    作为一项全新概念的足球赛事，宇超联赛将在今后持续进行，并逐渐形成具有联赛分级制度的品牌赛事。
                </p>
                <p class="t2"> 二、赛事组委会 </p>
                <p class="t2">•	指导单位：成都市足球协会 </p>
                <p class="t2"> •	主办方：成都宇任拓网络科技有限公司 </p>
                <p class="t2">•	联合主办：成都电视台 </p>
                <p class="t2"> •	承办方：成都谢菲联足球基地 </p>
                <p class="t2"> •	执行机构：成都标点文化传播有限公司 </p>
                <p class="t2">三、赛程 </p>
                <p class="t2"> 1.	参赛俱乐部：比赛拟报名俱乐部24支。 </p>
                <p class="t2">2.	赛事分组：参赛俱乐部分为A、B、C三组，每组8支队伍，以抽签方式决定分组，三组之间为平行关系，各组内部进行单循环比赛。 </p>
                <p class="t2">3.	比赛场次：每组各进行7轮28场赛事，三组共计84场赛事。 </p>
                <p class="t2"> 4.	比赛日期：2015年12月26日 – 2016年2月，如因天气原因导致部分比赛无法按期进行，组委会将另行通知安排补赛。 </p>
                <p class="t2">5.	赛事名次：联赛采取职业足球惯用的积分制，按赛事总积分决定名次 </p>
                <p class="t2">6.	联赛级别：首届宇超后宇任拓联赛体系将进行分级，首届联赛每组前4名将获得第二届宇超联赛参赛资格，后4名获得宇任拓甲级联赛参赛资格。 </p>
                <p class="t2">
                    四、参赛规则
                <p class="t2">
                    1.	报名参赛
                <p class="t2">
                    俱乐部（主席）报名步骤
                <p class="t2">
                    俱乐部主席报名日期：11月11日-12月8日
                <p class="t2">
                    1)	向赛事组委会交纳10000元报名费及3000元保证金，获得参赛验证码，并获得客服人员联系。报名费中已包含场地费、俱乐部保险、裁判费用等所有参赛费用。
                <p class="t2">
                    2)	选出1人成为俱乐部主席，负责为俱乐部报名参赛。俱乐部主席具备管理整支俱乐部的权力和责任。
                <p class="t2">
                    3)	俱乐部主席登录宇任拓网站www.11uniplay.com，注册成为用户，通过实名认证。
                <p class="t2">
                    4)	在广场页面选择“第一届宇任拓超级联赛”，点击“立即报名”（或在上方“联赛”栏选择“报名”），进入报名页面，选择“俱乐部管理者”报名。
                <p class="t2">
                    5)	详细阅读《宇任拓超级联赛比赛章程》，完善报名资料，输入验证码，成为联赛正式参赛俱乐部。
                <p class="t2">
                    6)	每位俱乐部主席可携带不超过6位自己的初始队员，给参赛验证码队员
                <p class="t2">
                    业余球员报名步骤
                <p class="t2">
                    初始球员报名日期：11月11日-12月12日
                <p class="t2">
                    a.	单飞球员：
                <p class="t2">
                    1）	登录宇任拓网站www.11uniplay.com，注册成为用户。
                <p class="t2">
                    2）	在广场页面选择“第一届宇任拓超级联赛”，点击“立即报名”（或在上方“联赛”栏选择“报名”）
                <p class="t2">
                    3）	选择“球员”身份报名
                <p class="t2">
                    4）	填写报名资料，提交审核，审核通过后可成为联赛的挂牌球员
                <p class="t2">
                    5）	用视频和数据来展示自己的能力，吸引来自业余豪门的邀请
                <p class="t2">
                    6）	球员亦可线下支付报名费提交个人资料，工作人员负责录入
                <p class="t2">
                    b.	组队球员
                <p class="t2">
                    1）	登录宇任拓网站www.11uniplay.com，注册成为用户。
                <p class="t2">
                    2）	在广场页面选择“第一届宇任拓超级联赛”，点击“立即报名”（或在上方“联赛”栏选择“报名”）
                <p class="t2">
                    3）	选择“球员”身份报名
                <p class="t2">
                    4）	填写报名资料，提交审核，审核通过后可输入由俱乐部主席提供的参赛验证码，成为该俱乐部下属球员
                <p class="t2">
                    5）	每位俱乐部主席拥有不超过6个球员参赛验证码
                <p class="t2">
                    6）	球员亦可线下支付报名费提交个人资料，工作人员负责录入

                <p class="t2">
                    2.	俱乐部组建
                <p class="t2">
                    1)	宇任拓网站将根据俱乐部数量和组队球员数量分批上传初始挂牌球员资料，俱乐部主席代表俱乐部在限定时间内筛选并抢拍球员，限定时间截止时拍价最高的俱乐部可获得该球员作为初始球员。
                <p class="t2">
                    2)	抢拍时间为12月12日-12月19日。抢拍完成后俱乐部球员数量不得少于15人，不得多于20人。
                <p class="t2">
                    3.	球员转会
                <p class="t2">
                    1)	联赛进行期间，有两个转会窗口期，俱乐部主席可以根据球员表现挂牌球员并标价进行交易。
                <p class="t2">
                    2)	俱乐部如接受标价即可立即交易并获得该球员。
                <p class="t2">
                    3)	除去挂牌球员后，俱乐部球员人数不得少于12人。加上转会所得球员后，俱乐部球员人数不得多于20人。
                <p class="t2">
                    五、比赛规则及其他事项
                <p class="t2">
                    1、宇超联赛执委会
                <p class="t2">
                    1）	宇超联赛执委会负责监督比赛的公平、公开、公正的进行，并收集各队对于宇超联赛的建议，以提升比赛体验。
                <p class="t2">
                    2）	首届宇超联赛各队主席自动成为宇超联赛执委会成员。
                <p class="t2">
                    3）	参赛俱乐部如对比赛当值裁判存在任何异议，可在完成比赛后3日内举证，可向执委会提出书面报告。

                <p class="t2">
                    2、比赛人数
                <p class="t2">
                    1）	每支俱乐部上场人数不超过8人，其中包含一名门将
                <p class="t2">
                    2）	每队赛前到场人数少于6人（不包括6人）或在比赛中球员被罚出场致场上队员少于6人时，裁判有权判罚该队0：3获负。如上述情况出现时场上分差超过3个，则按实际比分计算。
                <p class="t2">
                    3）	每场比赛允许每队换人名额为6人，且换下队员不得被换上。
                <p class="t2">
                    4）	赛事球员资格不做特别限制，凡属中国籍合法居民及外国籍合法长期居留中国人士（性别不限），均可参加比赛。有重大疾病史者不允许参赛。

                <p class="t2">
                    3、比赛时间
                <p class="t2">
                    1）	每场比赛分上下两个半场，每个半场按30分钟计（按毛时，不停表）。两个半场之间休息10分钟。
                <p class="t2">
                    2）	参赛俱乐部必须于赛前15分钟到达场地，将首发名单交给赛事工作人员进行参赛资格检录。
                <p class="t2">
                    3）	如俱乐部迟到10分钟以上或未出现在比赛现场，裁判有权判罚该队0：3获负。

                <p class="t2">
                    4、比赛装备
                <p class="t2">
                    1)	参赛俱乐部需要保证服装尽量统一，报名时各参赛俱乐部需要将服装颜色上报组委会，且球衣号码必须清晰且与报名表一致。号码与报名表不符合者不允许上场。队长必须佩戴袖标。
                <p class="t2">
                    2)	比赛允许宇超联赛执委会负责监督比赛的公平、公开、公正的进行。
                <p class="t2">
                    3)	如对阵双方球衣颜色相近，客队须穿着分队背心参赛，且身着号码清晰的运动短裤。
                <p class="t2">
                    4)	门将的服装必须明显区别于其余场上球员。

                <p class="t2">
                    5、比赛胜负
                <p class="t2">
                    1）	每场比赛获胜俱乐部获得3个积分，失利俱乐部不得分，两队打平获得1个积分。
                <p class="t2">
                    2）	决定排名时，采用积分 > 胜负关系 > 净胜球 〉进球数，如仍出现相同情况，则采取抽签决定。

                <p class="t2">
                    6、犯规与纪律
                <p class="t2">
                    1）	赛事不设越位。
                <p class="t2">
                    2）	参赛俱乐部如在比赛期间使用本队参赛报名名单以外的队员参赛，则裁判有权判罚该队0：3获负。
                <p class="t2">
                    3）	参赛球员在赛事期间累计获3张黄牌将被自动停赛一场，1张红牌将被自动停赛一场，情节严重者，主办方有权进行追加竞赛。

                <p class="t2">
                    7、保证金罚没
                <p class="t2">
                    1）	此次比赛中产生的所有罚款将从纪律保证金中扣除。赛事结束后三个工作内根据犯规和违纪情况扣除罚没部分后返还。
                <p class="t2">
                    2）	宇超联赛仅允许各队报名队员参加比赛，禁止未报名队员参加比赛。禁止各队不通过宇任拓网站私自交换球员参加比赛，如发现比赛中未报名队员参加比赛或私自交换球员参加比赛，则该队伍该场比赛判负0：3，同时保证金罚没1000元，并冻结俱乐部下个转会期的交易权。
                <p class="t2">
                    3）	赛事对于单场1张黄牌处以50元保证金罚没，当场累计2张黄牌被罚下处于150元保证金罚没，直接红牌被罚下每张处以200元保证金罚没。
                <p class="t2">
                    4）	某轮比赛弃权（含擅自离场）处以800元保证金罚没。
                <p class="t2">
                    5）	参赛俱乐部出现群体斗殴事件，双方被处以保证金1000元罚没，情节严重的俱乐部将被取消参赛资格。
                <p class="t2">
                    6）	参赛俱乐部因故影响参加比赛，需至少提前三天向赛事举办方提出改期申请，并由赛事举办方及对阵俱乐部三方协调一致方可改期。

                <p class="t2">
                    8、安全及保障：
                <p class="t2">
                    1）	赛事组委会为所有参赛球员统一购买保险。
                <p class="t2">
                    2）	赛事组委会为比赛准备急救包，用于处理赛场临时创伤。

                <p class="t2">
                    9、如遇突发特殊情况或联赛规则中未尽事宜，赛事组委会将后续补充公布。针对宇任拓足球超级联赛的所有最终解释权，归成都宇任拓网络科技有限公司所有。


                </p>
            </div>
            <div style="width: 600px;margin: 20px auto;text-align: center;">
                <input type="button" onclick="submit_agr()" value="确定" class="agree_btn" />
                <input type="button" onclick="cannel_agr()" value="取消" class="cannel_btn ml40" />
            </div>

        </div>
        <script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 

<script type="text/javascript">
function cannel_agr(){
	window.parent.closeAframe();
}

function submit_agr(){
	var cfgid = $("#cfg_id").val();
	var type = $("#type").val();
	window.parent.user_to_sign(cfgid,type,true);
}
</script>
</body>
</html>