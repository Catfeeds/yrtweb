package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.sun.org.apache.xerces.internal.impl.dv.xs.DecimalDV;

/**
 * 球员基本信息
 * 
 * @Title: PlayerInfo.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月3日 下午2:47:59
 */
public class PlayerInfo implements Serializable {
	private static final long serialVersionUID = 8374524032718340425L;

	private String id;// '球员ID',
	private String user_id;
	private Integer height;// '身高（单位：厘米）',
	private Double weight;// '体重（单位:kg）',
	private String position; // '场上位置',
	private String cfoot; // '常用脚（左、右、均衡）',
	private Integer score; // '球员综合得分',
	private Date create_time; // '创建时间',
	private Integer is_sign;// '是否已签约 0：未签约 1：已签约',
	private Integer invitat_team; // '是否接受组队邀请0：不接受 1：接受',
	private Integer ball_format; // 喜爱赛制（5、7、11）',
	private BigDecimal self_price;// '自我标价',
	private String tags;// '特点标签',
	private Integer pro_status;// '职业状态 0:非职业 1：职业',
	private String explosive; // '爆发力',
	private String injured_area; // '受伤部位',
	private String results;// '百米成绩',
	private String distance;// '跑动距离(5,7,11赛制)',
	private String type;// '类型（耐力型，进攻性，防守型等）',
	private String ball_ability;// '控球能力',
	private String respond_ability;// '反应能力',
	private String pass_ability;// '传球能力',
	private String tack_ability;// '抢断能力',
	private String player_temp; //球员模版
	private String shot;// '远射能力',
	private Integer bou_count;// '颠球数',
	private String balance;// '平衡能力',
	private String physical;// '体力值',
	private String defense;// '回防能力',
	private String attack;// '进攻能力',
	private String ball_long;// '长传能力',
	private String assists;// '助攻能力',
	private String insight;// '洞察能力',
	private String header;// '头球能力',
	private String corner;// '角球能力',
	private String free_kick;// '任意球能力',
	private String fill;// '补位能力',
	private String speed;//速度
	private String power;//力量
	private String goal;//守门能力
	private String love_num;//意向球衣号
	private BigDecimal current_price;//当前身价
	private Integer if_league;//是否联赛球员0:否 1:是
	
	private Integer level;//认证级别
	private Integer if_daji;//是否妖人
	
	public String getLove_num() {
		return love_num;
	}

	public void setLove_num(String love_num) {
		this.love_num = love_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getCfoot() {
		return cfoot;
	}

	public void setCfoot(String cfoot) {
		this.cfoot = cfoot;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getIs_sign() {
		return is_sign;
	}

	public void setIs_sign(Integer is_sign) {
		this.is_sign = is_sign;
	}

	public Integer getInvitat_team() {
		return invitat_team;
	}

	public void setInvitat_team(Integer invitat_team) {
		this.invitat_team = invitat_team;
	}

	public Integer getBall_format() {
		return ball_format;
	}

	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}

	public BigDecimal getSelf_price() {
		return self_price;
	}

	public void setSelf_price(BigDecimal self_price) {
		this.self_price = self_price;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public Integer getPro_status() {
		return pro_status;
	}

	public void setPro_status(Integer pro_status) {
		this.pro_status = pro_status;
	}

	public String getExplosive() {
		return explosive;
	}

	public void setExplosive(String explosive) {
		this.explosive = explosive;
	}

	public String getInjured_area() {
		return injured_area;
	}

	public void setInjured_area(String injured_area) {
		this.injured_area = injured_area;
	}

	public String getResults() {
		return results;
	}

	public void setResults(String results) {
		this.results = results;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBall_ability() {
		return ball_ability;
	}

	public void setBall_ability(String ball_ability) {
		this.ball_ability = ball_ability;
	}

	public String getRespond_ability() {
		return respond_ability;
	}

	public void setRespond_ability(String respond_ability) {
		this.respond_ability = respond_ability;
	}

	public String getPass_ability() {
		return pass_ability;
	}

	public void setPass_ability(String pass_ability) {
		this.pass_ability = pass_ability;
	}

	public String getTack_ability() {
		return tack_ability;
	}

	public void setTack_ability(String tack_ability) {
		this.tack_ability = tack_ability;
	}

	public String getPlayer_temp() {
		return player_temp;
	}

	public void setPlayer_temp(String player_temp) {
		this.player_temp = player_temp;
	}

	public String getShot() {
		return shot;
	}

	public void setShot(String shot) {
		this.shot = shot;
	}

	public Integer getBou_count() {
		return bou_count;
	}

	public void setBou_count(Integer bou_count) {
		this.bou_count = bou_count;
	}

	public String getBalance() {
		return balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getPhysical() {
		return physical;
	}

	public void setPhysical(String physical) {
		this.physical = physical;
	}

	public String getDefense() {
		return defense;
	}

	public void setDefense(String defense) {
		this.defense = defense;
	}

	public String getAttack() {
		return attack;
	}

	public void setAttack(String attack) {
		this.attack = attack;
	}

	public String getBall_long() {
		return ball_long;
	}

	public void setBall_long(String ball_long) {
		this.ball_long = ball_long;
	}

	public String getAssists() {
		return assists;
	}

	public void setAssists(String assists) {
		this.assists = assists;
	}

	public String getInsight() {
		return insight;
	}

	public void setInsight(String insight) {
		this.insight = insight;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getCorner() {
		return corner;
	}

	public void setCorner(String corner) {
		this.corner = corner;
	}

	public String getFree_kick() {
		return free_kick;
	}

	public void setFree_kick(String free_kick) {
		this.free_kick = free_kick;
	}

	public String getFill() {
		return fill;
	}

	public void setFill(String fill) {
		this.fill = fill;
	}

	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	public String getPower() {
		return power;
	}

	public void setPower(String power) {
		this.power = power;
	}

	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	public BigDecimal getCurrent_price() {
		return current_price;
	}

	public void setCurrent_price(BigDecimal current_price) {
		this.current_price = current_price;
	}

	public Integer getIf_league() {
		return if_league;
	}

	public void setIf_league(Integer if_league) {
		this.if_league = if_league;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getIf_daji() {
		return if_daji;
	}

	public void setIf_daji(Integer if_daji) {
		this.if_daji = if_daji;
	}

}
