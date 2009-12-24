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
package com.jamesward.census2.charts
{

import flash.display.Graphics;
import flash.geom.Rectangle;

import mx.charts.ChartItem;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.charts.series.items.BarSeriesItem;
import mx.core.IDataRenderer;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.skins.ProgrammaticSkin;

public class BarItemRenderer extends ProgrammaticSkin implements IDataRenderer
{
  public function BarItemRenderer() 
  {
    super();
  }
    
  private var _data:Object;

  public function get data():Object
  {
    return _data;
  }

  public function set data(value:Object):void
  {
    if (_data == value)
    {
      return;
    }

    _data = value;
  }

  override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
  {
    super.updateDisplayList(unscaledWidth, unscaledHeight);

    var fill:IFill = GraphicsUtilities.fillFromStyle(getStyle("fill"));
    
    var s:Number = 1;
    if (_data is BarSeriesItem)
    {
      if (_data.item.numRows != undefined)
      {
        // find the item with the most rows
        var mostRows:Number = 0
        
        for each (var d:Object in _data.element.dataProvider)
        {
          if (d.numRows > mostRows)
          {
            mostRows = d.numRows;
          }
        }
        
        s = _data.item.numRows / mostRows;
      }
    }
    
    if (s < .05)
    {
      s = .05;
    }
    
    var modifiedHeight:Number = height * s;

    var startY:Number = (height - modifiedHeight) / 2;

    var rc:Rectangle = new Rectangle(2, startY, width, modifiedHeight);

    var g:Graphics = graphics;
    g.clear();
    g.moveTo(rc.left,rc.top);

    fill.begin(g,rc);
    
    g.lineTo(rc.right,rc.top);
    g.lineTo(rc.right,rc.bottom);
    g.lineTo(rc.left,rc.bottom);
    g.lineTo(rc.left,rc.top);

    fill.end(g);
  }

}

}
