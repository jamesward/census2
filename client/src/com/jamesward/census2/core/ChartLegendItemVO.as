/**
 * Created by IntelliJ IDEA.
 * User: jamesw
 * Date: Sep 21, 2010
 * Time: 12:24:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.jamesward.census2.core {

[Bindable]
public class ChartLegendItemVO {

  public function ChartLegendItemVO(color:Number, dataField:String) {
    this.color = color;
    this.dataField = dataField;
  }

  public var color:Number;
  public var dataField:String;
}
}