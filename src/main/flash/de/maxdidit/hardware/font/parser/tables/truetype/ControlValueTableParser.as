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
 
package de.maxdidit.hardware.font.parser.tables.truetype  
{ 
	import de.maxdidit.hardware.font.data.ITableMap; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.data.tables.truetype.ControlValueTableData; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ControlValueTableParser implements ITableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ControlValueTableParser(dataTypeParser:DataTypeParser)  
		{ 
			_dataTypeParser = dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */ 
		 
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):*  
		{ 
			data.position = record.offset; 
			 
			var result:ControlValueTableData = new ControlValueTableData(); 
			 
			const l:uint = record.length >> 1; // table is filled with 16 byte values 
			 
			var fwords:Vector.<int> = new Vector.<int>(); 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var value:int = _dataTypeParser.parseShort(data); 
				fwords.push(value); 
			} 
			result.fwords = fwords; 
			 
			return result; 
		} 
		 
	} 
} 
