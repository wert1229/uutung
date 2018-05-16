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

import com.sist.erp.vo.MoveToDisplayVO;

public class MoveExcelDown extends AbstractXlsView
{
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
			String sCurTime = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).format(new Date());

	        String excelName = sCurTime + "_재고이동엑셀.xls";

	        Sheet worksheet = null;

	        Row row = null;

	        @SuppressWarnings("unchecked")
	        List<MoveToDisplayVO> listExcel = (List<MoveToDisplayVO>) model.get("mtdlist");
	       
	        // 새로운 sheet를 생성한다.
	        worksheet = workbook.createSheet("엑셀 목록");
	       
	        // 가장 첫번째 줄에 제목을 만든다.
	        row = worksheet.createRow(0);

	        // 칼럼 길이 설정
	        for (int i = 0; i < 7; i++)
			{
	        	worksheet.setColumnWidth(i, 4000);
			}
	        
	        // 헤더 설정
	        row = worksheet.createRow(0);

	        row.createCell(0).setCellValue("결재코드");

	        row.createCell(1).setCellValue("제목");

	        row.createCell(2).setCellValue("대상 매장");

	        row.createCell(3).setCellValue("물품");

	        row.createCell(4).setCellValue("종류");
	        
	        row.createCell(5).setCellValue("물품 납기일");
	        
	        row.createCell(6).setCellValue("진행 현황");

	        for (int i = 0; i < listExcel.size(); i++)
			{
	        	row = worksheet.createRow(i+1);
				
	        	row.createCell(0).setCellValue(listExcel.get(i).getMseq());
	        	row.createCell(1).setCellValue(listExcel.get(i).getTitle());
	        	row.createCell(2).setCellValue(listExcel.get(i).getBranchName());
	        	row.createCell(3).setCellValue(listExcel.get(i).getNote());
	        	row.createCell(4).setCellValue(listExcel.get(i).getKind());
	        	row.createCell(5).setCellValue(listExcel.get(i).getEstdate());
	        	row.createCell(6).setCellValue(listExcel.get(i).getState());
			}
	        
	        try
	        {
	            response.setHeader("Content-Disposition", "attachement; filename=\""
	                + java.net.URLEncoder.encode(excelName, "UTF-8") + "\";charset=\"UTF-8\"");
	        } 
	        catch(UnsupportedEncodingException e)
	        {
	            e.printStackTrace();
	        }
	}
}
