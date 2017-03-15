package com.yt.framework.utils.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.service.CommonService;
import com.yt.framework.service.admin.SysDictService;
import com.yt.framework.utils.SpringContextUtil;

public class DictSelectTag extends TagSupport{
	private String id;    //EAMPLE:<select name="selectName" id = "" />
    private String name;
    private String title;        
    private String value ="";    //默认值   即是回显 ID
    private String nodeKey;        //数据字典节点
    private String divClass;    //DIV样式
    private String labelClass;    //Label样式    
    private boolean hasLabel = false;    //是否显示label
    private String clazz = "";
    private String style = "";
    private String required = "";    // 如果必须选择、则添加required = true
    
    public int doStartTag() throws JspTagException {
        return EVAL_PAGE;
    }

    public int doEndTag() throws JspTagException {
        try {
            JspWriter out = this.pageContext.getOut();
            out.print(end().toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    public StringBuffer end() {
        StringBuffer sb = new StringBuffer();
        try{
        if (StringUtils.isBlank(divClass)) {
            divClass = "";    //默认form样式
        }
        if (StringUtils.isBlank(labelClass)){
            labelClass = "";    //默认label样式
        }
        ServletContext servletContext = pageContext.getServletContext();  
       /* ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
        CommonService  commonService = (CommonService)context.getBean("commonService");*/
        SysDictService sysDictService = (SysDictService)SpringContextUtil.getBean("sysDictService");
        List<SysDict> dictionary = sysDictService.dictList(this.getNodeKey());
                
        if (hasLabel) {
            sb.append("<div class=\""+divClass+"\">");
            sb.append("<label class=\""+labelClass+"\" >");
        }
        if (dictionary ==  null) {
            sb.append("<span color=\"red\"> 此nodekey 未查找到数据字典</span>");
        }else {
            if (hasLabel) {
                if (StringUtils.isBlank(this.title)) {
                    this.title ="选项";
                }
                sb.append(this.title+":");
                sb.append("</label>");
            }
            if(required.equals(""))
            	sb.append("<select name=\""+name+"\"  class=\""+this.getClazz()+"\" style=\""+this.getStyle()+"\"" );   
            else
            	sb.append("<select name=\""+name+"\" valid=\""+this.getRequired()+"\"  class=\""+this.getClazz()+"\" style=\""+this.getStyle()+"\""  ); 
            if (!StringUtils.isBlank(this.id)) {
                 sb.append(" id=\""+id+"\"");
            }
            sb.append(">");
                sb.append("<option value = \"\">请选择</option>");
            for (SysDict dic : dictionary) {
                if (dic.getDict_value().toString().equals(this.getValue())   ) {
                    sb.append(" <option value=\""+dic.getDict_value()+"\" selected=\"selected\">");
                }else {
                    sb.append(" <option value=\""+dic.getDict_value()+"\">");
                }
                sb.append(dic.getDict_value_desc());
                sb.append(" </option>");
            }
            
            sb.append("</select>");
            if (hasLabel) {
                sb.append("</div>");
            }
        }
        }catch (Exception e) {
            e.printStackTrace();
            return sb.append("<span color=\"red\"> <h1>异常</h1>此nodekey: "+ this.nodeKey+" 查找数据库数据字典异常<br/>"+e.getMessage()+"</span>");
        }
        return sb;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getDivClass() {
        return divClass;
    }

    public void setDivClass(String divClass) {
        this.divClass = divClass;
    }

    public String getLabelClass() {
        return labelClass;
    }

    public void setLabelClass(String labelClass) {
        this.labelClass = labelClass;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNodeKey() {
        return nodeKey;
    }

    public void setNodeKey(String nodeKey) {
        this.nodeKey = nodeKey;
    }

    public boolean isHasLabel() {
        return hasLabel;
    }

    public void setHasLabel(boolean hasLabel) {
        this.hasLabel = hasLabel;
    }

    public String getName() {
        return name;
    }

    public String getClazz() {
        return clazz;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }
}
