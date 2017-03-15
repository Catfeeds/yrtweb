package com.yt.framework.persistent.entity;
import java.util.Comparator;

import com.yt.framework.persistent.entity.DynamicMsg;

public class ComparatorDynamicMsg implements Comparator<DynamicMsg> {

	public int compare(DynamicMsg inn1, DynamicMsg inn2) {
		if (inn1.getCreatetime() > inn2.getCreatetime()) {
			return 1;
		}else if (inn1.getCreatetime() == inn2.getCreatetime()) {
			return 0;
		} else {
			return -1;
		}
	}

}