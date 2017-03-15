package com.yt.framework.utils.gson.typeadapter;

import java.lang.reflect.Type;
import java.util.Date;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.yt.framework.utils.Common;

public class SQLDateDeserializer implements JsonDeserializer<java.sql.Date> {

	public java.sql.Date deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		Date d = Common.parseStringDate(json.getAsString(),"yyyy-MM-dd hh:mm:ss"); 
		return new java.sql.Date(d.getTime());
	}
}