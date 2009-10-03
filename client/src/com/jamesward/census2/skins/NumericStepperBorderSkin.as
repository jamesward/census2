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

  import flash.display.GradientType;
  import flash.display.Graphics;

  import mx.core.Container;
  import mx.core.EdgeMetrics;
  import mx.core.IUIComponent;
  import mx.graphics.RectangularDropShadow;
  import mx.skins.RectangularBorder;
  import mx.styles.IStyleClient;
  import mx.utils.ColorUtil;

  public class NumericStepperBorderSkin extends RectangularBorder
  {

    private var _borderMetrics:EdgeMetrics;

    public function NumericStepperBorderSkin() 
    {
      super(); 
    }

    override public function get borderMetrics():EdgeMetrics
    {               
      if (_borderMetrics)
        return _borderMetrics;

      _borderMetrics = new EdgeMetrics(2, 2, 2, 2);

      return _borderMetrics;
    }

    override protected function updateDisplayList(w:Number, h:Number):void
    {  
      if (isNaN(w) || isNaN(h))
        return;

      super.updateDisplayList(w, h);

      var cr:int = 3;
      var nw:int = w + 20;
      var nh:int = h;

      drawRoundRect(0, 0, nw, nh, cr, getStyle("borderColor"), 1, null, null, null,
        {x: 1, y: 1, w: nw - 2, h: nh - 2, r: cr});

      drawRoundRect(1, 1, nw - 2, nh - 2, cr, getStyle("innerBorderColor"), 1, null, null, null,
        {x: 2, y: 2, w: nw - 4, h: nh - 4, r: cr})

      drawRoundRect(2, 2, nw - 4, nh - 4, cr, getStyle("backgroundGradientColors"), 1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);
    }

  }

}


