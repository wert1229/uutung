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

import com.sist.erp.vo.BranchVO;

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
			List<BranchVO> listExcel = (List<BranchVO>) model.get("blist");
	       
	        // 새로운 sheet를 생성한다.
	        worksheet = workbook.createSheet("엑셀 목록");
	       
	        // 가장 첫번째 줄에 제목을 만든다.
	        row = worksheet.createRow(0);

	        // 칼럼 길이 설정
	        for (int i = 0; i < 5; i++)
			{
	        	worksheet.setColumnWidth(i, 4000);
			}
	        
	        // 헤더 설정
	        row = worksheet.createRow(0);

	        row.createCell(0).setCellValue("매장코드");

	        row.createCell(1).setCellValue("이름");

	        row.createCell(2).setCellValue("관리자");

	        row.createCell(3).setCellValue("연락처");

	        row.createCell(4).setCellValue("위치");

	        for (int i = 0; i < listExcel.size(); i++)
			{
	        	row = worksheet.createRow(i+1);
				
	        	row.createCell(0).setCellValue(listExcel.get(i).getBseq());
	        	row.createCell(1).setCellValue(listExcel.get(i).getName());
	        	row.createCell(2).setCellValue(listExcel.get(i).getManager());
	        	row.createCell(3).setCellValue(listExcel.get(i).getPhone());
	        	row.createCell(4).setCellValue(listExcel.get(i).getLocation());
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
