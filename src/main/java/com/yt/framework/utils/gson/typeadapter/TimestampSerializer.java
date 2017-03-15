package com.yt.framework.utils.gson.typeadapter;

import java.lang.reflect.Type;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.yt.framework.utils.Common;

public class TimestampSerializer implements JsonSerializer<java.sql.Timestamp> {

	public JsonElement serialize(java.sql.Timestamp src, Type typeOfSrc,
			JsonSerializationContext context) {
		return new JsonPrimitive(Common.formatDate(src, null));
	}
}