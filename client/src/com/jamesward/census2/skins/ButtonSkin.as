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
  import mx.controls.Button;
  import mx.core.UIComponent;
  import mx.skins.Border;
  import mx.styles.StyleManager;
  import mx.utils.ColorUtil;

  public class ButtonSkin extends Border
  {

    public function ButtonSkin()
    {
      super();
    }

    override public function get measuredWidth():Number
    {
      return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
    }

    override public function get measuredHeight():Number
    {
      return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
    }

    override protected function updateDisplayList(w:Number, h:Number):void
    {
      super.updateDisplayList(w, h);

      graphics.clear();

      var cr:uint = 2;

      switch (name)
      {			
        case "upSkin":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("upBorderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("upInnerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("upBackgroundGradientColors"),
            [1,1], verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);
          break;
        }

        case "overSkin":
        case "downSkin":
        case "selectedUpSkin":
        case "selectedOverSkin":
        case "selectedDownSkin":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("overBorderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("overInnerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("overBackgroundGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);
          break;
        }

        case "disabledSkin":
        case "selectedDisabledSkin":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("disabledBorderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("disabledInnerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("disabledBackgroundGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h),
            GradientType.LINEAR);
          break;
        }
      }
    }
  }

}


