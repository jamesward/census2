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

  import mx.skins.Border;
  import mx.styles.CSSStyleDeclaration;
  import mx.styles.StyleManager;
  import mx.utils.ColorUtil;

  public class NumericStepperDownSkin extends Border
  {
    public function NumericStepperDownSkin()
    {
      super();		
    }

    override public function get measuredWidth():Number
    {
      return 20;
    }

    override public function get measuredHeight():Number
    {
      return 11;
    }

    override protected function updateDisplayList(w:Number, h:Number):void
    {
      super.updateDisplayList(w, h);

      var styleDec:CSSStyleDeclaration = StyleManager.getStyleDeclaration("NumericStepper");

      var borderColor:int = styleDec.getStyle("borderColor");
      var arrowColor:int = getStyle("color");
      var cr:Object = {tl:0, tr:0, bl:0, br: 3};

      var g:Graphics = graphics;

      g.clear();

      // left edge
      g.beginFill(styleDec.getStyle("downArrowBorderColor"));
      g.drawRect(0, 0, 1, h - 1);
      g.endFill();

      switch (name)
      {
        case "downArrowUpSkin":
        {
          // highlight
          drawRoundRect(1, 0, w - 3, h - 2, cr, styleDec.getStyle("downArrowUpHighlightColor"), 1, null, null,
            null, { x: 2, y: 1, w: w - 4, h: h - 3, r: cr });

          // fill
          drawRoundRect(2, 1, w - 4, h - 3, cr, styleDec.getStyle("downArrowUpFillGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          break;
        }

        case "downArrowOverSkin":
        case "downArrowDisabledSkin":
        case "downArrowDownSkin":
        {
          // highlight
          g.beginFill(styleDec.getStyle("downArrowDownHighlightColor"));
          g.drawRect(1, 0, 1, h - 2);
          g.endFill();

          // fill
          drawRoundRect(2, 0, w - 4, h - 2, cr, styleDec.getStyle("downArrowDownFillGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          break;
        }
      }

      switch (name)
      {
        case "downArrowOverSkin":
        {
          arrowColor = styleDec.getStyle("textRollOverColor");
          break;
        }
        case "downArrowDisabledSkin":
        {
          arrowColor = styleDec.getStyle("disabledColor");
          break;
        }
        case "downArrowDownSkin":
        {
          arrowColor = styleDec.getStyle("textSelectedColor");
          break;
        }
      }

      // Draw the arrow.
      g.beginFill(arrowColor);
      g.moveTo(w / 2, h / 2 + 1.5);
      g.lineTo(w / 2 - 3.5, h / 2 - 2.5);
      g.lineTo(w / 2 + 3.5, h / 2 - 2.5);
      g.lineTo(w / 2, h / 2 + 1.5);
      g.endFill();
    }
  }

}


