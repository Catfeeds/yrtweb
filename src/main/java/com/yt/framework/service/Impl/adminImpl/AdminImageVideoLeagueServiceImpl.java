package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.yt.framework.mapper.ImageVideoMapper;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.ImageVideoLeague;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.admin.AdminImageVideoLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.oss.OSSClientFactory;

@Service(value="adminImageVideoLeagueService")
public class AdminImageVideoLeagueServiceImpl extends BaseAdminServiceImpl<ImageVideoLeague> implements AdminImageVideoLeagueService {
	
	protected static Logger logger = LogManager.getLogger(AdminImageVideoLeagueServiceImpl.class);

	@Autowired
	protected ImageVideoMapper imageVideoMapper;
	@Autowired
	private ImageVideoService imageVideoService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	@Override
	public List<Map<String, Object>> queryTeamInfoByIvid(String ivid) {
		return imageVideoLeagueMapper.queryTeamInfoByIvid(ivid);
	}

	@Override
	public AjaxMsg saveIvTeam(String ivid, List<Map<String, Object>> ivTeams) {
		imageVideoLeagueMapper.deleteIvTeam(ivid);
		if(ivTeams!=null&&ivTeams.size()>0){
			for (Map<String, Object> map : ivTeams) {
				imageVideoLeagueMapper.saveIvTeam(map);
			}
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updateLeague(ImageVideo ivleagues) throws Exception {
		String type = ivleagues.getType();
		ImageVideo old = null;
		if("video".equals(type)){
			old = imageVideoService.getVideoById(ivleagues.getId());
		}else{
			old = imageVideoService.getImageById(ivleagues.getId());
		}
		if(old == null){
			throw new RuntimeException("图片或视频 null AdminImageVideoLeagueServiceImpl updateLeague");
		}
		String old_src = old.getF_src();
		String src = ivleagues.getF_src();
		ivleagues.setTo_oss(2);
		imageVideoMapper.update(ivleagues);
		if(!src.equals(old_src)){
			//删除old
			if("video".equals(type)){
				OSSClientFactory.deleteFile(ivleagues.getV_cover());
			}
			OSSClientFactory.deleteFile(old_src);
			//添加新图片
			if("video".equals(type)){
				String new_v_cover = src.substring(0,src.lastIndexOf("."))+".jpg";
				imageVideoService.uploadFile2OSS(ivleagues.getId(),ivleagues.getType(),fileRepository.getRealPath(new_v_cover),new_v_cover);
			}
			imageVideoService.uploadFile2OSS(ivleagues.getId(),ivleagues.getType(),fileRepository.getRealPath(src),src);
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg saveOrUpdateIv(ImageVideo ivleagues, String images,String teamIds) throws Exception {
		AjaxMsg msg = AjaxMsg.newError();
		boolean isSave = false;
		String if_send = ivleagues.getIf_send();//是否发送给俱乐部
		String lid = ivleagues.getUser_id();
		String ivleagueId = null;
		if(StringUtils.isNotBlank(ivleagues.getId())){
			ivleagueId = ivleagues.getId();
			ivleagues.setF_src(images);
			msg = updateLeague(ivleagues);
		}else{
			isSave = true;
			/*ivleagues.setId(ivleagueId);	
			msg = imageVideoService.saveImgOrVideos(ivleagues, images);*/
			String[] imgs = parseImages(images);
			if(imgs!=null){
				for (String img : imgs) {
					if(StringUtils.isNotBlank(img.trim())){
						ivleagues.setF_src(img);
						ivleagueId = UUIDGenerator.getUUID();
						ivleagues.setId(ivleagueId);
						ivleagues.setUser_id(lid);
						ivleagues.setRole_type(SystemEnum.IMAGE.LEAGUE.toString());
						if("video".equals(ivleagues.getType())){
							ivleagues.setV_cover(img.substring(0,img.lastIndexOf("."))+".jpg");
							imageVideoService.saveVideo(ivleagues);
							imageVideoService.uploadFile2OSS(ivleagues.getId(),ivleagues.getType(),fileRepository.getRealPath(ivleagues.getV_cover()),ivleagues.getV_cover());
						}else{
							imageVideoService.saveImage(ivleagues);
						}
						imageVideoService.uploadFile2OSS(ivleagues.getId(),ivleagues.getType(),fileRepository.getRealPath(img),img);
						//判断是否发送给俱乐部
						if("1".equals(if_send)&&StringUtils.isNotBlank(teamIds)){
							String tids[] = teamIds.split(",");
							if(tids!=null&&tids.length>0){
								ImageVideo ivTeam = ivleagues;
								ivTeam.setAdd_iv_id(ivleagueId);
								ivTeam.setRole_type(SystemEnum.IMAGE.TEAM.toString());
								for (String tid : tids) {
									if(StringUtils.isNotBlank(tid)){
										ivTeam.setId(UUIDGenerator.getUUID());
										ivTeam.setUser_id(tid);
										if("video".equals(ivTeam.getType())){
											ivTeam.setV_cover(img.substring(0,img.lastIndexOf("."))+".jpg");
											imageVideoService.saveVideo(ivTeam);
											imageVideoService.uploadFile2OSS(ivTeam.getId(),ivTeam.getType(),fileRepository.getRealPath(ivTeam.getV_cover()),ivTeam.getV_cover());
										}else{
											imageVideoService.saveImage(ivTeam);
										}
										imageVideoService.uploadFile2OSS(ivTeam.getId(),ivTeam.getType(),fileRepository.getRealPath(img),img);
									}
								}
							}
						}
						//将关联俱乐部保存到图片视频和俱乐部中间表中
						String tids[] = StringUtils.isNotBlank(teamIds)?teamIds.split(","):null;
						List<Map<String, Object>> ivteams = new ArrayList<Map<String,Object>>();
						if(tids!=null&&tids.length>0){
							for (String tid : tids) {
								Map<String, Object> ivteam = new HashMap<String,Object>();
								ivteam.put("id", UUIDGenerator.getUUID());
								ivteam.put("a_iv_id", ivleagueId);
								ivteam.put("teaminfo_id", tid);
								ivteams.add(ivteam);
							}
						}
						msg = saveIvTeam(ivleagueId, ivteams);
					}
				}
			}
		}
		if(!isSave){
			//查询以前关联俱乐部
			List<String> ivTids = imageVideoLeagueMapper.queryIvTids(ivleagueId);
			List<String> ss1 = new ArrayList<String>();
			ss1.addAll(ivTids);
			List<String> ss3 = new ArrayList<String>();
			ss3.addAll(ivTids);
			if(ivTids!=null&&ivTids.size()>0){
				if("1".equals(if_send)&&StringUtils.isNotBlank(teamIds)){
					String tids[] = teamIds.split(",");
					List<String> ss2 = Lists.newArrayList(tids);
					List<String> ss4 = new ArrayList<String>();
					ss4.addAll(ss2);
					ivTids.removeAll(ss2);//缺少的
					ss2.removeAll(ss1);//多出来的
					ss3.retainAll(ss4);//相同的
					if(ivTids!=null&&ivTids.size()>0){
						for (String tid : ivTids) {
							imageVideoLeagueMapper.deleteSImage(ivleagueId,tid);
							imageVideoLeagueMapper.deleteSVideo(ivleagueId,tid);
						}
					}
					if(ss2!=null&&ss2.size()>0){
						ImageVideo ivTeam = ivleagues;
						ivTeam.setAdd_iv_id(ivleagueId);
						ivTeam.setRole_type(SystemEnum.IMAGE.TEAM.toString());
						for (String tid : ss2) {
							if(StringUtils.isNotBlank(tid)){
								ivTeam.setUser_id(tid);
								imageVideoService.saveImgOrVideos(ivTeam, images);
							}
						}
					}
					if(ss3!=null&&ss3.size()>0){
						ImageVideo ivTeam = ivleagues;
						ivTeam.setAdd_iv_id(ivleagueId);
						ivTeam.setRole_type(SystemEnum.IMAGE.TEAM.toString());
						for (String tid : ss3) {
							imageVideoLeagueMapper.deleteSImage(ivleagueId,tid);
							imageVideoLeagueMapper.deleteSVideo(ivleagueId,tid);
							if(StringUtils.isNotBlank(tid)){
								ivTeam.setUser_id(tid);
								imageVideoService.saveImgOrVideos(ivTeam, images);
							}
						}
					}
				}else{
					for (String tid: ivTids) {
						imageVideoLeagueMapper.deleteSImage(ivleagueId,tid);
						imageVideoLeagueMapper.deleteSVideo(ivleagueId,tid);
					}
				}
			}else{
				if("1".equals(if_send)&&StringUtils.isNotBlank(teamIds)){
					String tids[] = teamIds.split(",");
					if(tids!=null&&tids.length>0){
						ImageVideo ivTeam = ivleagues;
						ivTeam.setAdd_iv_id(ivleagueId);
						ivTeam.setRole_type(SystemEnum.IMAGE.TEAM.toString());
						for (String tid : tids) {
							if(StringUtils.isNotBlank(tid)){
								//ivTeam.setId(UUIDGenerator.getUUID());	
								ivTeam.setUser_id(tid);
								imageVideoService.saveImgOrVideos(ivTeam, images);
							}
						}
					}
				}
			}
			if(msg.isSuccess()){
				String tids[] = StringUtils.isNotBlank(teamIds)?teamIds.split(","):null;
				List<Map<String, Object>> ivteams = new ArrayList<Map<String,Object>>();
				if(tids!=null&&tids.length>0){
					for (String tid : tids) {
						Map<String, Object> ivteam = new HashMap<String,Object>();
						ivteam.put("id", UUIDGenerator.getUUID());
						ivteam.put("a_iv_id", ivleagueId);
						ivteam.put("teaminfo_id", tid);
						ivteams.add(ivteam);
					}
				}
				msg = saveIvTeam(ivleagueId, ivteams);
			}
		}
		
		return msg;
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
		AjaxMsg msg = imageVideoService.deleteFile(id, type);
		imageVideoLeagueMapper.deleteIvTeam(id);
		imageVideoLeagueMapper.deleteSImage(id,null);
		imageVideoLeagueMapper.deleteSVideo(id,null);
		return msg;
	}
	
	public static void main(String[] args) {
		String[] s1 = new String[]{"1","2","3"}; 
		String[] s2 = new String[]{"4","5","3","1"};
		List<String> ss1 = Lists.newArrayList(s1);
		List<String> ss2 = Lists.newArrayList(s2);
//		ss1.removeAll(ss2);
//		ss2.removeAll(m1);
		ss1.retainAll(ss2);
		System.out.println(ss1);
		
	}

}
