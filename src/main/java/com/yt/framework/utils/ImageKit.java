package com.yt.framework.utils;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import com.yt.framework.utils.file.UploadUtils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

/**
 * ImageKit on shearphoto
 *
 * @author <a href="mailto:akhuting@hotmail.com">Alex Yang</a>
 * @date 2015年08月19日 15:20
 */
public class ImageKit {

    public static boolean isImageFile(File imageFile) {
        if (!imageFile.exists()) {
            return false;
        }
        Image img;
        try {
            img = ImageIO.read(imageFile);
            return !(img == null || img.getWidth(null) <= 0 || img.getHeight(null) <= 0);
        } catch (Exception e) {
            return false;
        }
    }


    public static String getImageFormat(File image) {
        try {
            // Create an image input stream on the image
            ImageInputStream iis = ImageIO.createImageInputStream(image);

            // Find all image readers that recognize the image format
            Iterator<ImageReader> iter = ImageIO.getImageReaders(iis);
            if (!iter.hasNext()) {
                // No readers found
                return null;
            }

            // Use the first reader
            ImageReader reader = iter.next();

            // Close stream
            iis.close();

            // Return the format name
            return reader.getFormatName();
        } catch (IOException e) {
            //
        }

        // The image could not be read
        return null;
    }

    /**
     * 图片旋转
     * @param bufferedimage
     * @param degree
     * @return
     */
    public static BufferedImage rotateImage(final BufferedImage bufferedimage,
                                            final int degree) {
        int w = bufferedimage.getWidth();
        int h = bufferedimage.getHeight();
        int type = bufferedimage.getColorModel().getTransparency();
        BufferedImage img;
        Graphics2D graphics2d;
        (graphics2d = (img = new BufferedImage(w, h, type))
                .createGraphics()).setRenderingHint(
                RenderingHints.KEY_INTERPOLATION,
                RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        graphics2d.rotate(Math.toRadians(degree), w / 2, h / 2);
        graphics2d.drawImage(bufferedimage, 0, 0, null);
        graphics2d.dispose();
        return img;
    }

    /**
     * 删除图片
     *
     * @param path
     */
    public static void delFile(String path) {
        File file = new File(path);
        file.delete();
    }

    /**
     * 裁剪图片
     *
     * @param bi 源文件
     * @param x            x坐标
     * @param y            y坐标
     * @param destWidth    最终生成的图片宽
     * @param destHeight   最终生成的图片高
     * @param finalWidth   缩放宽度
     * @param finalHeight  缩放高度
     */
    public static void abscut(BufferedImage bi, String outputFile, String type, int x, int y, int destWidth,
                              int destHeight, int finalWidth, int finalHeight) {
        try {
            Image img;
            ImageFilter cropFilter;

            int srcWidth = bi.getWidth(); // 源图宽度
            int srcHeight = bi.getHeight(); // 源图高度

            if (srcWidth >= destWidth && srcHeight >= destHeight) {
                Image image = bi.getScaledInstance(finalWidth, finalHeight, Image.SCALE_DEFAULT);//获取缩放后的图片大小
                cropFilter = new CropImageFilter(x, y, destWidth, destHeight);
                img = Toolkit.getDefaultToolkit().createImage(
                        new FilteredImageSource(image.getSource(), cropFilter));

                BufferedImage tag = new BufferedImage(destWidth, destHeight,
                        BufferedImage.TYPE_INT_RGB);

                if (type.equalsIgnoreCase("png")) {
                    Graphics2D g2d = tag.createGraphics();
                    tag = g2d.getDeviceConfiguration().createCompatibleImage(destWidth, destHeight, Transparency.TRANSLUCENT);
                }
                Graphics g = tag.getGraphics();
                g.drawImage(img, 0, 0, null); // 绘制截取后的图
                g.dispose();
                File dest = new File(outputFile);
                dest = UploadUtils.getUniqueFile(dest);
                UploadUtils.checkDirAndCreate(dest.getParentFile());
                // 输出为文件
                ImageIO.write(tag, type, dest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** 缩放图片至指定宽高
     *
     * @param srcfile   原始图像
     * @return 返回处理后的图像
     */
    public static String zoomImage(File srcfile, String type, int toWidth, int toHeight,String newSrc) {

        BufferedImage result;

        try {
            if (!srcfile.exists()) {
                System.out.println("文件不存在");

            }
            BufferedImage im = ImageIO.read(srcfile);


            /* 新生成结果图片 */
            result = new BufferedImage(toWidth, toHeight,
                    BufferedImage.TYPE_INT_RGB);

            if (type.equalsIgnoreCase("png")) {
                Graphics2D g2d = result.createGraphics();
                result = g2d.getDeviceConfiguration().createCompatibleImage(toWidth, toHeight, Transparency.TRANSLUCENT);
            }

            result.getGraphics().drawImage(
                    im.getScaledInstance(toWidth, toHeight,
                            java.awt.Image.SCALE_SMOOTH), 0, 0, null);
            String output = newSrc;
            ImageIO.write(result, type, new File(output));
            /*if (toHeight > PropKit.getInt("water_scope") && toWidth > PropKit.getInt("water_scope")) {
                ImageKit.addWaterMark(PathKit.getWebRootPath() + File.separator + output, PathKit.getWebRootPath()
                        + File.separator + PropKit.get("water"), toWidth, toHeight, 1.0f);
            }*/
            return output;
        } catch (Exception e) {
            System.out.println("创建缩略图发生异常" + e.getMessage());
        }

        return null;
    }
    
    /**
     * 添加图片水印
     *
     * @param srcImg   目标图片路径，
     * @param waterImg 水印图片路径，
     * @param x        水印图片距离目标图片左侧的偏移量，如果x<0, 则在正中间
     * @param y        水印图片距离目标图片上侧的偏移量，如果y<0, 则在正中间
     * @param alpha    透明度(0.0 -- 1.0, 0.0为完全透明，1.0为完全不透明)
     * @throws IOException
     */
    public final static void addWaterMark(String srcImg, String waterImg, int x, int y, float alpha) throws IOException {
        // 加载目标图片
        File file = new File(srcImg);
        String ext = srcImg.substring(srcImg.lastIndexOf(".") + 1);
        Image image = ImageIO.read(file);
        int width = image.getWidth(null);
        int height = image.getHeight(null);

        // 将目标图片加载到内存。
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bufferedImage.createGraphics();
        g.drawImage(image, 0, 0, width, height, null);

        // 加载水印图片。
        Image waterImage = ImageIO.read(new File(waterImg));
        int width_1 = waterImage.getWidth(null);
        int height_1 = waterImage.getHeight(null);
        // 设置水印图片的透明度。
        g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

        // 设置水印图片的位置。
        int widthDiff = width - width_1;
        int heightDiff = height - height_1;
        if (x < 0) {
            x = widthDiff / 2;
        } else if (x > widthDiff) {
            x = widthDiff;
        }
        if (y < 0) {
            y = heightDiff / 2;
        } else if (y > heightDiff) {
            y = heightDiff;
        }

        // 将水印图片“画”在原有的图片的制定位置。
        g.drawImage(waterImage, x - 10, y - 10, width_1, height_1, null);
        // 关闭画笔。
        g.dispose();

        // 保存目标图片。
        ImageIO.write(bufferedImage, ext, file);
    }
    
    public static String zipImage(String srcPath, String type,String newSrc) {
		int toWidth = 150;
		String proportionalStr = "4/4";
		int index = proportionalStr.indexOf("/");
        double proportional = Double.
                parseDouble(proportionalStr.substring(0, index))
                / Double.parseDouble(proportionalStr.substring(index + 1));
        int toHeigth = (int) (toWidth / proportional);
        String zoomImage = ImageKit.zoomImage(new File(srcPath), type, toWidth, toHeigth,newSrc);
        return zoomImage;
    }
    
    public static BufferedImage rotateImage(int rotate, BufferedImage image) {
        if (rotate == -90 || rotate == -180 || rotate == -270) {
            image = ImageKit.rotateImage(image, Math.abs(rotate));
        }
        return image;
    }
}
