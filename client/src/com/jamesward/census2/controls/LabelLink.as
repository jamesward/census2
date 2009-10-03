package com.jamesward.census2.controls
{
  import flash.text.StyleSheet;

  import mx.controls.Label;

  public class LabelLink extends Label
  {
    private var styleSheetValid:Boolean = false;

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);

      updateStyleSheet();
    }

    override public function styleChanged(styleProp:String):void
    {
      super.styleChanged(styleProp);

      if ((styleProp == "linkColor") || (styleProp == "linkHoverColor") || (styleProp == null))
      {
        invalidateStyleSheet();
      }
    }

    public function invalidateStyleSheet():void
    {
      styleSheetValid = false;
      updateStyleSheet();
    }

    private function updateStyleSheet():void
    {
      if (!styleSheetValid)
      {
        var aLink:Object = new Object();
        aLink.color = getStringColor(getStyle("linkColor"));

        var aHover:Object = new Object();
        aHover.color = getStringColor(getStyle("linkHoverColor"));
        aHover.textDecoration = "underline";

        var textStyleSheet:StyleSheet = new StyleSheet();
        textStyleSheet.setStyle("a:link", aLink);
        textStyleSheet.setStyle("a:hover", aHover);

        styleSheet = textStyleSheet;

        invalidateDisplayList();

        styleSheetValid = true;
      }
    }

    private function getStringColor(color:*):String
    {
      if ( (color is uint) || (color is int) || (color is Number) )
      {
        return "#" + Number(color).toString(16);
      }

      if (color is String)
      {
        return String(color);
      }

      return "";
    }

  }
}

