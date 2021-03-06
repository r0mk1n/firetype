/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright �2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font.parser.tables.advanced.gpos  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable; 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray; 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class MarkArrayTableParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		private var _anchorTableParser:AnchorTableParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function MarkArrayTableParser($dataTypeParser:DataTypeParser, $anchorTableParser:AnchorTableParser) 
		{ 
			this._dataTypeParser = $dataTypeParser; 
			this._anchorTableParser = $anchorTableParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */ 
		 
		public function parseTable(data:ByteArray, offset:uint):*  
		{ 
			data.position = offset; 
			 
			var result:MarkArray = new MarkArray(); 
			 
			var markCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.markCount = markCount; 
			 
			var markRecords:Vector.<MarkRecord> = parseMarkRecords(data, offset, markCount); 
			result.markRecords = markRecords; 
			 
			return result; 
		} 
		 
		private function parseMarkRecords(data:ByteArray, offset:uint, markCount:uint):Vector.<MarkRecord>  
		{ 
			var result:Vector.<MarkRecord> = new Vector.<MarkRecord>(markCount); 
			 
			for (var i:uint = 0; i < markCount; i++) 
			{ 
				var markRecord:MarkRecord = parseMarkRecord(data); 
				result[i] = markRecord; 
			} 
			 
			parseMarkRecordAnchors(data, result, offset); 
			 
			return result; 
		} 
		 
		private function parseMarkRecordAnchors(data:ByteArray, markRecords:Vector.<MarkRecord>, offset:uint):void  
		{ 
			const l:uint = markRecords.length; 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var markRecord:MarkRecord = markRecords[i]; 
				var anchorTable:AnchorTable = _anchorTableParser.parseTable(data, offset + markRecord.markAnchorOffset); 
				markRecord.markAnchor = anchorTable; 
			} 
		} 
		 
		private function parseMarkRecord(data:ByteArray):MarkRecord  
		{ 
			var result:MarkRecord = new MarkRecord(); 
			 
			var markClass:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.markClass = markClass; 
			 
			var markAnchorOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.markAnchorOffset = markAnchorOffset; 
			 
			return result; 
		} 
	} 
} 
