package com.yt.framework.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.Product;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.ProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.gson.JSONUtils;

/**
 * 后台管理
 * 
 * @author GL
 * @date 2015年7月25日 上午11:30:32
 */
@Controller
@RequestMapping(value = "/admin/product")
public class AdminProductController {
	private static Logger logger = LogManager.getLogger(AdminProductController.class);

	@Autowired
	private ProductService productService;
	@Autowired
	private MessageResourceService messageResourceService;

	@RequestMapping(value = "")
	public String main(HttpServletRequest request) {
		PageModel<Product> pageModel =new PageModel<>();
		Map<String, Object> map = new HashMap<String,Object>();
		AjaxMsg msg= productService.queryForPage(map , pageModel);
		if(msg.isSuccess()){
			request.setAttribute("page", msg.getData("page"));
		}
		return "admin/product/list";
	}
	
	@RequestMapping(value="productForm")
	public String productForm(HttpServletRequest request){
		String id = request.getParameter("id");
		Product o = productService.getEntityById(id);
		request.setAttribute("o", o);
		return "admin/product/form"; 
	}
	
	@RequestMapping(value="updateProduct")
	@ResponseBody
	public String updateProduct(HttpServletRequest request,Product p) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			Product o = productService.getEntityById(p.getId());
			if (null != o) {
				o.setCharm_value(p.getCharm_value());
				o.setImage_src(p.getImage_src());
				o.setP_code(p.getP_code());
				o.setP_name(p.getP_name());
				o.setP_price(p.getP_price());
				o.setStatus(p.getStatus());
			}
			msg = productService.update(o);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	} 

	@RequestMapping(value="saveProduct")
	@ResponseBody
	public String saveProduct(HttpServletRequest request,Product p) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			p.setCreate_time(new Date());
			p.setP_type(1);
			p.setId(UUIDGenerator.getUUID());
			msg = productService.save(p);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	} 
	@RequestMapping(value="productList")
	@ResponseBody
	public String productList(HttpServletRequest request, HttpSession session,@RequestBody String pjson) {
		Map<String, String> map = JSONUtils.json2Map(pjson);
		String currentPage = map.get("currentPage");
		PageModel pageModel = new PageModel();
		pageModel.setCurrentPage(JSONUtils.toInt(currentPage));
		Map<String,Object> maps = Maps.newHashMap();
		AjaxMsg msg = productService.queryForPage(maps, pageModel);
		String retJson = "{}";
		if(msg.isSuccess()){
			pageModel = (PageModel) msg.getData("page");
			retJson = JSONUtils.bean2json(pageModel);
		}
		return retJson;
	}
}
