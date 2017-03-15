package com.yt.framework.service.Impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.core.task.TaskExecutor;
import org.springframework.core.task.TaskRejectedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.FileSender;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.ImageUtils;
import com.yt.framework.utils.oss.OSSClientFactory;
import com.yt.framework.utils.oss.OSSUploadFile;

/**
 *
 *@autor bo.xie
 *@date2015-8-14下午3:19:21
 */
@Transactional
@Service("imageVideoService")
public class ImageVideoServiceImpl extends BaseServiceImpl<ImageVideo> implements ImageVideoService {
	
	protected static Logger logger = LogManager.getLogger(ImageVideoServiceImpl.class);
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	@Resource(name = "taskExecutor")
    private TaskExecutor taskExecutor;
	
	@Override
	public AjaxMsg save(ImageVideo imageVideo) {
		try {
			/*String src = imageVideo.getSrc();
			File dest = new File(fileRepository.getRealPath(src));
			if(StringUtils.isBlank(src)){
				return AjaxMsg.newError().addMessage("视频/图片路径错误");
			}else if (!dest.exists()) {
				return AjaxMsg.newError().addMessage("视频/图片不存在");
			}
			if(StringUtils.isBlank(imageVideo.getId())){
				imageVideo.setId(UUIDGenerator.getUUID());
			}
			imageVideoMapper.save(imageVideo);*/
			return AjaxMsg.newSuccess().addData("data", imageVideo);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("视频/图片或获取错误");
		}
	}
	
	@Override
	public AjaxMsg update(ImageVideo imageVideo) {
		try {
			ImageVideo iv = null;
			if("image".equals(imageVideo.getType())){
				iv = imageVideoMapper.getImageById(imageVideo.getId());
			}else if("video".equals(imageVideo.getType())){
				iv = imageVideoMapper.getVideoById(imageVideo.getId());
			}
			if(iv==null) AjaxMsg.newError().addMessage("文件不存在");
			iv.setF_status(imageVideo.getF_status());
			String src = iv.getF_src();
			File dest = new File(fileRepository.getRealPath(src));
			if(StringUtils.isBlank(src)){
				return AjaxMsg.newError().addMessage("视频/图片路径错误");
			}else if (!dest.exists()) {
				return AjaxMsg.newError().addMessage("视频/图片不存在");
			}
			iv.setType(imageVideo.getType());
			imageVideoMapper.update(iv);
			return AjaxMsg.newSuccess().addData("data", imageVideo);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("视频/图片或获取错误");
		}
	}
	
	@Override
	public AjaxMsg getImageVideos(String group_id, Integer type,Integer role_type,
			PageModel<ImageVideo> pageModel) {
		if(StringUtils.isBlank(group_id) || type==null) return AjaxMsg.newError().addMessage("查询失败！");
		Map<String,Object> maps = Maps.newHashMap();
		int totalCount = imageVideoMapper.getImageVideosCount(group_id, type,role_type);
		maps.put("start", pageModel.getFirstNum());
		maps.put("rows", pageModel.getPageSize());
		List<ImageVideo> ivs = imageVideoMapper.getImageVideos(group_id, type,role_type, maps);
		pageModel.setItems(ivs);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("data", pageModel);
		
	}

	@Override
	public AjaxMsg getImageVideosByUserId(String user_id, Integer type,Integer role_type,
			PageModel<ImageVideo> pageModel) {
		if(StringUtils.isBlank(user_id) || type==null) return AjaxMsg.newError().addMessage("查询失败！");
		Map<String,Object> maps = Maps.newHashMap();
		int totalCount = imageVideoMapper.getImageVideosByUserIdCount(user_id, type,role_type);
		maps.put("start", pageModel.getFirstNum());
		maps.put("rows", pageModel.getPageSize());
		List<ImageVideo> ivs = imageVideoMapper.getImageVideosByUserId(user_id, type.intValue(),role_type,maps);
		pageModel.setItems(ivs);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("data", pageModel);
	}

	@Override
	public AjaxMsg hotImageVideos(Integer type) {
		List<Map<String, Object>> datas = imageVideoMapper.hotImageVideos(type.intValue());
		return AjaxMsg.newSuccess().addData("videos", datas);
	}
	
	@Override
	public List<Map<String, Object>> hotImageVideosList(Integer type) {
		List<Map<String, Object>> datas = imageVideoMapper.hotImageVideos(type.intValue());
		return datas;
	}
	
	@Override
	public AjaxMsg searchImageVideos(ImageVideo imageVideo,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		try {
			maps = BeanUtils.object2Map(imageVideo);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("对象转换错误");
		}
		int totalCount = imageVideoMapper.searchImageVideosCount(maps);
		maps.put("start", pageModel.getFirstNum());
		maps.put("rows", pageModel.getPageSize());
		List<Map<String, Object>> ivs = imageVideoMapper.searchImageVideos(maps);
		pageModel.setItems(ivs);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
		
	}

	@Override
	public AjaxMsg restCount(String userId, String type) {
		try {
			User user = userMapper.getEntityById(userId);
			if(user!=null){
				int count = 0;
				int ivType = 1;
				if("image".equals(type)){
					count = user.getImage_count();
				}else{
					count = user.getVideo_count();
					ivType = 2;
				}
				ImageVideo iv = new ImageVideo();
				iv.setUser_id(userId);
				//iv.setType(ivType);
				//iv.setStatus(1);
				int totalCount = imageVideoMapper.searchImageVideosCount(BeanUtils.object2Map(iv));
				Map<String, Object> obj = new HashMap<String,Object>();
				obj.put("count", count);
				obj.put("restCount", (count-totalCount));
				return AjaxMsg.newSuccess().addData("data", obj);
			}
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveImgOrVideos(ImageVideo imageVideo, String images) throws Exception{
		String[] imgs = parseImages(images);
		if(imgs!=null){
			for (String img : imgs) {
				if(StringUtils.isNotBlank(img.trim())){
					imageVideo.setF_src(img);
					imageVideo.setId(UUIDGenerator.getUUID());
					if("video".equals(imageVideo.getType())){
						imageVideo.setV_cover(img.substring(0,img.lastIndexOf("."))+".jpg");
						imageVideoMapper.saveVideo(imageVideo);
						uploadFile2OSS(imageVideo.getId(),imageVideo.getType(),fileRepository.getRealPath(imageVideo.getV_cover()),imageVideo.getV_cover());
					}else{
						imageVideoMapper.saveImage(imageVideo);
					}
					uploadFile2OSS(imageVideo.getId(),imageVideo.getType(),fileRepository.getRealPath(img),img);
				}
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public void saveImage(ImageVideo imageVideo){
		imageVideoMapper.saveImage(imageVideo);
	}
	@Override
	public void saveVideo(ImageVideo imageVideo){
		imageVideoMapper.saveVideo(imageVideo);
	}

	private String[] parseImages(String images) {
		if(StringUtils.isNotBlank(images)){
			String[] imgs = images.split(",");
			if(imgs!=null&&imgs.length>0){
				return imgs;
			}
		}
		return null;
	}

	@Override
	public AjaxMsg updateShowCenter(String userId, String id, String type,String state) {
		String msg = "";
		try {
			if("cancel".equals(state)){
				ImageVideo iv = null;
				if("image".equals(type)){
					iv = imageVideoMapper.getImageById(id);
				}else if("video".equals(type)){
					iv = imageVideoMapper.getVideoById(id);
				}
				iv.setIf_show(0);
				iv.setType(type);
				imageVideoMapper.update(iv);
			}else if("sure".equals(state)){
				ImageVideo iv = new ImageVideo();
				iv.setUser_id(userId);
				iv.setIf_show(1);
				iv.setType(type);
				iv.setRole_type(SystemEnum.IMAGE.PLAYER.toString());
				int totalCount = imageVideoMapper.searchImageVideosCount(BeanUtils.object2Map(iv));
				if(totalCount<5){
					ImageVideo ivObj = null;
					if("image".equals(type)){
						ivObj = imageVideoMapper.getImageById(id);
					}else if("video".equals(type)){
						ivObj = imageVideoMapper.getVideoById(id);
					}
					ivObj.setIf_show(1);
					ivObj.setType(type);
					imageVideoMapper.update(ivObj);
				}else{
					msg = "个人中心最多只能展示 5 张图片";
				}
			}
			if("".equals(msg)){
				return AjaxMsg.newSuccess();
			}
		} catch (Exception e) {
			return AjaxMsg.newError().addData("errorMsg", "对象转换错误");
		}
		return AjaxMsg.newError().addData("errorMsg", msg);
		
	}

	@Override
	public AjaxMsg deleteFile(String id, String type) {
		if(StringUtils.isNotBlank(id)&&StringUtils.isNotBlank(type)){
			ImageVideo iv = null;
			if("image".equals(type)){
				iv = imageVideoMapper.getImageById(id);
				imageVideoMapper.deleteImage(iv.getId());
			}else if("video".equals(type)){
				iv = imageVideoMapper.getVideoById(id);
				imageVideoMapper.deleteVideo(iv.getId());
			}
			if(StringUtils.isBlank(iv.getAdd_iv_id())){
				String fileUrl = iv.getF_src();
				String ext = fileUrl.substring(fileUrl.lastIndexOf(".")+1);
				if(ImageUtils.isValidVideoExt(ext)){
					deleteFile(fileUrl,true);
					OSSClientFactory.deleteFile(iv.getV_cover());
				}
				deleteFile(fileUrl,false);
				OSSClientFactory.deleteFile(fileUrl);
			}
			//删除点赞和评论
			imageVideoMapper.deleteAllPraise(iv.getId());
			imageVideoMapper.deleteAllComment(iv.getId());
			return AjaxMsg.newSuccess().addMessage("删除成功");
		}
		return AjaxMsg.newError().addData("errorMsg", "操作失败");
	}

	private void deleteFile(String url,boolean flag) {
		String[] video_format = { "asx", "asf", "mpg", "wmv", "3gp", "mp4", "mov", "avi", "flv", "x-ms-wmv","jpg" };
		if(flag){
			for (String ext : video_format) {
				String imagePath = url.substring(0,url.lastIndexOf("."))+"."+ext;
				File dest = new File(fileRepository.getRealPath(imagePath));
				if (dest.exists()) {
					dest.delete();
				}
			}
		}else{
			File dest = new File(fileRepository.getRealPath(url));
			if (dest.exists()) {
				dest.delete();
			}
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadAllVideos(Map<String, Object> maps,PageModel pageModel) {
		List<Map<String,Object>> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps==null)maps=Maps.newHashMap();
		count = imageVideoMapper.loadAllVideosCount(maps);
		pageModel.setTotalCount(count);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		datas = imageVideoMapper.loadAllVideos(maps);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg saveImageVideoComments(Map<String, Object> maps) {
		if(maps==null)return AjaxMsg.newError();
		maps.put("id", UUIDGenerator.getUUID());
		imageVideoMapper.saveImageVideoComments(maps);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updateImageVideoClickCount(Map<String, Object> maps) {
		if(maps==null)return AjaxMsg.newError();
		imageVideoMapper.updateImageVideoClickCount(maps);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg queryComments(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = queryCommentsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = imageVideoMapper.queryComments(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int queryCommentsCount(Map<String, Object> params) {
		return imageVideoMapper.queryCommentsCount(params);
	}
	
	@Override
	public List<Map<String, Object>> queryPraise(Map<String, Object> params) {
		return imageVideoMapper.queryPraise(params);
	}
	
	@Override
	public List<String> praiseCount(Map<String, Object> params) {
		return imageVideoMapper.praiseCount(params);
	}

	@Override
	public AjaxMsg updatePraise(Map<String, Object> params) {
		String state = params.get("p_state")!=null?params.get("p_state").toString():"";
		String iv_id = params.get("iv_id")!=null?params.get("iv_id").toString():"";
		if(StringUtils.isNotBlank(state)){
			List<Map<String, Object>> praise = imageVideoMapper.queryPraise(params);
			List<String> praises = imageVideoMapper.praiseCount(params);
			int num = 0;
			int count = "1".equals(state)?Integer.parseInt(praises.get(0)):Integer.parseInt(praises.get(1));
			int flag = 1;
			if(praise!=null&&praise.size()>0){
				num = imageVideoMapper.deletePraise(params);
				count = count>0?count-1:0;
				flag = 0;
			}else{
				params.put("id", UUIDGenerator.getUUID());
				num = imageVideoMapper.savePraise(params);
				count = count+1;
			}
			if("1".equals(state)){
				params.put("praise", String.valueOf(count));
			}else{
				params.put("unpraise", String.valueOf(count));
			}
			imageVideoMapper.updateImageVideoClickCount(params);
			if(num>0){
				return AjaxMsg.newSuccess().addData("praiseCount", count).addData("flag", flag);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryIVsLeagueComments(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = imageVideoLeagueMapper.loadAllIvCommentsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = imageVideoLeagueMapper.loadAllIvComments(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public ImageVideo getImageById(String id) {
		return imageVideoMapper.getImageById(id);
	}

	@Override
	public ImageVideo getVideoById(String id) {
		return imageVideoMapper.getVideoById(id);
	}

	@Override
	public AjaxMsg queryViews(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = imageVideoMapper.queryViewsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = imageVideoMapper.queryViews(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public boolean uploadFile2OSS(String ivId,String type,String filePath,String key) throws Exception {
		while(true){
		    try{
		    	taskExecutor.execute(new OSSUploadFile(ivId,type,filePath,key));
		        break;
		    }catch(TaskRejectedException e){
		        try{
		            Thread.sleep(500);
		        }catch(Exception e2){}
		    }
		}
		return true;
	}
	

	@Override
	public void updateImgOrVideo2OSS(String ivId, String type,File file) {
		imageVideoMapper.updateImgOrVideo2OSS(ivId, type);
		String[] video_format = { "asx", "asf", "mpg", "wmv", "3gp", "mp4", "mov", "avi", "flv", "x-ms-wmv","jpg" };
		String suffix = file.getName().substring(file.getName().lastIndexOf(".")+1);
		if("video".equals(type)&&!"jpg".equals(suffix)){
			String path = file.getPath();
			for (String ext : video_format) {
				String imagePath = path.substring(0,path.lastIndexOf("."))+"."+ext;
				File dest = new File(imagePath);
				if (dest.exists()) {
					dest.delete();
				}
			}
		}else{
			if (file.exists()) {
				file.delete();
			}
		}
	}

}
