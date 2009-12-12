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
package org.jamesward.census.views
{

import flash.display.Graphics;
import flash.geom.Rectangle;
import mx.charts.ChartItem;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.core.IDataRenderer;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.skins.ProgrammaticSkin;
import mx.charts.series.items.BarSeriesItem;

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
    var stroke:IStroke = getStyle("stroke");

    var w:Number = stroke ? stroke.weight / 2 : 0;

    var modifiedHeight:Number = height - 2 * w;

    var s:Number = 1;
    if (_data is BarSeriesItem)
    {
      if (_data.item.rows != undefined)
      {
        s = _data.item.rows / 20000;
      }
      if (s < .2)
      {
        s = .2;
      }
    }
    modifiedHeight = modifiedHeight * s;

    var startY:Number = (height - modifiedHeight) / 2;

    var rc:Rectangle = new Rectangle(w, startY, width - 2 * w, modifiedHeight);

    var g:Graphics = graphics;
    g.clear();
    g.moveTo(rc.left,rc.top);

    if (stroke)
    {
      stroke.apply(g);
    }

    if (fill)
    {
      fill.begin(g,rc);
    }

    g.lineTo(rc.right,rc.top);
    g.lineTo(rc.right,rc.bottom);
    g.lineTo(rc.left,rc.bottom);
    g.lineTo(rc.left,rc.top);

    if (fill)
    {
      fill.end(g);
    }
  }

}

}
