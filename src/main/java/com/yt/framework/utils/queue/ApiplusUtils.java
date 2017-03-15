package com.yt.framework.utils.queue;

import java.util.List;
import java.util.Map;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.yt.framework.utils.Common;
import com.yt.framework.utils.gson.JSONUtils;

public class ApiplusUtils {

	public static void main(String[] args) {
		System.out.println(ApiplusUtils.getCQssc_last());
	}
	

	public static String getCQssc_last() {
		ApiplusVO vo = ApiplusUtils.getCQssc();
		List<Map<String, String>> ls = vo.getData();
		String retcode = "00000";
		for(Map<String, String> map:ls){
			String opencode = map.get("opencode");
			if(Common.isNotEmpty(opencode)){
				retcode=opencode.replaceAll(",", "");
				break;
			}
		}
		return retcode;
	}
	
	public static ApiplusVO getCQssc() {
		StringBuilder retTxt = new StringBuilder();
		CloseableHttpResponse response = null;
		CloseableHttpClient client = null;
		try {
			String reqUrl = "http://f.apiplus.cn/cqssc.json";
			HttpGet httpPost = new HttpGet(reqUrl);
			httpPost.setHeader("Content-Type", "text/json;charset=ISO-8859-1");
			client = HttpClients.createDefault();
			response = client.execute(httpPost);
			byte[] x = EntityUtils.toByteArray(response.getEntity());
			retTxt.append(new String(x, "utf-8"));
			
			return JSONUtils.json2bean(retTxt.toString(), ApiplusVO.class);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("ret=" + retTxt.toString());
		}
		
		return null;
	}
}
