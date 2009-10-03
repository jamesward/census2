/*
Copyright (C) 2007 James Ward
http://www.jamesward.org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
package com.jamesward.census2.skins
{

import flash.display.Graphics;
import mx.skins.ProgrammaticSkin;

public class DataGridHeaderSeparator extends ProgrammaticSkin
{

	public function DataGridHeaderSeparator()
	{
		super();
	}

	override public function get measuredWidth():Number
	{
		return 2;
	}
	
	override public function get measuredHeight():Number
	{
		return 10;
	}
	
	override protected function updateDisplayList(w:Number, h:Number):void
	{
		super.updateDisplayList(w, h);
		var g:Graphics = graphics;
		
		g.clear();
		
		// Highlight
		g.lineStyle(1, 0xff0000);//getStyle("borderColor"));
		g.moveTo(0, 0);
		g.lineTo(0, h);
	}

}

}


