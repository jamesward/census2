package com.jamesward.census2.core
{
import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

[Bindable]
public class Model
{
  public function Model()
  {
    results = new ArrayCollection();

    tests = new ArrayCollection();
    tests.addEventListener(CollectionEvent.COLLECTION_CHANGE, updateResults);
  }

  public static function getInstance():Model
  {
      if (instance == null)
          instance = new Model();

      return instance;
  }


  public static var instance:Model;

  
  public var results:ArrayCollection;

  public var tests:ArrayCollection;

  public var selectedResult:ResultVO;
  public var selectedResultType:String;

  private var _numRows:uint;

  private var _enableGzip:Boolean;

  // make sure that there is a result for each test with the current numRows and enableGzip
  private function updateResults(event:Event=null):void
  {
    for each (var test:TestVO in tests)
    {
      getResult(test.id, numRows, enableGzip);
    }
  }

  public function getTestById(testId:String):TestVO
    {
      for each (var test:TestVO in tests)
      {
        if (test.id == testId)
        {
          return test;
        }
      }

      return null;
    }

  public function getResult(testId:String, numRows:Number, gzip:Boolean):ResultVO
    {
      for each (var result:ResultVO in Model.getInstance().results.source)
      {
        if ((result.testId == testId) && (result.numRows == numRows) && (result.gzip == gzip))
        {
          return result;
        }
      }

      var newResult:ResultVO = new ResultVO(testId, numRows, gzip);

      results.addItem(newResult);

      return newResult;
    }

  public function get numRows():uint
  {
    return _numRows;
  }

  public function set numRows(value:uint):void
  {
    _numRows = value;

    updateResults();
  }

  public function get enableGzip():Boolean
  {
    return _enableGzip;
  }

  public function set enableGzip(value:Boolean):void
  {
    _enableGzip = value;

    updateResults();
  }
}
}