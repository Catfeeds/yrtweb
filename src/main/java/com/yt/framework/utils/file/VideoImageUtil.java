package com.yt.framework.utils.file;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.yt.framework.utils.PropertiesUtils;

/**
 * 视频文件生成一张图片
 *
 * @autor bo.xie
 * @date2015-8-17上午11:36:07
 */
public class VideoImageUtil {
	private static Logger log = LoggerFactory.getLogger(VideoImageUtil.class);

	private static final String COMMON_PATH = "/messages/common.properties";

	private static boolean checkfile(String path) {
		File file = new File(path);
		if (!file.isFile()) {
			file.mkdirs();
		}
		return true;
	}

	/**
	 * 生成图片
	 *
	 * @param videoPath
	 *            视频地址
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-17下午12:44:11
	 */
	public static final String process(String videoPath) {
		// update by gl 2015.08.25
		// String imageRealPath =
		// PropertiesUtils.loadSetting(COMMON_PATH).getProperty("imagePath");
		// String filename = UploadUtils.generateFilename(imageRealPath, "jpg");
		String filename = videoPath.substring(0, videoPath.lastIndexOf("."))
				+ ".jpg";
		// update by gl 2015.08.25
		checkfile(filename.substring(0, filename.lastIndexOf("/")));
		List<String> commend = new java.util.ArrayList<String>();
		String exePath = PropertiesUtils.loadSetting(COMMON_PATH).getProperty(
				"exePath");
		commend.add(exePath);
		commend.add("-i");
		commend.add(videoPath);
		commend.add("-y");
		commend.add("-f");
		commend.add("image2");
		commend.add("-ss");
		commend.add("1");
		commend.add("-t");
		commend.add("0.001");
		commend.add("-s");
		commend.add("350*240");
		commend.add(filename);
		try {
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			builder.redirectErrorStream(true);
			//System.out.println("视频截图开始...");
			// builder.start();
			Process process = builder.start();
			InputStream in = process.getInputStream();
			byte[] re = new byte[1024];
			//System.out.print("正在进行截图，请稍候");
			while (in.read(re) != -1) {
				System.out.print(".");
			}
			System.out.println("");
			in.close();
			//System.out.println("视频截图完成...");
			return filename;
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("视频截图失败！");

		}
		return null;
	}

	public static String processChange(String path) {
		int type = checkContentType(path);
		String filePath = "";
		process(path);
		log.info("[视频转码]：视频格式 " + type);
		if (type == 0) {
			System.out.println("直接将文件转为flv文件");
			filePath = processFLV(path);// 直接将文件转为flv文件
		} else if (type == 1) {
			String avifilepath = processAVI(type, path);
			if (avifilepath == null)
				return "";// avi文件没有得到
			filePath = processFLV(avifilepath);// 将avi转为flv
		}
		return filePath;
	}

	private static int checkContentType(String path) {
		String type = path.substring(path.lastIndexOf(".") + 1, path.length())
				.toLowerCase();
		// ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
		if (type.equals("avi")) {
			return 0;
		} else if (type.equals("mpg")) {
			return 0;
		} else if (type.equals("wmv")) {
			return 0;
		} else if (type.equals("3gp")) {
			return 0;
		} else if (type.equals("mov")) {
			return 0;
		} else if (type.equals("mp4")) {
			return 0;
		} else if (type.equals("asf")) {
			return 0;
		} else if (type.equals("asx")) {
			return 0;
		} else if (type.equals("flv")) {
			return 0;
		}
		// 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),
		// 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
		else if (type.equals("wmv9")) {
			return 1;
		} else if (type.equals("rm")) {
			return 1;
		} else if (type.equals("rmvb")) {
			return 1;
		}
		return 9;
	}

	// 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等), 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
	private static String processAVI(int type, String path) {
		List<String> commend = new ArrayList<String>();
		String mencoderPath = PropertiesUtils.loadSetting(COMMON_PATH)
				.getProperty("mencoderPath");
		commend.add(mencoderPath);
		commend.add(path);
		commend.add("-oac");
		commend.add("lavc");
		commend.add("-lavcopts");
		commend.add("acodec=mp3:abitrate=64");
		commend.add("-ovc");
		commend.add("xvid");
		commend.add("-xvidencopts");
		commend.add("bitrate=600");
		commend.add("-of");
		commend.add("avi");
		commend.add("-o");
		commend.add("E:/test/test.avi");
		try {
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			builder.start();
			return "E:/test/test.avi";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
	private static String processFLV(String oldfilepath) {
		log.info("[视频转码]：开始转码");
		if (!checkfile(oldfilepath)) {
			System.out.println(oldfilepath + " is not file");
			return "";
		}
		String filename = oldfilepath
				.substring(0, oldfilepath.lastIndexOf(".")) + ".flv";

		// 文件命名
		Calendar c = Calendar.getInstance();
		String savename = String.valueOf(c.getTimeInMillis())
				+ Math.round(Math.random() * 100000);
		List<String> commend = new ArrayList<String>();
		String exePath = PropertiesUtils.loadSetting(COMMON_PATH).getProperty(
				"exePath");
		commend.add(exePath);
		commend.add("-i"); // 指定要转换视频的源文件
		commend.add(oldfilepath);
		// commend.add("-ab"); //音频转换后的bit率(默认64k)
		// commend.add("64");
		// commend.add("-acodec");//制度音频使用的编码器
		// commend.add("mp3");
		// commend.add("-ac"); //制定转换后音频的声道
		// commend.add("2");
		// commend.add("-ar"); //音频转换后的采样率
		// commend.add("22050");
		// commend.add("-b"); //视频转换换的bit率
		// commend.add("230");
		// commend.add("-r"); //视频转换换的桢率(默认25桢每秒)
		// commend.add("24");
		// commend.add("-s"); //视频转换后视频的分辨率
		// commend.add("700x360");
		commend.add("-i");
		commend.add(oldfilepath);
		commend.add("-ab");
		commend.add("64");
		commend.add("-ac");
		commend.add("1");
		commend.add("-qscale");
		commend.add("8");
		commend.add("-ar");
		commend.add("22050");
		commend.add("-b");
		commend.add("230");
		commend.add("-r");
		commend.add("24");
		commend.add("-y");
		commend.add(filename);

		try {
			log.info("[视频转码]：开始转码start");
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			Process p = builder.start();
			doWaitFor(p);
			p.destroy();
			// deleteFile(oldfilepath);
			log.info("[视频转码]：视频转换成功");
			return filename;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("视频转换失败！");
			log.error("视频转换失败");
			return "";
		}
	}

	private static int doWaitFor(Process p) {
		InputStream in = null;
		InputStream err = null;
		int exitValue = -1; // returned to caller when p is finished
		try {
			System.out.println("comeing");
			in = p.getInputStream();
			err = p.getErrorStream();
			boolean finished = false; // Set to true when p is finished

			while (!finished) {
				try {
					while (in.available() > 0) {
						// Print the output of our system call
						Character c = new Character((char) in.read());
						System.out.print(c);
					}
					while (err.available() > 0) {
						// Print the output of our system call
						Character c = new Character((char) err.read());
						System.out.print(c);
					}

					// Ask the process for its exitValue. If the process
					// is not finished, an IllegalThreadStateException
					// is thrown. If it is finished, we fall through and
					// the variable finished is set to true.
					exitValue = p.exitValue();
					finished = true;

				} catch (IllegalThreadStateException e) {
					// Process is not finished yet;
					// Sleep a little to save on CPU cycles
					Thread.currentThread().sleep(500);
				}
			}
		} catch (Exception e) {
			// unexpected exception! print it out for debugging...
			System.err.println("doWaitFor();: unexpected exception - "
					+ e.getMessage());
		} finally {
			try {
				if (in != null) {
					in.close();
				}

			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
			if (err != null) {
				try {
					err.close();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}
		// return completion status to caller
		return exitValue;
	}

	public static void deleteFile(String filepath) {
		/*File file = new File(filepath);
		if (PATH.equals(filepath)) {
			if (file.delete()) {
				System.out.println("文件" + filepath + "已删除");
			}
		} else {
			if (file.delete()) {
				System.out.println("文件" + filepath + "已删除 ");
			}
			File filedelete2 = new File(PATH);
			if (filedelete2.delete()) {
				System.out.println("文件" + PATH + "已删除");
			}
		}*/
	}

	public static void main(String[] args) {
		
//		 String imagePath = VideoImageUtil.process("C:/Users/lenovo/Desktop/yasuo/123.mpg");
		String imagePath = VideoImageUtil.processChange("C:/Users/lenovo/Desktop/yasuo/20160802/07.16宇超颁奖.mpg");
		 System.out.println("生成图片路径:"+imagePath);
		 
		/*if (!checkfile("E:/test/test.mp4")) {
			System.out.println("E:/test/test.mp4" + " is not file");
			return;
		}*/
		// System.out.println(getVideoResult("E:/test/119142100jt1j.flv"));
	}

}
