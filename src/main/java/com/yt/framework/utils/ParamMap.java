package com.yt.framework.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ParamMap {
	
	private static Map<String, List<Map<String, Object>>> paramMap = null;

	public static Map<String, List<Map<String, Object>>> getMap() {
		return paramMap;
	}
	
	public static void setMap(Map<String, List<Map<String, Object>>> map) {
		if(null == paramMap) {
			newMap();
		}
		paramMap = map;
	}

	public static Map<String, List<Map<String, Object>>> newMap() {
		paramMap = null;
		paramMap = new HashMap<String, List<Map<String, Object>>>();
		return paramMap;
	}

	public static List<Map<String, Object>> getParam(String key) {
		if (paramMap == null) {
			return null;
		}
		return paramMap.get(key);
	}
	
	public static String getParam(String key,String value){
		List<Map<String, Object>> params = getParam(key);
		if(params!=null&&params.size()>0){
			for (Map<String, Object> param : params) {
				String dict_value = param.get("dict_value")!=null?param.get("dict_value").toString():"";
				if(value.equals(dict_value)){
					return param.get("dict_value_desc")!=null?param.get("dict_value_desc").toString():"";
				}
			}
		}
		return "";
	}
}
