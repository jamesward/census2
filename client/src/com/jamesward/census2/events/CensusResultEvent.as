/**
 * Created by IntelliJ IDEA.
 * User: jamesw
 * Date: 11/9/10
 * Time: 10:12 AM
 * To change this template use File | Settings | File Templates.
 */
package com.jamesward.census2.events {
import com.jamesward.census2.core.ResultVO;

import flash.events.Event;

public class CensusResultEvent extends Event {

  public static const RESULT_RECEIVED:String = "resultReceived";

  public var result:ResultVO;

  public function CensusResultEvent(type:String, result:ResultVO) {
    this.result = result;
    super(type);
  }
}
}