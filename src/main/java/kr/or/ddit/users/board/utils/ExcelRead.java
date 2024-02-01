package kr.or.ddit.users.board.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ExcelRead {
    
    public static List<Map<String, String>> read(ExcelReadOption excelReadOption) {
    	
    	log.info("excelReadOption.getFilePath() 값 : " + excelReadOption.getFilePath());
    	log.info("excelReadOption.getOutputColumns() 값 : " + excelReadOption.getOutputColumns());
    	log.info("excelReadOption.getSheetNum() 값 : " + excelReadOption.getSheetNum());
    	log.info("excelReadOption.getStartRow() 값 : " + excelReadOption.getStartRow());
    	
        if(excelReadOption != null) { 
            /*
             * 엑셀파일을 읽어 들인다.
             * FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
             */
            Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

            int sheetNum = wb.getNumberOfSheets();
            
            log.info("sheetNum 값 : " + sheetNum);
            
            /* 각 Row를 리스트에 담는다. */
            List<Map<String, String>> result = new ArrayList<Map<String, String>>(); 
            
            /* 엑셀 시트가 1개가 아닌 여러개의 경우 for문을 통해 처리 */
            for(int k=0; k<sheetNum; k++) {
                Sheet sheet = wb.getSheetAt(k);
                
                log.info("sheet 값 : " + sheet);
                /* sheet에서 유효한 행의 개수를 가져온다. */
                int numOfRows = sheet.getLastRowNum() + 1; 
                
                log.info("numOfRows 값 : " + numOfRows);
                
                /* 엑셀 파일의 numOfRows가 1이 반환될 경우 예외처리 */
                if(numOfRows <= 1) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("errorMessage", "numOfRows 1이 반환되는 오류 발생");
                    result.add(map);
                    return result;
                }
                
                /* 각 Row만큼 반복을 한다. */
                for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
                    /*
                     * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
                     * 하나의 Row는 여러개의 Cell을 가진다.
                     */
                	
                    Row row = sheet.getRow(rowIndex);
                    
                    log.info("row 값 : " + row);
                    
                    // sheet.getRow(rowIndex).getCell(2) : cell(2) (= 3번쨰 컬럼값)이 null인 경우에는 if문을 빠져나가도록 설정
                    if(sheet.getRow(rowIndex).getCell(2) != null && row != null) {
                        
                        /* 가져온 Row의 Cell의 개수를 구한다.*/
                        int numOfCells = row.getLastCellNum();
                        
                        log.info("numOfCells 값 : " + numOfCells);
                        
                        /* 데이터를 담을 맵 객체 초기화 */
                        Map<String, String> map = new HashMap<String, String>();
                        
                        /* cell의 수 만큼 반복한다. */
                        for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
                            /* Row에서 CellIndex에 해당하는 Cell을 가져온다. */
                            Cell cell = row.getCell(cellIndex);
                            
                            /* 
                             * 엑셀 파일로 넘어오는 값이 함수 타입이거나 숫자 타입일 경우, '6.0616xxxxx...'와 같이 표기되는 오류 발생
                             * 함수 타입과 숫자 타입의 경우 String으로 cell타입을 변환 후에 cell값을 가져오는 코드를 추가하였다.
                             */
                            if(cell == null) {
                                continue;
                            } else {
                                switch(cell.getCellType()) {
                                    case Cell.CELL_TYPE_NUMERIC :
                                        if(HSSFDateUtil.isCellDateFormatted(cell)) {
                                            // 날짜 타입인 경우
                                            map.put(ExcelCellRef.getName(cell, cellIndex), cell.getDateCellValue().toString());
                                        } else {
                                            // 숫자 타입인 경우
                                            map.put(ExcelCellRef.getName(cell, cellIndex), String.valueOf((int)cell.getNumericCellValue()));
                                        }
                                        break;
                                    case Cell.CELL_TYPE_STRING :
                                        // 문자열 타입인 경우
                                        map.put(ExcelCellRef.getName(cell, cellIndex), cell.getStringCellValue());
                                        break;
                                    case Cell.CELL_TYPE_FORMULA :
                                        // 수식 타입인 경우
                                        cell.setCellType(Cell.CELL_TYPE_STRING);
                                        map.put(ExcelCellRef.getName(cell, cellIndex), cell.getStringCellValue());
                                        break;
                                }
                            }
                        }
                        
                        /* 만들어진 Map객체를 List로 넣는다. */
                        map.put("successMessage", "불러오기 성공");
                        result.add(map);
                    } else {
                        /* Column(행) 값이 null이거나 row(열)이 null인 경우 break; */
                        break;
                    }
                } /* 행의 개수가 끝날 때까지 */
            } /* 시트 개수가 끝날 때까지 */
            return result; 
        }
        return null; 
    }
}
