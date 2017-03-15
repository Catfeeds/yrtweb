package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author gl
 *
 */
public class BbsAccessoriesList implements Serializable{
	private static final long serialVersionUID = 3686983585048354299L;
	
	private List<BbsAccessories> attrcs;

	public List<BbsAccessories> getAttrcs() {
		return attrcs;
	}

	public void setAttrcs(List<BbsAccessories> attrcs) {
		this.attrcs = attrcs;
	}
	

}
