package com.yt.framework.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.WebUtils;

import com.google.common.collect.Maps;

/**
 * 公用工具类 获取请求IP 加减乘除 String转换double 当前时间格式化
 * 
 * @author bo.xie 2015年3月10日16:43:03
 */
public class Common {

	static Logger logger = LogManager.getLogger(Common.class.getName());

	// 默认除法运算精度
	private static final int DEF_DIV_SCALE = 10;

	/**
	 * 返回用户的IP地址
	 * 
	 * @param request
	 * @return
	 */
	public static String toIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 提供精确的减法运算。
	 * 
	 * @param v1
	 *            被减数
	 * @param v2
	 *            减数
	 * @return 两个参数的差
	 */
	public static double sub(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.subtract(b2).doubleValue();
	}

	/**
	 * 提供精确的加法运算。
	 * 
	 * @param v1
	 *            被加数
	 * @param v2
	 *            加数
	 * @return 两个参数的和
	 */
	public static double add(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.add(b2).doubleValue();
	}

	/**
	 * 提供精确的乘法运算。
	 * 
	 * @param v1
	 *            被乘数
	 * @param v2
	 *            乘数
	 * @return 两个参数的积
	 */
	public static double mul(double v1, double v2) {
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.multiply(b2).doubleValue();
	}

	/**
	 * 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
	 * 
	 * @param v1
	 *            被除数
	 * @param v2
	 *            除数
	 * @return 两个参数的商
	 */
	public static double div(double v1, double v2) {
		return div(v1, v2, DEF_DIV_SCALE);
	}

	/**
	 * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
	 * 
	 * @param v1
	 *            被除数
	 * @param v2
	 *            除数
	 * @param scale
	 *            表示表示需要精确到小数点以后几位。
	 * @return 两个参数的商
	 */
	public static double div(double v1, double v2, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException("The scale must be a positive integer or zero");
		}
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * String转换double
	 * 
	 * @param string
	 * @return double
	 */
	public static double convertSourData(String dataStr) throws Exception {
		if (dataStr != null && !"".equals(dataStr)) {
			return Double.valueOf(dataStr);
		}
		throw new NumberFormatException("convert error!");
	}

	/**
	 * 返回当前时间 格式：yyyy-MM-dd hh:mm:ss
	 * 
	 * @return String
	 */
	public static String formatDate() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return format1.format(new Date());
	}
	
	public static String formatDate24H(Date d) {
		String day = "";
		String hh=formatDate(d,"HH:mm");
		int di = getBetweenDay(d,new Date());
		if(di==0){
			day = "今天 ";
		}else if(di==1){
			day="昨天 ";
		}else if(di==2){
			day="前天 ";
		}else if(di>=3){
			day=formatDate(d,"MM-dd ");
		}
		return day+hh;
	}

	/**
	 * 返回当前时间 格式：yyyy-MM-dd
	 * 
	 * @return String
	 */
	public static String formatDateY() {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		return format1.format(new Date());
	}

	/**
	 * 时间格式化
	 * 
	 * @param date
	 *            需要格式化的时间
	 * @param pattern
	 *            格式
	 * @return
	 */
	public static String formatDate(Date date, String pattern) {
		return new SimpleDateFormat(pattern).format(date);
	}

	/**
	 * 时间字符串解析成对象
	 *@param date_str eg:2012-02-12
	 *@param pattern eg:yyyy-MM-dd
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-8下午3:50:56
	 */
	public static Date parseStringDate(String date_str,String pattern){
		try {
			Date date = new SimpleDateFormat(pattern).parse(date_str);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 比较时间大小
	 *@param date1 yyyy-MM-dd 开始时间
	 *@param date2 yyyy-MM-dd 结束时间
	 *@return boolean 开始时间小于结束时间返回 true
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-18上午10:14:18
	 */
	public static Boolean compareDates(Date date1,Date date2){
		Boolean flag = Boolean.FALSE;
		if(date1.getTime()<date2.getTime()){
			flag = Boolean.TRUE;
		}
		return flag;
	}
	
	/**
	 * 获取servletContext
	 * 
	 * @author xiebo 2014年11月20日15:46:02
	 * @return
	 */
	public static ServletContext getServletContext() {
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		return webApplicationContext.getServletContext();
	}

	/**
	 * 获取HttpServletRequest
	 * 
	 * @return
	 */
	public static HttpServletRequest getServletRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		return request;
	}

	/**
	 * 获取当前session 值
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 * @return
	 */
	public static Object getCurrentSessionValue(HttpServletRequest request, String sessionName) {

		return WebUtils.getSessionAttribute(request, sessionName);
	}

	/**
	 * sessison中注入值
	 * 
	 * @param key
	 * @param value
	 */
	public static void setSessionValue(String key, Object value) {
		getServletRequest().getSession(true).setAttribute(key, value);
	}

	/**
	 * 清除session中的值
	 * 
	 * @param key
	 * @autor bo.xie
	 * @date2015-7-23下午6:25:38
	 */
	public static void removeSessionValue(String key) {
		getServletRequest().getSession(true).removeAttribute(key);
	}

	/**
	 * 特定字符串格式转Map
	 * 
	 * @param str
	 *            format:id=null, username=张三, password=null
	 * @return
	 */
	public static Map<String, Object> StringFormatArray(String str) {
		Map<String, Object> map = Maps.newHashMap();
		if (StringUtils.isNotBlank(str)) {
			String[] arr = str.split(",");
			for (String s : arr) {
				String[] v = s.split(",");
				String[] kv = v[0].split("=");
				map.put(kv[0], kv[1]);
			}
		}
		return map;
	}

	/**
	 * 获取验证码，并注入到session中
	 * 
	 * @return
	 */
	public static String getRandomNum() {
		int num = getRandomNum6();
		setSessionValue("CODENUM", num);
		return String.valueOf(num);
	}

	/**
	 * 随机生成6位数
	 * 
	 * @return
	 */
	public static int getRandomNum6() {
		int max = 999999;
		int min = 100000;
		Random random = new Random();
		return random.nextInt(max) % (max - min + 1) + min;
	}

	/**
	 * 随机生成3位数
	 * 
	 * @return
	 */
	public static int getRandomNum3() {
		int max = 999;
		int min = 100;
		Random random = new Random();
		return random.nextInt(max) % (max - min + 1) + min;
	}
	/**
	 * 随机生成4位数
	 * 
	 * @return
	 */
	public static int getRandomNum4() {
		int max = 9999;
		int min = 1000;
		Random random = new Random();
		return random.nextInt(max) % (max - min + 1) + min;
	}

	/**
	 * URLDecoder
	 * 
	 * @param s
	 * @return
	 */
	public static String URLdecode(String s) {
		String retStr = null;
		try {
			retStr = s.replaceAll("%", "%25");
			retStr = URLDecoder.decode(retStr, "utf-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return retStr;
	}

	/**
	 * 获取Cookie
	 * 
	 * <p>
	 * Title: getCookie
	 * </p>
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @author YJH
	 * @date 2014年9月18日
	 * @param request
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String getCookie(HttpServletRequest request, String key) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie c = cookies[i];
				if (c.getName().equalsIgnoreCase(key)) {
					return c.getValue();
				}
			}
		}
		return null;
	}

	public static String formatDateHHMM(int time) {
		if (time >= 120)
			time += 90;
		int hh = 9 + time / 60;
		int mm = 30 + time % 60;
		String HH = "", MM = "";
		if (mm >= 60) {
			hh++;
			mm -= 60;
		}

		if (hh < 10)
			HH = "0" + hh;
		else
			HH = "" + hh;
		if (mm < 10)
			MM = "0" + mm;
		else
			MM = "" + mm;

		return HH + ":" + MM;
	}

	public static String formatDateIntToHHMM(int time) {
		int hh = time / 60;
		int mm = time % 60;
		String HH = "", MM = "";
		if (mm >= 60) {
			hh++;
			mm -= 60;
		}

		if (hh < 10)
			HH = "0" + hh;
		else
			HH = "" + hh;
		if (mm < 10)
			MM = "0" + mm;
		else
			MM = "" + mm;

		return HH + ":" + MM;
	}

	public static List<String> getFileLine(String filePath, String charset) {
		return getFileLine(new File(filePath), charset);
	}

	public static List<String> getFileLine(File filePath, String charset) {
		List<String> lines = new ArrayList<String>();

		InputStreamReader fr = null;
		try {
			if (isEmpty(charset))
				charset = "utf-8";
			fr = new InputStreamReader(new FileInputStream(filePath), charset);
			BufferedReader br = new BufferedReader(fr);
			String line = null;// br.readLine();
			while (br.ready()) {
				line = br.readLine();
				if (isEmpty(line))
					continue;
				lines.add(line);
			}
			br.close();
			fr.close();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return lines;
	}

	public static boolean isEmpty(Object obj) {
		if (obj == null)
			return true;

		if (obj instanceof String) {
			String str = (String) obj;
			return str.trim().length() == 0 || str.toLowerCase().equals("null");
		} else if (obj instanceof List) {
			List<?> ls = (List<?>) obj;
			return ls.size() == 0;
		} else if (obj instanceof Set) {
			Set<?> ls = (Set<?>) obj;
			return ls.size() == 0;
		} else if (obj instanceof Map) {
			Map<?, ?> ls = (Map<?, ?>) obj;
			return ls.size() == 0;
		} else if (obj instanceof String[]) {
			String[] ls = (String[]) obj;
			return ls.length == 0;
		} else if (obj instanceof Integer) {
			return (Integer) obj == 0;
		} else if (obj instanceof Object[]) {
			Object[] ls = (Object[]) obj;
			return ls.length == 0;
		}
		return false;
	}

	public static boolean isNotEmpty(Object objs) {
		return !isEmpty(objs);
	}
	public static String getString(Object objs) {
		if(!isEmpty(objs)){
			return objs.toString();
		}else{
			return "";
		}
	}
	/**
	 * 判断是否属于手机格式
	 * 
	 * @param mobiles
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-7-24上午11:57:47
	 */
	public static boolean isMobile(String mobiles) {
		Pattern p = Pattern.compile("^[1][3-8]+\\d{9}");
		Matcher m = p.matcher(mobiles);
		return m.matches();
	}

	/**
	 * UTF8 to GBK
	 * 
	 * <p>
	 * Title: convertUTF2GBK
	 * </p>
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @author YJH
	 * @date 2014年7月25日
	 * @param utf8Str
	 * @return
	 */
	public static String convertUTF2GBK(String utf8Str) {
		String GBK = "GBK";
		String UTF_8 = "UTF-8";
		String retStr = utf8Str;
		try {
			byte[] srcByte = utf8Str.getBytes(UTF_8);
			StringBuffer str = new StringBuffer();
			int len = srcByte.length;
			int char1, char2, char3;
			int count = 0;
			while (count < len) {
				char1 = (int) srcByte[count] & 0xff;
				switch (char1 >> 4) {
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
					count++;
					str.append((char) char1);
					break;
				case 12:
				case 13:
					count += 2;
					if (count > len) {
						break;
					}
					char2 = (int) srcByte[count - 1];
					if ((char2 & 0xC0) != 0x80) {
						break;
					}
					str.append((char) (((char1 & 0x1F) << 6) | (char2 & 0x3F)));
					break;
				case 14:

					count += 3;
					if (count > len) {
						UnsupportedEncodingException uee = new UnsupportedEncodingException();
						logger.error(uee.getLocalizedMessage(), uee);
					}
					char2 = (int) srcByte[count - 2];
					char3 = (int) srcByte[count - 1];
					if (((char2 & 0xC0) != 0x80) || ((char3 & 0xC0) != 0x80)) {
						break;
					}
					str.append((char) (((char1 & 0x0F) << 12) | ((char2 & 0x3F) << 6) | ((char3 & 0x3F) << 0)));
					break;
				default:
					break;
				}
			}
			retStr = new String(str.toString().getBytes(GBK), GBK);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}

		return retStr;
	}

	/**
	 * @Title: isEmail
	 * @Description: 判断是否为email格式
	 * @param @return
	 *            设定文件
	 * @return boolean 返回类型
	 * @throws @author
	 *             zjh
	 * @date:2015年7月27日下午6:12:09
	 */
	public static boolean isEmail(String email) {
		// 验证邮箱正则表达式
		String checkEmail = "^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$";
		Pattern p = Pattern.compile(checkEmail);
		Matcher m = p.matcher(email);
		return m.matches();
	}
	
	/**
	 * 隐藏手机或邮箱部分
	 *@param str
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-9下午6:49:25
	 */
	public static String hiddenPhoneOrEmail(String str){
		StringBuilder re_str = new StringBuilder();
		if(isMobile(str)){
			re_str.append(str.substring(0,3)).append("****").append(str.substring(str.length()-4, str.length()));
		}else if(isEmail(str)){
			int len = str.indexOf("@");
			re_str.append(str.substring(0, str.indexOf("@")-(len/2))).append("****")
				.append(str.substring(str.indexOf(".")+1, str.length()));
		}
		
		return re_str.toString();
	}

	/**
	 * @Title: contains
	 * @Description: 判断某个字符串是否存在于数组中
	 * @param @param
	 *            stringArray 原数组
	 * @param @param
	 *            source 查找的字符串
	 * @param @return
	 *            设定文件
	 * @return boolean 是否找到 返回类型
	 * @throws @author
	 *             zjh
	 * @date:2015年7月27日下午6:17:26
	 */
	public static boolean contains(String[] stringArray, String source) {
		// 转换为list
		List<String> tempList = Arrays.asList(stringArray);

		// 利用list的包含方法，进行判断
		if (tempList.contains(source)) {
			return true;
		}
		return false;
	}
	/**
	 * @Title: getSuffix 
	 * @Description: 获取文件名的后缀 
	 * @param @param fileName
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日下午3:05:31
	 */
	public static String getSuffix(String fileName) {
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		return suffix;
	}
	/**
	 * @Title: getSecurityCode 
	 * @Description: 生成指定长度的随机字符串 
	 * @param @param length 生成字符串的长度
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月3日下午3:57:51
	 */
	public static String getSecurityCode(int length){
		String base = "1234567890";
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {     
	        int number = random.nextInt(base.length());     
	        sb.append(base.charAt(number));     
	    }  
		return sb.toString();
	}
	
	/**
	 * 生成订单号
	 * @return
	 */
	public static String createOrderOSN() {
		//Integer uid = AuthSecurity.getCurrentUserID();
		String retValue = "Y"+formatDate(new Date(), "yyMMddHHmm")+getAutomaticNum();
		return retValue;
	}
	private static int orderNum=0;
	
	private synchronized static int getAutomaticNum(){
		orderNum++;
		return orderNum;
	}
	
	//字符串转16进制
	public static String toHexString(String s){
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < s.length(); i++) {
			int ch = (int)s.charAt(i);
				sb.append(Integer.toHexString(ch));
		}
		return sb.toString();
	}
	
	// 转化16进制编码为字符串
	public static String toStringHex(String s){
	byte[] baKeyword = new byte[s.length()/2];
	for(int i = 0; i < baKeyword.length; i++){
		try{
		baKeyword[i] = (byte)(0xff & Integer.parseInt(s.substring(i*2, i*2+2),16));
		}
		catch(Exception e){
		e.printStackTrace();
		}
	}
	try{
	s = new String(baKeyword, "utf-8");
	}catch (Exception e1){
		e1.printStackTrace();
	}
	return s;
	} 
	
	/**
	 * 生成激活码字符串
	 * @return
	 */
	public synchronized static String creteActiveCode(){
		StringBuilder sb = new StringBuilder("");
		int a = Common.getRandomNum6();
		//String b = Common.formatDate(new Date(), "yyyyHHmmsss");
		String code_str = sb.append(a).append(Common.getRandomNum4()).toString();
		return code_str;
	}
	
	/**
	 *  得到两个日期相差的天数 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static int getBetweenDay(Date date1, Date date2) {  
        Calendar d1 = new GregorianCalendar();  
        d1.setTime(date1);  
        Calendar d2 = new GregorianCalendar();  
        d2.setTime(date2);  
        int days = d2.get(Calendar.DAY_OF_YEAR)- d1.get(Calendar.DAY_OF_YEAR);  
        //System.out.println("days="+days);  
        int y2 = d2.get(Calendar.YEAR);  
        if (d1.get(Calendar.YEAR) != y2) {  
//          d1 = (Calendar) d1.clone();  
            do {  
                days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);  
                d1.add(Calendar.YEAR, 1);  
            } while (d1.get(Calendar.YEAR) != y2);  
        }  
        return days;  
    } 
	
	
	public static String[] parseStrings(String[] strs){
		List<String> new_strs = new ArrayList<String>();
		if(strs!=null&&strs.length>0){
			for (String str : strs) {
				if(StringUtils.isNotBlank(str.trim())){
					new_strs.add(str);
				}
			}
		}
		return (String[]) new_strs.toArray(new String[new_strs.size()]);
	}
	
	public static String getDateSn(int num){
		String sn = "";
		String date_str = formatDate(new Date(), "ddHHmmss");
		String num_str = String.valueOf(num);
		Random t = new Random();
		if(num_str.length() == 1){
			sn = date_str+(t.nextInt(899) + 100)+"00"+num_str;
		}else if(num_str.length() == 2){
			sn = date_str+(t.nextInt(899) + 100)+"0"+num_str;
		}else{
			sn = date_str+(t.nextInt(899) + 100)+num_str;
		}
		return sn;
	}
	

	/**
	 * 获取顺序号码
	 * @param prefix
	 * @param size
	 * @return
	 */
	public static List<String> createAutomaticNum(String prefix,int size) {
		int num=10000000;
		List<String> retValue = new ArrayList<String>();
		for(int i=1;i<=size;i++){
			String x=String.valueOf(num+i).substring(1);
			retValue.add(prefix+x);
		}
		return retValue;
	}

}
