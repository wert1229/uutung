package com.sist.erp.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

public class IOUtil{
	
	public static String fileUpload(MultipartFile file, HttpSession session, String path) {
		
		UUID uuid = UUID.randomUUID();
		String originFileName = file.getOriginalFilename();
		String saveFileName = uuid.toString()+"_"+originFileName;
		
		String uploadPath = session.getServletContext().getRealPath(path);
		String fullPath = uploadPath +saveFileName;
		
		String ThumbnailedFilePath = uploadPath+"s_"+saveFileName;
		String formatName = originFileName.substring(originFileName.indexOf(".")+1);
		
		try
		{
			file.transferTo(new File(fullPath));
			makeThumbnail(fullPath, ThumbnailedFilePath, formatName);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return ThumbnailedFilePath;
	}
	
	public static void makeThumbnail(String filePath, String targetFilePath, String format) throws IOException {
		BufferedImage originImg = ImageIO.read(new File(filePath));
		
		int width = 150;
		int height = 180;
		
		BufferedImage resizedImg = Scalr.resize(originImg, width, height);
		
		ImageIO.write(resizedImg, format, new File(targetFilePath));
	}
}