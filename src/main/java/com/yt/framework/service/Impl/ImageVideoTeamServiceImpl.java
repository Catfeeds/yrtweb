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
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.ImageVideoTeam;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.ImageVideoTeamService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.ImageUtils;

@Service(value="imageVideoTeamService")
public class ImageVideoTeamServiceImpl extends BaseServiceImpl<ImageVideoTeam> implements ImageVideoTeamService{
	
	protected static Logger logger = LogManager.getLogger(ImageVideoTeamServiceImpl.class);
	
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;

	@Override
	public AjaxMsg searchImageVideos(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = searchImageVideosCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = imageVideoTeamMapper.searchImageVideos(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int searchImageVideosCount(Map<String, Object> params) {
		return imageVideoTeamMapper.searchImageVideosCount(params);
	}

	@Override
	public AjaxMsg saveImgOrVideos(ImageVideoTeam imageVideo, String images) {
		String[] imgs = parseImages(images);
		if(imgs!=null){
			for (String img : imgs) {
				if(StringUtils.isNotBlank(img.trim())){
					if(imageVideo.getType()==2)
						imageVideo.setV_cover(img.substring(0,img.lastIndexOf("."))+".jpg");
						imageVideo.setSrc(img);
						imageVideo.setId(UUIDGenerator.getUUID());
					imageVideoTeamMapper.save(imageVideo);
				}
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
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
	public AjaxMsg deleteFile(String id, String type) {
		if(id!=null&&StringUtils.isNotBlank(type)){
			ImageVideoTeam iv = imageVideoTeamMapper.getEntityById(id);
			String fileUrl = iv.getSrc();
			imageVideoTeamMapper.delete(iv.getId());
			String ext = fileUrl.substring(fileUrl.lastIndexOf(".")+1);
			if(ImageUtils.isValidVideoExt(ext)){
				String imagePath = fileUrl.substring(0,fileUrl.lastIndexOf("."))+".jpg";
				deleteFile(imagePath);
			}
			deleteFile(fileUrl);
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError().addData("errorMsg", "操作失败");
	}
	private void deleteFile(String url) {
		File dest = new File(fileRepository.getRealPath(url));
		if (dest.exists()) {
			dest.delete();
		}
	}

	@Override
	public AjaxMsg teamRestCount(String teamId, String type) {
		try {
			TeamInfo team = teamInfoMapper.getEntityById(teamId);
			if(team!=null){
				int count = 0;
				int ivType = 1;
				if("image".equals(type)){
					count = team.getImage_count();
				}else{
					count = team.getVideo_count();
					ivType = 2;
				}
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("team_id", team.getId());
				params.put("type", ivType);
				int totalCount = searchImageVideosCount(params);
				Map<String, Object> obj = new HashMap<String,Object>();
				obj.put("count", count);
				obj.put("restCount", (count-totalCount));
				return AjaxMsg.newSuccess().addData("data", obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg updateShowCenter(String teamId, String id, String type, String state) {
		String msg = "";
		try {
			if("cancel".equals(state)){
				ImageVideoTeam iv = imageVideoTeamMapper.getEntityById(id);
				iv.setIf_show(2);
				imageVideoTeamMapper.update(iv);
			}else if("sure".equals(state)){
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("team_id", teamId);
				params.put("type", type);
				int totalCount = searchImageVideosCount(params);
				if(totalCount<5){
					ImageVideoTeam ivObj = imageVideoTeamMapper.getEntityById(id);
					ivObj.setIf_show(1);
					imageVideoTeamMapper.update(ivObj);
				}else{
					msg = "俱乐部中最多只能展示 5 张图片";
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

}
