package com.jamesward.census2.core
{
  [Bindable]
  public class ResultVO
  {
    public static const USER:String = "user";
    public static const AVERAGE:String = "average";
    
    public function ResultVO(testId:String=null, numRows:Number=NaN, gzip:Boolean=false)
    {
      this.testId = testId;
      this.numRows = numRows;
      this.gzip = gzip;
    }
  
    public var testId:String;
    public var gzip:Boolean;
    public var numRows:Number = NaN;
    
    
    public var average_totalServerTime:Number = NaN;
    public var user_totalServerTime:Number = NaN;
    
    public var average_requestTime:Number = NaN;
    public var user_requestTime:Number = NaN;

    public var average_parseTime:Number = NaN;
    public var user_parseTime:Number = NaN;

    public var average_renderTime:Number = NaN; 
    public var user_renderTime:Number = NaN; 

    public var average_contentLength:Number = NaN; 
    public var user_contentLength:Number = NaN; 

    public var average_memorySize:Number = NaN;
    public var user_memorySize:Number = NaN;
  }
}