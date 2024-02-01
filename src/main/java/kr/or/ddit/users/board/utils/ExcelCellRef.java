package kr.or.ddit.users.board.utils;

import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;

public class ExcelCellRef {
	/**
	 * Cell에 해당하는 Column Name을 가젼온다(A,B,C..) 만약 Cell이 Null이라면 int cellIndex의 값으로
	 * Column Name을 가져온다.
	 * 
	 * @param cell
	 * @param cellIndex
	 * @return
	 */
	public static String getName(Cell cell, int cellIndex) {
		int cellNum = 0;
		if (cell != null) {
			cellNum = cell.getColumnIndex();
		} else {
			cellNum = cellIndex;
		}
		return CellReference.convertNumToColString(cellNum);
	}

	public static String getValue(Cell cell, Workbook wb) {
		FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();
		String value = "";
		if (cell == null) {
			value = "";
		}
		if (cell != null) {
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_FORMULA:
				if (evaluator.evaluateFormulaCell(cell) == HSSFCell.CELL_TYPE_NUMERIC) {
					value = (float) cell.getNumericCellValue() + ""; // 계산된 수식의 값을 가져옴
				} else if (evaluator.evaluateFormulaCell(cell) == HSSFCell.CELL_TYPE_STRING) {
					value = cell.getStringCellValue(); // 계산된 수식의 문자값을 가져옴
				}
				break;
			case Cell.CELL_TYPE_NUMERIC:
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-dd");
					value = formatter.format(cell.getDateCellValue());
				} else {
					if ((cell.getNumericCellValue() + "").contains(".0")) {
						value = (int) cell.getNumericCellValue() + "";
					} else {
						value = (float) cell.getNumericCellValue() + "";
					}
				}
				break;
			case Cell.CELL_TYPE_STRING:
				value = cell.getStringCellValue();
				break;
			case Cell.CELL_TYPE_BOOLEAN:
				value = cell.getBooleanCellValue() + "";
				break;
			case Cell.CELL_TYPE_BLANK:
				value = "";
				break;
			case Cell.CELL_TYPE_ERROR:
				value = cell.getErrorCellValue() + "";
				break;
			default:
				value = cell.getStringCellValue();
			}
		}
		return value;
	}
}
