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
package com.jamesward.census2.utils
{
import mx.charts.HitData;
import mx.charts.chartClasses.IAxis;
import mx.formatters.NumberFormatter;
  
public class TextFormatters
{
  
  public static function byteFormat(labelValue:Object, previousValue:Object=null, axis:IAxis=null):String
  {
    var nf:NumberFormatter = new NumberFormatter();
    nf.precision = 1;
    var n:Number = new Number(labelValue);
    if (n >= 1000000)
    {
      return nf.format(n / 1000000) + " MB";
    }
    else if (n >= 1000)
    {
      return nf.format(n / 1000) + " KB";
    }
    else
    {
      return nf.format(n) + " B";
    }
  }

  public static function timeFormat(labelValue:Object, previousValue:Object=null, axis:IAxis=null):String
  {
    var nf:NumberFormatter = new NumberFormatter();
    nf.precision = 1;
    var n:Number = new Number(labelValue);
    if (n >= 1000)
    {
      return nf.format(n / 1000) + " s";
    }
    else
    {
      return nf.format(n) + " ms";
    }
  }

  public static function getBandwidthDataTip(hitData:HitData):String
  {
    return "<b>" + hitData.item.name + " - " + hitData.item.numRows + " Rows</b>" +
      "<br/>Transfer Size: " + byteFormat(hitData.item.contentLength) + 
      "<br/><br/><b>Transfer Size Per Row: " + byteFormat(hitData.item.contentLength / hitData.item.numRows) + "</b>";
  }

  public static function getTimeDataTip(hitData:HitData):String
  {
    var rpsFormatter:NumberFormatter = new NumberFormatter();
    rpsFormatter.useThousandsSeparator = true;
    rpsFormatter.precision = 0;
    
    return "<b>" + hitData.item.name + " - " + hitData.item.numRows + " Rows</b>" +
      "<br/>Server Exec Time: " + timeFormat(hitData.item.totalServerTime) +
      "<br/>Transfer Time: " + timeFormat(hitData.item.transferTime) +
      "<br/>Parse Time: " + timeFormat(hitData.item.parseTime) +
      "<br/>Render Time: " + timeFormat(hitData.item.renderTime) +
      "<br/>Total Time: " + timeFormat(hitData.item.totalServerTime + hitData.item.transferTime + hitData.item.parseTime + hitData.item.renderTime) +
      "<br/><br/><b>Rows Per Second: " + rpsFormatter.format((hitData.item.numRows / (hitData.item.totalServerTime + hitData.item.transferTime + hitData.item.parseTime + hitData.item.renderTime) * 1000)) + "</b>";
  }

  public static function getMemoryDataTip(hitData:HitData):String
  {
    return "<b>" + hitData.item.name + " - " + hitData.item.numRows + " Rows</b>" +
      "<br/>Memory: " + byteFormat(hitData.item.memorySize);
  }

  }
}