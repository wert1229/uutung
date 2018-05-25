package com.sist.erp.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.sist.erp.vo.ProductVO;

public class ProductExcelDown extends AbstractXlsView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String sCurTime = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).format(new Date());
		
		String excelName = sCurTime + "_물품엑셀.xls";
		
		Sheet worksheet = null;
		
		Row row = null;
		
		@SuppressWarnings("unchecked")
		List<ProductVO> listExcel = (List<ProductVO>) model.get("plist");
			       
		worksheet = workbook.createSheet("엑셀 목록");
			       
		row = worksheet.createRow(0);
		
		for (int i = 0; i < 5; i++) {
			worksheet.setColumnWidth(i, 4000);
		}
			        
		row = worksheet.createRow(0);
		
		row.createCell(0).setCellValue("품목코드");
		
		row.createCell(1).setCellValue("품명");
		
		row.createCell(2).setCellValue("이미지");
		
		row.createCell(3).setCellValue("분류");
		
		row.createCell(4).setCellValue("비고");
		
		row.createCell(5).setCellValue("상태");
		
		for (int i = 0; i < listExcel.size(); i++) {
			row = worksheet.createRow(i+1);
					
			row.createCell(0).setCellValue(listExcel.get(i).getPseq());
			row.createCell(1).setCellValue(listExcel.get(i).getName());
			row.createCell(2).setCellValue(listExcel.get(i).getImg());
			row.createCell(3).setCellValue(listExcel.get(i).getCategory());
			row.createCell(4).setCellValue(listExcel.get(i).getNote());
			row.createCell(5).setCellValue(listExcel.get(i).getState());
		}
			        
		try {
			response.setHeader("Content-Disposition", "attachement; filename=\"" + java.net.URLEncoder.encode(excelName, "UTF-8") + "\";charset=\"UTF-8\"");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
}