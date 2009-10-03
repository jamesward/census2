package com.jamesward.census2.skins
{

  import flash.display.GradientType;
  import flash.display.Graphics;
  import mx.skins.Border;
  import mx.styles.StyleManager;
  import mx.utils.ColorUtil;

  public class CheckBoxIcon extends Border
  {
    override public function get measuredWidth():Number
    {
      return 14;
    }

    override public function get measuredHeight():Number
    {
      return 14;
    }

    override protected function updateDisplayList(w:Number, h:Number):void
    {
      super.updateDisplayList(w, h);

      var bDrawCheck:Boolean = false;

      var g:Graphics = graphics;
      g.clear();

      var checkColor:uint = getStyle("checkColor");
      var cr:uint = 2;

      switch (name)
      {
        case "upIcon":
        case "selectedUpIcon":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("borderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("innerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("upBackgroundGradientColors"),
            [1,1], verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          if (name == "selectedUpIcon")
          {
            bDrawCheck = true;
          }
          break;
        }
        case "overIcon":
        case "selectedOverIcon":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("borderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("innerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("overBackgroundGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          if (name == "selectedOverIcon")
          {
            bDrawCheck = true;
            checkColor = getStyle("selectedCheckColor");
          }
          break;
        }
        case "downIcon":
        case "selectedDownIcon":
        {
          drawRoundRect(0, 0, w, h, cr, getStyle("borderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("innerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("downBackgroundGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          if (name == "selectedDownIcon")
          {
            bDrawCheck = true;
            checkColor = getStyle("selectedCheckColor");
          }

          break;
        }
        case "disabledIcon":
        case "selectedDisabledIcon":
        {
          bDrawCheck = true;
          checkColor = getStyle("disabledCheckColor");
          drawRoundRect(0, 0, w, h, cr, getStyle("borderColor"), 1, null, null, null, 
            { x: 1, y: 1, w: w - 2, h: h - 2, r: cr});
          drawRoundRect(1, 1, w - 2, h - 2, cr, getStyle("innerBorderGradientColors"),
            1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR,
            null, { x: 2, y: 2, w: w - 4, h: h - 4, r: cr});
          drawRoundRect(2, 2, w - 4, h - 4, cr, getStyle("disabledBackgroundGradientColors"),
            [1,1], verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR);

          if (name == "selectedDisabledIcon")
          {
            bDrawCheck = true;
          }

          break;
        }
      }

      if (bDrawCheck)
      {
        g.beginFill(checkColor);
        g.moveTo(3, 5);
        g.lineTo(5, 10);
        g.lineTo(7, 10);
        g.lineTo(12, 2);
        g.lineTo(13, 1);
        g.lineTo(11, 1);
        g.lineTo(6.5, 7);
        g.lineTo(5, 5);
        g.lineTo(3, 5);
        g.endFill();
      }
    }
  }

}


