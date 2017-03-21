package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.management.RuntimeErrorException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.IndexMapper;
import com.yt.framework.persistent.entity.IndexBanner;
import com.yt.framework.persistent.entity.IndexModel;
import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.FileService;
import com.yt.framework.service.IndexService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.oss.OSSClientFactory;

@Service("indexService")
public class IndexServiceImpl implements IndexService {
	
	protected static Logger logger = LogManager.getLogger(IndexServiceImpl.class);
	
	@Autowired
	private IndexMapper indexMapper;
	@Autowired
	private FileService fileService;

	@Override
	public AjaxMsg queryNews(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.newsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = indexMapper.queryNews(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}


	@Override
	public News getNewsById(String nid) {
		if(StringUtils.isNotBlank(nid)){
			News news = indexMapper.getNewsById(nid);
			return news;
		}
		return null;
	}


	@Override
	public AjaxMsg queryImageOrVideos(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.imagesOrVideosCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = indexMapper.queryImagesOrVideos(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveField(String type) {
		IndexModel im = indexMapper.getIndexBySortDesc(type);
		int sort = 1;
		if(im!=null){
			sort = im.getSort()+1;
		}
		im = new IndexModel();
		im.setId(UUIDGenerator.getUUID());
		im.setSort(sort);
		im.setType(type);
		int num = indexMapper.saveField(im);
		return AjaxMsg.newSuccess();
	}


	@Override
	public AjaxMsg deleteField(String id) {
		int num = indexMapper.deleteField(id);
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg saveFieldValue(IndexModel index) {
		int num = indexMapper.saveField(index);
		return AjaxMsg.newSuccess();
	}


	@Override
	public AjaxMsg updateFieldValue(IndexModel index) {
		int num = indexMapper.updateFieldValue(index);
		return AjaxMsg.newSuccess();
	}


	@Override
	public AjaxMsg queryBabys(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.babysCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = indexMapper.queryBabys(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}


	@Override
	public AjaxMsg queryAllBabys(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.allBabysCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = indexMapper.queryAllBabys(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}


	@Override
	public AjaxMsg queryPlayers(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.playersCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> players = indexMapper.queryPlayers(params);
			if(players!=null&&players.size()>0){
				for (Map<String, Object> playerInfo : players) {
					String position = playerInfo.get("position")!=null?playerInfo.get("position").toString():"";
					String[] pos = position.split(",");
					String posStr = "";
					if(pos!=null&&pos.length>0) posStr = ParamMap.getParam("p_position", pos[0]);
					playerInfo.put("position", posStr);
					playerInfo.put("position_str", position);
					datas.add(playerInfo);
				}
			}
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public AjaxMsg queryAllPlayers(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.allPlayersCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> players = indexMapper.queryAllPlayers(params);
			if(players!=null&&players.size()>0){
				for (Map<String, Object> playerInfo : players) {
					String position = playerInfo.get("position")!=null?playerInfo.get("position").toString():"";
					String[] pos = position.split(",");
					String posStr = "";
					for (String string : pos) {
						posStr+=ParamMap.getParam("p_position", string)+" , ";
					}
					posStr = posStr.substring(0,posStr.lastIndexOf(","));
					playerInfo.put("position", posStr);//场上位置
					datas.add(playerInfo);
				}
			}
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}


	@Override
	public AjaxMsg queryTeamPlayers(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.teamPlayersCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> players = indexMapper.queryTeamPlayers(params);
			if(players!=null&&players.size()>0){
				for (Map<String, Object> playerInfo : players) {
					String position = playerInfo.get("position")!=null?playerInfo.get("position").toString():"";
					String[] pos = position.split(",");
					String posStr = "";
					for (String string : pos) {
						posStr+=ParamMap.getParam("p_position", string)+" , ";
					}
					posStr = posStr.substring(0,posStr.lastIndexOf(","));
					playerInfo.put("position", posStr);//场上位置
					datas.add(playerInfo);
				}
			}
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public List<Map<String, Object>> queryIndexBanners(Map<String, Object> params){
		List<Map<String, Object>> banners = indexMapper.queryIndexBanners(params);
		return banners;
	}
	
	
	@Override
	public AjaxMsg queryIndexBanners(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = indexMapper.queryIndexBannerCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = queryIndexBanners(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}


	@Override
	public AjaxMsg saveIndexBanner(IndexBanner indexBanner) throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(indexBanner.getImg_src())){
			msg = fileService.uploadImg2OSS(indexBanner.getImg_src());
			if(msg.isSuccess()){
				indexMapper.saveIndexBanner(indexBanner);
			}
		}
		return msg;
	}


	@Override
	public AjaxMsg updateIndexBanner(IndexBanner indexBanner) throws Exception{
		IndexBanner old = getIndexBannerById(indexBanner.getId());
		indexMapper.updateIndexBanner(indexBanner);
		AjaxMsg msg = fileService.uploadImg2OSS(old.getImg_src(),indexBanner.getImg_src());
		if(msg.isError()){
			throw new RuntimeException();
		}
		return msg;
	}


	@Override
	public AjaxMsg deleteIndexBanner(String id) {
		IndexBanner banner = getIndexBannerById(id);
		if(banner!=null){
			indexMapper.deleteIndexBanner(id);
			if(StringUtils.isNotBlank(banner.getImg_src())){
				OSSClientFactory.deleteFile(banner.getImg_src());
			}
		}
		return AjaxMsg.newSuccess();
	}


	@Override
	public IndexBanner getIndexBannerById(String id) {
		return indexMapper.getIndexBannerById(id);
	}


	@Override
	public List<News> queryIndexNews() {
		return indexMapper.queryIndexNews();
	}

}
