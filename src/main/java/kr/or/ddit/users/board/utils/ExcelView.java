package kr.or.ddit.users.board.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.servlet.view.document.AbstractXlsxStreamingView;

import net.sf.jxls.transformer.XLSTransformer;


public class ExcelView extends AbstractXlsxStreamingView {

	private static final String menu = "/excel/menu.xlsx";	// 클래스패스에 있는 Resource 경로
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		OutputStream os = null;
		InputStream is = null;
		
		try {
			String fileName = "FAQ_등록_폼";
			
			is = new ClassPathResource(menu).getInputStream();
			
			response.setHeader("Content-Type", "application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=" +  URLEncoder.encode(fileName, "UTF-8") + ".xlsx");//한글은 인코딩 필요
			
			os = response.getOutputStream();
			
			XLSTransformer transformer = new XLSTransformer();
			
			Workbook excel = transformer.transformXLS(is, model);
			CellStyle wrapTextStyle = getWrapTextStyle(excel);							// 셀 너비 초과 시 자동 줄바꿈 설정
            
            for (Sheet sheet : excel) {
            	int rowIndex = 0;
                for (Row row : sheet) {
                	// 1 ~ 4행까지 제외
                	if(rowIndex < 4) { 
                        rowIndex++;
                        continue;
                    }
                	
                    for (Cell cell : row) {
                        cell.setCellStyle(wrapTextStyle);								// 각마다 자동 줄바꿈 적용
                    }
                }
            }
			
			excel.write(os);
			os.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			if(os != null) {
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}
	
	// 셀 너비 초과 시 자동 줄바꿈 설정
	private CellStyle getWrapTextStyle(Workbook workbook) {
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(true);
		
		return cellStyle;
	}

}
