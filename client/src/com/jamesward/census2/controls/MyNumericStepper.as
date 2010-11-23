package com.jamesward.census2.controls
{
import com.jamesward.census2.utils.TextFormatters;

import mx.controls.NumericStepper;
  import mx.core.FlexVersion;
  import mx.core.IUITextField;
  import mx.core.mx_internal;
  import mx.events.FlexEvent;
  import flash.text.TextLineMetrics;

  use namespace mx_internal;

  public class MyNumericStepper extends NumericStepper
  {
    private var eventListenerAdded:Boolean = false;

    override protected function updateDisplayList(unscaledWidth:Number,
      unscaledHeight:Number):void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);

      if ((inputField != null) && (!eventListenerAdded))
      {
        inputField.addEventListener(FlexEvent.UPDATE_COMPLETE, updateTextFieldPosition);
      }
    }

    public function updateTextFieldPosition(event:FlexEvent):void
    {
      var tf:IUITextField = inputField.getTextField();
      var lineMetrics:TextLineMetrics;
      lineMetrics = measureText(tf.text);
      tf.y = (tf.height / 2) - (lineMetrics.height / 2) + 2;
    }

  }
}