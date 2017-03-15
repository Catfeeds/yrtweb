package com.yt.framework.service.Impl.adminImpl;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.mapper.CommonMapper;
import com.yt.framework.mapper.SysDictMapper;
import com.yt.framework.mapper.admin.AdminEventForecastMapper;
import com.yt.framework.mapper.admin.AdminImageVideoLeagueMapper;
import com.yt.framework.mapper.admin.AdminLeagueGroupMapper;
import com.yt.framework.mapper.admin.AdminLeagueScorerMapper;
import com.yt.framework.mapper.admin.AdminLeagueStatisticsMapper;
import com.yt.framework.mapper.admin.AdminNewsMapper;
import com.yt.framework.mapper.admin.AdminPlayerInfoMapper;
import com.yt.framework.mapper.admin.AdminSignMapper;
import com.yt.framework.mapper.admin.AdminTeamInfoMapper;
import com.yt.framework.mapper.admin.AdminTeamIntegralMapper;
import com.yt.framework.mapper.admin.AdminUserMapper;
import com.yt.framework.mapper.admin.AdminUserOrderMapper;
import com.yt.framework.mapper.admin.AdminUserProductMapper;
import com.yt.framework.mapper.admin.IndexModelMapper;
import com.yt.framework.service.BaseService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;

/**
 * 通用service方法实现
 * 所有dao在这里注入,根据传入的泛型类型调用相对应dao的方法，要求实体与dao的命名规则如：（实体：User  dao：userMapper）
 * 所有service继承这个baseService以获得这些通用方法
 * @author GL
 * @param <T>
 */
@Service("baseAdminService")
@Lazy(true)
public class BaseAdminServiceImpl<T> implements BaseService<T> {
	
	protected static Logger logger = LogManager.getLogger(BaseAdminServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
	protected BaseMapper baseMapper;
	
	@Autowired
	protected SecurityService securityService;
	
	@Autowired
	protected CommonMapper commonMapper;
	//admin
	@Autowired
	protected IndexModelMapper indexModelMapper;
	@Autowired
	protected AdminSignMapper adminSignMapper;
	@Autowired
	protected AdminNewsMapper newsMapper;
	@Autowired
	protected AdminLeagueGroupMapper leagueGroupMapper;
	@Autowired
	protected AdminImageVideoLeagueMapper imageVideoLeagueMapper;
	@Autowired
	protected AdminTeamIntegralMapper teamIntegralMapper;
	@Autowired
	protected AdminLeagueScorerMapper leagueScorerMapper;
	@Autowired
	protected AdminLeagueStatisticsMapper leagueStatisticsMapper;
	@Autowired
	protected AdminTeamInfoMapper teamInfoMapper;
	@Autowired
	protected AdminUserMapper userMapper;
	@Autowired
	protected AdminPlayerInfoMapper playerInfoMapper;
	@Autowired
	protected SysDictMapper sysDictMapper;
	@Autowired
	protected AdminEventForecastMapper adminEventForecastMapper;
	@Autowired
	protected AdminUserOrderMapper userOrderMapper;
	@Autowired
	protected AdminUserProductMapper userProductMapper;
	
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
			e.printStackTrace();
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

	@Override
	@Cacheable(value = "objCache",key = "'id'+#id")
	public String id2Name(String id){
		return baseMapper.id2Name(id);
	}
}
