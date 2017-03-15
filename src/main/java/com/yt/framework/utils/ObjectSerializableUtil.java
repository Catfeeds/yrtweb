package com.yt.framework.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import org.apache.log4j.Logger;

/**
 * 使用oss开发过程中涉及到了上传、下载的断点续传，需要将对象序列化为文件保存
 *
 */
public class ObjectSerializableUtil {

	public static final Logger LOGGER = Logger.getLogger(ObjectSerializableUtil.class);

    public static void serialization (Object object, String serializationFilePath) {
        File file = new File(serializationFilePath);
        if (!new File(file.getParent()).exists())
            new File(file.getParent()).mkdirs();
        if (file.exists())
            file.delete();
        ObjectOutputStream oos = null;
        LOGGER.debug("save: " + file);
        try {
            oos = new ObjectOutputStream(new FileOutputStream(file));
            oos.writeObject(object);
            oos.close();
        } catch (IOException e) {
            e.printStackTrace();
            LOGGER.error("serialization failure");
            try {if (oos!=null)oos.close();} catch (IOException e1) {e1.printStackTrace();}
            file.delete();
        }
    }

    public static Object deserialization (String serializationFilePath) {
        File file = new File(serializationFilePath);
        if (!file.exists())
            return null;
        else {
            LOGGER.debug("load: " + file);
        }
        try {
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));
            Object object = ois.readObject();
            ois.close();
            file.delete();
            return object;
        } catch (Exception e) {
            LOGGER.error("deserialization failure");
            return null;
        }
    }

    public static boolean delSerlzFile(String serializationFilePath) {
        File file = new File(serializationFilePath);
        if (file.exists())
            return file.delete();
        return true;
    }
}
