package com.yt.framework.utils.file;

import java.io.File;
import java.io.IOException;
import java.util.Properties;
import javax.servlet.ServletContext;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import com.yt.framework.utils.Num62;
import com.yt.framework.utils.PropertiesUtils;


/**
 * 该文件需要放到对应的工程中去才能扫描到 @Component("fileRepository")
 * 本地文件存储
 * 需要使用该类必须用注入到MVC组件类里。
 */
@Component("fileRepository")
public class FileRepository implements ServletContextAware {
	private Logger log = LoggerFactory.getLogger(FileRepository.class);

	private ServletContext ctx;
	
	public void setServletContext(ServletContext servletContext) {
		this.ctx = servletContext;
	}
	
	/**
	 * 将文件保存到本地
	 * 并且已将文件名称更改。
	 * @param path 项目的相对路径，不能以“/”开头和结尾。如：“ttt/img”，该方法会自动生成子目录。YYYMM
	 * @param ext 保存到本地的文件扩展名
	 * @param file 该参数，必须在controller的转发方法加入@RequestParam("[html的file标签名称]") MultipartFile file
	 * @return 更改后的文件名称
	 */	
	public String storeByExt(String path, String ext, MultipartFile file)
			throws IOException {
		String filename = UploadUtils.generateFilename(path, ext);
		File dest = new File(getRealPath(filename));
		dest = UploadUtils.getUniqueFile(dest);
		store(file, dest);
		return filename;
	}
	
	public String storeByExtCtx(String path, String ext, MultipartFile file)throws IOException {
		String filename = path + RandomStringUtils.random(4, Num62.N36_CHARS)+ "." + ext;
		File dest = new File(ctx.getRealPath("/")+filename);
		store(file, dest);
		return filename;
	}

	public String storeByFilename(String filename, MultipartFile file)
			throws IOException {
		File dest = new File(getRealPath(filename));
		store(file, dest);
		return filename;
	}

	public String storeByExt(String path, String ext, File file)
			throws IOException {
		String filename = UploadUtils.generateFilename(path, ext);
		File dest = new File(getRealPath(filename));
		dest = UploadUtils.getUniqueFile(dest);
		store(file, dest);
		return filename;
	}

	public String storeByFilename(String filename, File file)
			throws IOException {
		File dest = new File(getRealPath(filename));
		store(file, dest);
		return filename;
	}

	private void store(MultipartFile file, File dest) throws IOException {
		try {
			UploadUtils.checkDirAndCreate(dest.getParentFile());
			file.transferTo(dest);
		} catch (IOException e) {
			log.error("Transfer file error when upload file", e);
			throw e;
		}
	}

	private void store(File file, File dest) throws IOException {
		try {
			UploadUtils.checkDirAndCreate(dest.getParentFile());
			FileUtils.copyFile(file, dest);
		} catch (IOException e) {
			log.error("Transfer file error when upload file", e);
			throw e;
		}
	}

	public File retrieve(String name) {
		return new File(ctx.getRealPath(name));
	}
	
	public String getRealPath(String name){
		Properties p = PropertiesUtils.loadSetting("/messages/common.properties");
		String fileUrl = "";
		if(p.get("fileUrl")!=null&&StringUtils.isNotBlank(p.get("fileUrl").toString())){
			fileUrl = p.get("fileUrl").toString();
		}
		return fileUrl+"/"+name;
	}
	
	public String getCtxRealPath(String name){
		return ctx.getRealPath("/")+name;
	}

}
