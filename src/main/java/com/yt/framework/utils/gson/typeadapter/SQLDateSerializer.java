package com.yt.framework.utils.gson.typeadapter;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.yt.framework.utils.Common;

public class SQLDateSerializer implements JsonSerializer<java.sql.Date> {

    public JsonElement serialize(java.sql.Date src, Type typeOfSrc,
            JsonSerializationContext context) {
    	
        return new JsonPrimitive(Common.formatDate(src, "yyyy-MM-dd hh:mm:ss"));
    }
}