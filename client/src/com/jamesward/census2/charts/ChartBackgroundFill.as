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

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.LineScaleMode;
import flash.geom.Rectangle;

import mx.charts.chartClasses.ChartElement;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.graphics.IFill;
import mx.graphics.SolidColor;

[Style(name="borderFillColor", type="uint", format="Color", inherit="yes")]

[Style(name="fillColor", type="uint", format="Color", inherit="yes")]

public class ChartBackgroundFill extends ChartElement
{

  public function ChartBackgroundFill()
  {
    super();
  }

  override protected function updateDisplayList(unscaledWidth:Number,
                          unscaledHeight:Number):void
  {
    super.updateDisplayList(unscaledWidth, unscaledHeight);

    graphics.clear();
    graphics.lineStyle(1, getStyle("borderFillColor"));
    graphics.beginFill(getStyle("fillColor"));
    graphics.drawRect(1, 1, unscaledWidth - 2, unscaledHeight - 2);
    graphics.endFill();
  }

  override public function mappingChanged():void
  {
    invalidateDisplayList();
  }
  
  override public function chartStateChanged(oldState:uint,
                         newState:uint):void
  {
    invalidateDisplayList();
  }
}
}
