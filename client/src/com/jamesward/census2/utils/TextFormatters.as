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
    var n:Number = new Number(labelValue);
    
    if (n >= 1048576)
    {
      if ((Math.floor(n / 100000) % 10) == 0)
      {
        nf.precision = 0;      
      }
      else
      {
        nf.precision = 1;
      }
      return nf.format(n / 1048576) + " MB";
    }
    else if (n >= 1024)
    {
      if ((n % 1000) == 0)
      {
        nf.precision = 0;      
      }
      else
      {
        nf.precision = 1;
      }
      return nf.format(n / 1024) + " KB";
    }
    else if (n == -1)
    {
      return "n/a";
    }
    else
    {
      nf.precision = 0;
      return nf.format(n) + " B";
    }
  }

  public static function timeFormat(labelValue:Object, previousValue:Object=null, axis:IAxis=null):String
  {
    var nf:NumberFormatter = new NumberFormatter();
    var n:Number = new Number(labelValue);
    
    if (n >= 1000)
    {
      if ((n % 1000) == 0)
      {
        nf.precision = 0;      
      }
      else
      {
        nf.precision = 1;
      }
      return nf.format(n / 1000) + " s";
    }
    else if (n == -1)
    {
      return "n/a";
    }
    else
    {
      nf.precision = 0;
      return nf.format(n) + " ms";
    }
  }
  
  private static function getRpsFormatter():NumberFormatter
  {
    var rpsFormatter:NumberFormatter = new NumberFormatter();
    rpsFormatter.useThousandsSeparator = true;
    rpsFormatter.precision = 0;
    return rpsFormatter;
  }
  
  private static function getTotalTime(item:Object):Number
  {
    var totalTime:Number = item.requestTime + item.parseTime + item.renderTime;
    return totalTime;
  }

  public static function getChartDetails(item:Object):String
  {

    var s:String = "<font size='18'><b>" + item.name + "</b></font>" +
      "<br/><font size='16'><b>Rows: " + getRpsFormatter().format(item.numRows) + "</b></font>" +
      "<br/><font size='16'><b>Gzip: " + item.gzip + "</b></font>";
    
    if (getTotalTime(item) > 0)
    {
      s += "<br/><br/><font size='14'><b>" + getRpsFormatter().format((item.numRows / (getTotalTime(item)) * 1000)) + " rows/s</b></font>" + 
        "<br/><font size='12'>Request Time: " + timeFormat(item.requestTime) + "</font>" +
        "<br/><font size='12'>Parse Time: " + timeFormat(item.parseTime) + "</font>" +
        "<br/><font size='12'>Render Time: " + timeFormat(item.renderTime) + "</font>" +
        "<br/><font size='12'><b>Total Time: " + timeFormat(getTotalTime(item)) + "</b></font>" +      
        "<br/><br/><font size='14'><b>" + byteFormat(item.contentLength / item.numRows) + "/row</b></font>" +
        "<br/><font size='12'>Transfer Size: " + byteFormat(item.contentLength) + "</font>" +
        "<br/><br/><font size='12'>Client memory: " + byteFormat(item.memorySize) +"</font>";
    }
    else
    {
      s += "<br/><br/>No data yet.";
    }
    
    return s;
  }
  
  public static function getTweet(item:Object):String
  {
    return "Just benchmarked " + item.name + " - " + getRpsFormatter().format(item.numRows) + " rows in " + timeFormat(getTotalTime(item)) + "! http://jamesward.com/census";
  }
  
}
}