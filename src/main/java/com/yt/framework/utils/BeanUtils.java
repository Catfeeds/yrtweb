package com.yt.framework.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.UUID;

import com.google.common.collect.Maps;

/**
 * <p>
 * Description: 对象操作帮助类
 * Date:2015-8-25 14:55:03
 * 
 * @author ylt
 * @version 1.0
 * 
 */
public class BeanUtils {

	public static Object map2Object(Map<String, Object> map, Class<?> beanClass) throws Exception {    
        if (map == null) return null;    
        Object obj = beanClass.newInstance();  
        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());    
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();    
        for (PropertyDescriptor property : propertyDescriptors) {  
            Method setter = property.getWriteMethod();    
            if (setter != null) {  
                if(map.get(property.getName())!=null) setter.invoke(obj, map.get(property.getName()));   
            }  
        }  
   
        return obj;  
    }    
	/**
     * object转换map(null不复制)
     * @param map
     * @param obj
     * @return Map<String, Object>
     * @throws Exception
     */
    public static Map<String, Object> object2Map(Object obj) throws Exception {    
        if(obj == null)  
            return null;      
        Map<String, Object> map = Maps.newHashMap();
        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());    
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();    
        for (PropertyDescriptor property : propertyDescriptors) {    
            String key = property.getName();    
            if (key.compareToIgnoreCase("class") == 0) {   
                continue;  
            }  
            Method getter = property.getReadMethod();  
            Object value = getter!=null ? getter.invoke(obj) : null;  
            if(value != null){
            	if("0".equals(value.toString()))value = value.toString();
            	map.put(key, value);  
            }
        }    
        return map;  
    }    
    /**
     * object追加转换map(null不复制)
     * @param map
     * @param obj
     * @return Map<String, Object>
     * @throws Exception
     */
    public static Map<String, Object> object2Map( Map<String, Object> map, Object obj) throws Exception {    
        if(obj == null)  
            return null;      
        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());    
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();    
        for (PropertyDescriptor property : propertyDescriptors) {    
            String key = property.getName();    
            if (key.compareToIgnoreCase("class") == 0) {   
                continue;  
            }  
            Method getter = property.getReadMethod();  
            Object value = getter!=null ? getter.invoke(obj) : null;  
            if(value != null){
            	map.put(key, value);  
            }
        }    
        return map;  
    }    
    
    /**
     * object追加转换map
     * @param map
     * @param obj
     * @return Map<String, Object>
     * @throws Exception
     */
    public static Map<String, Object> object2MapWithNull( Map<String, Object> map, Object obj) throws Exception {    
        if(obj == null)  
            return null;      
        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());    
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();    
        for (PropertyDescriptor property : propertyDescriptors) {    
            String key = property.getName();    
            if (key.compareToIgnoreCase("class") == 0) {   
                continue;  
            }  
            Method getter = property.getReadMethod();  
            Object value = getter!=null ? getter.invoke(obj) : null;  
            map.put(key, value);  
        }    
        return map;  
    }    
    
    public static String nullToString(Object obj){
    	if(null == obj){
    		return "";
    	}else{
    		return obj.toString();
    	}
    }
  public static void main(String[] args){
    	/*PlayerTerm playerTerm = new PlayerTerm();
    	playerTerm.setBall_format(new Integer(11));
    	playerTerm.setEnd_age(11212);
    	Map<String, Object> params = Maps.newHashMap();
    	params.put("start",1111);
		params.put("rows",222);
    	try {
    		Map<String, Object> params1 = object2Map(params,playerTerm);
			System.out.println(params1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
    }
}
