package com.jamesward.census2.controls
{
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.StyleSheet;
  
  import mx.controls.Label;

  public class LabelLink extends Label
  {
    private var styleSheetValid:Boolean = false;

    private var _label:String;
    
    private var _url:String;
    
    
    public function LabelLink()
    {
      super();
      
      addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
        if (url != null)
        {
          navigateToURL(new URLRequest(url));
        }
      });
    }
      
    
    public function set label(_label:String):void
    {
      this._label = _label;
      
      invalidateText();
    }
    
    public function get label():String
    {
      return _label;
    }
    
    public function set url(_url:String):void
    {
      this._url = _url;
      
      invalidateText();
    }
    
    public function get url():String
    {
      return _url;
    }
    
    private function invalidateText():void
    {
      this.htmlText = "<a href='" + url + "'>" + label + "</a>"; 
    }
    
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
      if ((!styleSheetValid) && (textField != null))
      {
        var aLink:Object = new Object();
        aLink.color = getStringColor(getStyle("linkColor"));

        var aHover:Object = new Object();
        aHover.color = getStringColor(getStyle("linkHoverColor"));
        aHover.textDecoration = "underline";

        var textStyleSheet:StyleSheet = new StyleSheet();
        textStyleSheet.setStyle("a:link", aLink);
        textStyleSheet.setStyle("a:hover", aHover);

        textField.styleSheet = textStyleSheet;

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

