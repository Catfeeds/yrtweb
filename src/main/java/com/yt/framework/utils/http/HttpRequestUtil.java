package com.yt.framework.utils.http;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;
import java.net.URLEncoder;
import java.net.Proxy.Type;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;
import java.util.zip.GZIPInputStream;
import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.common.base.Strings;

public class HttpRequestUtil {
	
	static Logger logger = LogManager.getLogger(HttpRequestUtil.class
			.getName());
	private static final int connectTimeOut = 5000;
	private static final int readTimeOut = 10000;
	private static final String requestEncoding = "UTF-8";
	
	/**
	 * 
	 * @param urlStr
	 *            访问地址
	 * @param params
	 *            参数信息 以"&" 隔开每个参数的值 无参数则设置为null
	 * @param isGet
	 *            是否是Get 的请求方式
	 * @param ctMap
	 *            contentType 的map集合 没有则设置为null
	 * @param ck
	 *            cookie提交的参数信息 没有则设置为null
	 * @param encoding
	 *            返回内容的编码
	 * @param _proxy
	 *            代理设置，如果不使用代理则设置为null
	 * @param filePath
	 * 			      文件路径 需要上传的文件路径，该文件路径为绝对路径，不需要上传文件时设置为null
	 * @param boundary 
	 * 			  文件流 分割符，用于识别文件的起始位置和结束位置  模拟 form-data 进行文件上传
	 * @return 返回获取的URL返回信息
	 */
	public static String executeRquest(String urlStr, String params,
			boolean isGet, Map<String, String> ctMap, Map<String, String> ck,
			String encoding, HttpProxy _proxy,String filePath,String boundary){
		String retStr = "";
		try{
			urlStr += isGet ? (params != null ? ("?" + params) : "") : "";
			URL url = new URL(urlStr);
			
			Proxy proxy = null;
			if (_proxy != null) {
				InetAddress id = InetAddress.getByName(_proxy.getHost_url());
				InetSocketAddress socket = new InetSocketAddress(id,
						Integer.parseInt(_proxy.getPort()));
				proxy = new Proxy(Type.HTTP, socket);
			}
			
			HttpURLConnection conn = null;
			if (proxy != null) {
				conn = (HttpURLConnection) url.openConnection(proxy);
			} else {
				conn = (HttpURLConnection) url.openConnection();
			}
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setConnectTimeout(5000);  
			conn.setReadTimeout(30000);  
			conn.setRequestMethod(isGet ? "GET" : "POST");
			/*contentType*/
			if (ctMap != null) {
				for (String key : ctMap.keySet()) {
					if (ctMap.get(key) != null) {
						conn.setRequestProperty(key, ctMap.get(key));
					}
				}
			}
			
			/*Cookie*/
			if (ck != null) {
				String tmp = "";
				for (String key : ck.keySet()) {
					if ("".equals(tmp)) {
						tmp = key + "=" + ck.get(key);
					} else {
						tmp = ";" + key + "=" + ck.get(key);
					}
				}
				if (tmp != null && !"".equals(tmp)) {
					conn.setRequestProperty("Cookie", tmp);
				}
			}
			
			conn.connect();
			//上传文件
			File file = StringUtils.isNotBlank(filePath)?new File(filePath):null;
			
			DataOutputStream out = new DataOutputStream(conn.getOutputStream());
			out.write((isGet?"":Strings.nullToEmpty(params)).getBytes());
			out.flush();
			
			if(file != null){
				if(file.exists()){
					DataInputStream in = new DataInputStream(new FileInputStream(file));
					String contentType = new MimetypesFileTypeMap().getContentType(file);
					System.out.println("contentType:"+contentType);
					StringBuilder form_header = new StringBuilder();
					form_header.append("--" + boundary+"\r\n");
					form_header.append("Content-Disposition: form-data; name=\"media\"; filename=\"" + file.getName() + "\"; filelength=\""+in.available()+"\"");
					form_header.append("\r\n");
					form_header.append("Content-Type: "+contentType);
					form_header.append("\r\n\r\n");
					out.write(form_header.toString().getBytes());
					out.flush();
					
					byte[] bytes = new byte[1024];
					int len =0;
					while((len = in.read(bytes)) != -1){
						out.write(bytes, 0, len);
						out.flush();
						len = 0;
					}
					
					out.write(("\r\n--" + boundary + "--\r\n").getBytes());
					out.flush();
					
					in.close();
					out.flush();
					out.close();
				}else{
					throw new FileNotFoundException("file：\""+filePath+"\" is not exist!");
				}
			}
			out.flush();
			out.close();
			
			if (conn.getResponseCode() == 200) {
				String content_encoding = conn.getHeaderField("Content-Encoding");// 相应的内容的类型
				BufferedReader reader = null;
				if (null != content_encoding
						&& Pattern.compile("^.{0,}(gzip){1}.{0,}",Pattern.UNICODE_CASE).matcher(content_encoding).matches()) {
					reader = new BufferedReader(
							new InputStreamReader(
									new GZIPInputStream(conn.getInputStream()), encoding));
				} else {
					reader = new BufferedReader(
							new InputStreamReader(conn.getInputStream(), encoding));
				}
				StringBuilder content = new StringBuilder();
				String line = "";
				while ((line = reader.readLine()) != null) {
					content.append(line);
				}
				reader.close();
				retStr = content != null ? content.toString() : "";
			} else if (conn.getResponseCode() == 401) {
				System.out.println("----------------------访问授权失败");
			} else {
				System.out.println("----------------------未知返回状态！");
			}
			conn.disconnect();
		}catch(Exception e){
			e.printStackTrace();
		}
		return retStr;
	}
	
	public static String doPost(String reqUrl, Map<String, String> parameters,
			String recvEncoding) {
		HttpURLConnection url_con = null;
		String responseContent = null;
		String vchartset = recvEncoding == "" ? requestEncoding
				: recvEncoding;
		try {
			StringBuffer params = new StringBuffer();
			for (Iterator<?> iter = parameters.entrySet().iterator(); iter
					.hasNext();) {
				Entry<?, ?> element = (Entry<?, ?>) iter.next();
				params.append(element.getKey().toString());
				params.append("=");
				params.append(URLEncoder.encode(element.getValue().toString(),
						vchartset));
				params.append("&");
			}

			if (params.length() > 0) {
				params = params.deleteCharAt(params.length() - 1);
			}

			URL url = new URL(reqUrl);
			url_con = (HttpURLConnection) url.openConnection();
			url_con.setRequestMethod("POST");
			url_con.setConnectTimeout(connectTimeOut);
			url_con.setReadTimeout(readTimeOut);
			url_con.setDoOutput(true);
			byte[] b = params.toString().getBytes();
			url_con.getOutputStream().write(b, 0, b.length);
			url_con.getOutputStream().flush();
			url_con.getOutputStream().close();

			InputStream in = url_con.getInputStream();
			byte[] echo = new byte[10 * 1024];
			int len = in.read(echo);
			responseContent = (new String(echo, 0, len)).trim();
			int code = url_con.getResponseCode();
			if (code != 200) {
				responseContent = "ERROR" + code;
			}

		} catch (IOException e) {
			logger.error(e.getLocalizedMessage(), e);
		} finally {
			if (url_con != null) {
				url_con.disconnect();
			}
		}
		return responseContent;
	}
	
	public static HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    } 
	
	public static Locale getLocale(){
		return RequestContextUtils.getLocaleResolver(getRequest()).resolveLocale(getRequest());
	}
	
}
