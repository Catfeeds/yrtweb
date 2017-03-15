package com.yt.framework.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyEval;

public interface BabyEvalMapper extends BaseMapper<BabyEval> {


	public int queryForPageForMapCount(@Param(value="maps")Map<String,Object> maps);
}
