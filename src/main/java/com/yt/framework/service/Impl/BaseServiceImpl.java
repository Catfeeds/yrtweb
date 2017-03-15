package com.yt.framework.service.Impl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.ActivitySignMapper;
import com.yt.framework.mapper.AgentInfoMapper;
import com.yt.framework.mapper.BabyCheerMapper;
import com.yt.framework.mapper.BabyEvalMapper;
import com.yt.framework.mapper.BabyInMapper;
import com.yt.framework.mapper.BabyInfoMapper;
import com.yt.framework.mapper.BabyScoreMapper;
import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.mapper.BbsNoteMapper;
import com.yt.framework.mapper.CertificationMapper;
import com.yt.framework.mapper.CoachCareerMapper;
import com.yt.framework.mapper.CoachHonorMapper;
import com.yt.framework.mapper.CoachInfoMapper;
import com.yt.framework.mapper.CommonMapper;
import com.yt.framework.mapper.DressResourcesMapper;
import com.yt.framework.mapper.DressupMapper;
import com.yt.framework.mapper.DynamicMapper;
import com.yt.framework.mapper.EventForecastMapper;
import com.yt.framework.mapper.EventRecordMapper;
import com.yt.framework.mapper.FeedBackMapper;
import com.yt.framework.mapper.ImageVideoLeagueMapper;
import com.yt.framework.mapper.ImageVideoMapper;
import com.yt.framework.mapper.ImageVideoTeamMapper;
import com.yt.framework.mapper.LeagueAuctionMapper;
import com.yt.framework.mapper.LeagueCostMapper;
import com.yt.framework.mapper.LeagueMapper;
import com.yt.framework.mapper.LeagueMarketMapper;
import com.yt.framework.mapper.LeagueStatisticsMapper;
import com.yt.framework.mapper.MessageMapper;
import com.yt.framework.mapper.MessageRecordsMapper;
import com.yt.framework.mapper.NewsMapper;
import com.yt.framework.mapper.OrderMapper;
import com.yt.framework.mapper.PayCostMapper;
import com.yt.framework.mapper.PayRecordMapper;
import com.yt.framework.mapper.PkRecordMapper;
import com.yt.framework.mapper.PlayerCareerMapper;
import com.yt.framework.mapper.PlayerHobbyMapper;
import com.yt.framework.mapper.PlayerHonorMapper;
import com.yt.framework.mapper.PlayerInfoMapper;
import com.yt.framework.mapper.PlayerOtherMapper;
import com.yt.framework.mapper.PriceSlaveMapper;
import com.yt.framework.mapper.ProductMapper;
import com.yt.framework.mapper.SalaryRecordMapper;
import com.yt.framework.mapper.ScheduleSmsMapper;
import com.yt.framework.mapper.SpaceMapper;
import com.yt.framework.mapper.SysDictMapper;
import com.yt.framework.mapper.TeamInfoMapper;
import com.yt.framework.mapper.TeamInviteMapper;
import com.yt.framework.mapper.TeamLoanPlayerMapper;
import com.yt.framework.mapper.UserAmountMapper;
import com.yt.framework.mapper.UserMapper;
import com.yt.framework.mapper.UserOrderMapper;
import com.yt.framework.mapper.UserProductMapper;
import com.yt.framework.mapper.VisitorMapper;
import com.yt.framework.mapper.admin.AdminEventForecastMapper;
import com.yt.framework.mapper.admin.AdminEventRecordMapper;
import com.yt.framework.mapper.admin.AdminLeagueGroupMapper;
import com.yt.framework.mapper.admin.AdminPkRecordMapper;
import com.yt.framework.mapper.admin.AdminSignMapper;
import com.yt.framework.mapper.admin.IndexModelMapper;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.service.BaseService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.PropertiesUtils;

/**
 * 通用service方法实现
 * 所有dao在这里注入,根据传入的泛型类型调用相对应dao的方法，要求实体与dao的命名规则如：（实体：User  dao：userMapper）
 * 所有service继承这个baseService以获得这些通用方法
 * @author GL
 * @param <T>
 */
@Service("baseService")
@Lazy(true)
public class BaseServiceImpl<T> implements BaseService<T> {
	
	protected static Logger logger = LogManager.getLogger(BaseServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
	protected BaseMapper baseMapper;
	
	@Autowired
	protected SecurityService securityService;
	
	@Autowired
	protected UserMapper userMapper;
	@Autowired
	protected PlayerInfoMapper playerInfoMapper;
	@Autowired
	protected PlayerCareerMapper playerCareerMapper;
	@Autowired
	protected PlayerHobbyMapper playerHobbyMapper;
	@Autowired
	protected PlayerHonorMapper playerHonorMapper;
	@Autowired
	protected PlayerOtherMapper playerOtherMapper;
	@Autowired
	protected TeamInfoMapper teamInfoMapper;
	@Autowired
	protected AgentInfoMapper agentInfoMapper;
	@Autowired
	protected CoachInfoMapper coachInfoMapper;
	@Autowired
	protected CoachHonorMapper coachHonorMapper;
	@Autowired
	protected CoachCareerMapper coachCareerMapper;
	@Autowired
	protected DynamicMapper dynamicMapper;
	@Autowired
	protected MessageMapper messageMapper;
	@Autowired
	protected PayRecordMapper payRecordMapper;
	@Autowired
	protected PayCostMapper payCostMapper;
	@Autowired
	protected ImageVideoMapper imageVideoMapper;
	@Autowired
	protected ImageVideoTeamMapper imageVideoTeamMapper;
	@Autowired
	protected TeamInviteMapper teamInviteMapper;
	@Autowired
	protected DressResourcesMapper dressResourcesMapper;
	@Autowired
	protected DressupMapper dressupMapper;
	@Autowired
	protected FeedBackMapper feedBackMapper;
	@Autowired
	protected MessageRecordsMapper messageRecordsMapper;
	@Autowired
	protected CertificationMapper certificationMapper;
	@Autowired
	protected VisitorMapper visitorMapper;
	@Autowired
	protected CommonMapper commonMapper;
	@Autowired
	protected SpaceMapper spaceMapper;
	@Autowired
	protected ScheduleSmsMapper scheduleSmsMapper;
	@Autowired
	protected BabyInfoMapper babyInfoMapper;
	@Autowired
	protected BabyCheerMapper babyCheerMapper;
	@Autowired
	protected BabyInMapper babyInMapper;
	@Autowired
	protected BabyEvalMapper babyEvalMapper;
	@Autowired
	protected BabyScoreMapper babyScoreMapper;
	@Autowired
	protected LeagueMapper leagueMapper;
	@Autowired
	protected SalaryRecordMapper salaryRecordMapper;
	@Autowired
	protected UserAmountMapper userAmountMapper;
	@Autowired
	protected LeagueAuctionMapper leagueAuctionMapper;
	@Autowired
	protected LeagueCostMapper leagueCostMapper;
	@Autowired
	protected LeagueMarketMapper leagueMarketMapper; 
	@Autowired
	protected PkRecordMapper pkRecordMapper;
	@Autowired
	protected EventRecordMapper eventRecordMapper;
	@Autowired
	protected EventForecastMapper eventForecastMapper;
	@Autowired
	protected NewsMapper newsMapper;
	@Autowired
	protected ImageVideoLeagueMapper imageVideoLeagueMapper;
	@Autowired
	protected PriceSlaveMapper priceSlaveMapper;
	@Autowired
	protected OrderMapper orderMapper;
	@Autowired
	protected BbsNoteMapper bbsNoteMapper;
	@Autowired
	protected LeagueStatisticsMapper leagueStatisticsMapper;
	@Autowired
	protected TeamLoanPlayerMapper teamLoanPlayerMapper;
	
	//admin
	@Autowired
	protected IndexModelMapper indexModelMapper;
	@Autowired
	protected AdminSignMapper adminSignMapper;
	
	@Autowired
	protected AdminEventForecastMapper adminEventForecastMapper;
	@Autowired
	protected AdminEventRecordMapper adminEventRecordMapper;
	@Autowired
	protected AdminLeagueGroupMapper adminLeagueGroupMapper;
	@Autowired
	protected SysDictMapper sysDictMapper;
	@Autowired
	protected ActivitySignMapper activitySignMapper;
	@Autowired
	protected AdminPkRecordMapper adminPkRecordMapper;
	@Autowired
	protected ProductMapper productMapper;
	@Autowired
	protected UserOrderMapper userOrderMapper;
	@Autowired
	protected UserProductMapper userProductMapper;
	/**
	 * 此方法在构造与赋值方法之后执行
	 * 根据相应的T类型,吧相应的Dao(Mapper)赋值给 UserMapper  User===>UserMapper
	 */
	@SuppressWarnings("rawtypes")
	@PostConstruct
	public void initBaseDao() {
		
		ParameterizedType type=(ParameterizedType)this.getClass().getGenericSuperclass();
		Class clazz=(Class)type.getActualTypeArguments()[0];
		String tName=clazz.getSimpleName();  //tName=User
		String tDao=tName.substring(0,1).toLowerCase() + tName.substring(1) + "Mapper"; // userDao
		// 根据 名称获取相应的Field字段
		try {
			Field tField=this.getClass().getSuperclass().getDeclaredField(tDao);  //Field userDao
			Field baseField=this.getClass().getSuperclass().getDeclaredField("baseMapper");  //Field baseDao
			// 把当前对象的 tField中的值,赋给当前对象的baseFile字段
			Object val = tField.get(this);  // 获取当前this对象  tField字段的值
			baseField.set(this, val);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		//设置数据字典
		if(ParamMap.getMap()==null){
			setParamMap();
		}
	}
	
	private void setParamMap(){
		Map<String, List<Map<String, Object>>> paramMap = new HashMap<String, List<Map<String, Object>>>();
		List<String> keys = sysDictMapper.queryDictsKey();
		if(keys!=null&&keys.size()>0){
			for (String key : keys) {
				List<Map<String, Object>> params = sysDictMapper.queryDicts(key);
				paramMap.put(key, params);
			}
		}
		ParamMap.setMap(paramMap);
	}

	@Override
	public T getEntityById(String id) {
		try {
			return (T) baseMapper.getEntityById(id);
		} catch (Exception e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public AjaxMsg save(T t) {
		try {
			baseMapper.save(t);
			return AjaxMsg.newSuccess().addData("data", t);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public AjaxMsg update(T t) {
		try {
			baseMapper.update(t);
			return  AjaxMsg.newSuccess().addData("data", t);
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}

	@Override
	public AjaxMsg delete(String id) {
		try {
			baseMapper.delete(id);
			return AjaxMsg.newSuccess();
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}

	@Override
	public AjaxMsg deleteByIds(String[] ids) {
		try {
			baseMapper.deleteByIds(ids);
			return AjaxMsg.newSuccess();
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public AjaxMsg queryForPage(Map<String, Object> params, PageModel<T> pageModel) {
		List<T> datas = new ArrayList<T>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = count(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = baseMapper.queryForPage(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg queryForPageForMap(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = count(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = baseMapper.queryForPageForMap(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public int count(Map<String, Object> params) {
		return baseMapper.count(params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public AjaxMsg getByUserId(String userId) {
		if(StringUtils.isNotBlank(userId)){
			T t = (T) baseMapper.getByUserId(userId);
			if(t!=null){
				return AjaxMsg.newSuccess().addData("data", t);
			}
		}
		return AjaxMsg.newError();
	}
	
	
	
	
	private String infoField = "getTack_ability,getPass_ability,getRespond_ability,getBall_ability,getExplosive,getShot,getBalance,getFill,getInsight,getFree_kick,getHeader,getPhysical,getSpeed,getPower,getGoal";
	
	/**
	 * 获取球员综合能力值
	 * @param info
	 * @return
	 * @throws Exception
	 */
	
	protected Integer getScore(PlayerInfo info) throws Exception{
		int score = getCombat(info,infoField);
		return new Integer(score);
	}
	
	/**
	 * 百米成绩得分
	 * @param info
	 * @param pp
	 * @return
	 */
	protected int getResults(PlayerInfo info) {
		Properties pp = PropertiesUtils.loadSetting("/messages/player.properties");
		double results = info.getResults()!=null?Double.parseDouble(info.getResults()):0.0;
		double betterMax = Double.parseDouble(pp.getProperty("m_betterMax"));
		double betterMin = Double.parseDouble(pp.getProperty("m_betterMin"));
		double inMax = Double.parseDouble(pp.getProperty("m_inMax"));
		double inMin = Double.parseDouble(pp.getProperty("m_inMin"));
		double kindMax = Double.parseDouble(pp.getProperty("m_kindMax"));
		double kindMin = Double.parseDouble(pp.getProperty("m_kindMax"));
		double betterCount = Double.parseDouble(pp.getProperty("m_betterCount"));
		double inCount = Double.parseDouble(pp.getProperty("m_inCount"));
		double kindCount = Double.parseDouble(pp.getProperty("m_kindCount"));
		
		int num = 0;
		int maxNum = 0;
		DecimalFormat df = new DecimalFormat("#.00");
		if(results<=betterMin){
			maxNum = Integer.parseInt(pp.getProperty("mark_betterMax"));
			num = Integer.parseInt(pp.getProperty("mark_betterMin"));
			num += Double.parseDouble(df.format(((betterMin-results)/0.1)*betterCount));
		}else if(results>=inMax&&results<=inMin){
			maxNum = Integer.parseInt(pp.getProperty("mark_inMax"));
			num = Integer.parseInt(pp.getProperty("mark_inMin"));
			num += Double.parseDouble(df.format(((inMin-results)/0.1)*inCount));
		}else if(results>=kindMax&&results<=kindMin){
			maxNum = Integer.parseInt(pp.getProperty("mark_kindMax"));
			num = Integer.parseInt(pp.getProperty("mark_kindMin"));
			num += Double.parseDouble(df.format(((kindMin-results)/0.1)*kindCount));
		}else{
			maxNum = Integer.parseInt(pp.getProperty("mark_kindMin"));
			num = Integer.parseInt(pp.getProperty("mark_kindMin"));
		}
		if(num>maxNum){
			num = maxNum;
		}
		return num;
	}
	
	/**
	 * 跑动距离得分
	 * @param distance
	 * @return int
	 */
	protected int getDistance(PlayerInfo info) {
		Properties pp = PropertiesUtils.loadSetting("/messages/player.properties");
		int distance = info.getDistance()!=null?(int) Double.parseDouble(info.getDistance()):0;
		int state = info.getPro_status();//是否职业球员 0:非职业 1：职业
		int betterMin = state==0?Integer.parseInt(pp.getProperty("non_ebetterMin")):Integer.parseInt(pp.getProperty("ebetterMin"));
		int inMax = state==0?Integer.parseInt(pp.getProperty("non_einMax")):Integer.parseInt(pp.getProperty("einMax"));
		int inMin = state==0?Integer.parseInt(pp.getProperty("non_einMin")):Integer.parseInt(pp.getProperty("einMin"));
		int kindMax = state==0?Integer.parseInt(pp.getProperty("non_ekindMax")):Integer.parseInt(pp.getProperty("ekindMax"));
		int kindMin = state==0?Integer.parseInt(pp.getProperty("non_ekindMin")):Integer.parseInt(pp.getProperty("ekindMin"));
		int betterCount = state==0?Integer.parseInt(pp.getProperty("non_ebetterCount")):Integer.parseInt(pp.getProperty("ebetterCount"));
		int inCount = state==0?Integer.parseInt(pp.getProperty("non_einCount")):Integer.parseInt(pp.getProperty("einCount"));
		int kindCount = state==0?Integer.parseInt(pp.getProperty("non_ekindCount")):Integer.parseInt(pp.getProperty("ekindCount"));
		
		int num = 0;
		int maxNum = 0;
		if(distance>=betterMin){
			maxNum = Integer.parseInt(pp.getProperty("main_betterMax"));
			num = Integer.parseInt(pp.getProperty("main_betterMin"));
			num += ((distance-betterMin)/betterCount);
		}else if(distance<=inMax&&distance>=inMin){
			maxNum = Integer.parseInt(pp.getProperty("main_inMax"));
			num = Integer.parseInt(pp.getProperty("main_inMin"));
			num += ((distance-inMin)/inCount);
		}else if(distance<=kindMax&&distance>=kindMin){
			maxNum = Integer.parseInt(pp.getProperty("main_kindMax"));
			num = Integer.parseInt(pp.getProperty("main_kindMin"));
			num += ((distance-kindMin)/kindCount);
		}else{
			maxNum = Integer.parseInt(pp.getProperty("main_kindMin"));
			num = Integer.parseInt(pp.getProperty("main_kindMin"));
		}
		if(num>maxNum){
			num = maxNum;
		}
		return num;
	}

	protected int getCombat(Object obj,String field) throws Exception{
		int num = 0;
		Method[] methods = obj.getClass().getMethods();
		for(int i = 0; i < methods.length; i++){  
           Method method = methods[i];  
           if(method.getName().startsWith("get")){
        	   if(field.contains(method.getName())){
        		  if(method.invoke(obj)!=null){
        			  num+=Integer.parseInt(method.invoke(obj).toString());
        		  }
        	   }
           }  
		}
		return num;
	}
	
	public String id2Name(String id){
		return baseMapper.id2Name(id);
	}
}
