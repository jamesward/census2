package com.jamesward.census2.core {
import flash.events.Event;
import flash.events.EventDispatcher;
public class MessageBus extends EventDispatcher {
    private static var _instance:MessageBus;
    public static function getInstance():MessageBus {
        if (_instance == null)
            _instance = new MessageBus();
        return _instance;
    }
    public static function dispatchEvent(e:Event):void {
        getInstance().dispatchEvent(e);
    }
    public static function addEventListener(t:String,
        f:Function):void {
        getInstance().addEventListener(t,f,false,0,true);
    }
    public static function removeEventListener(t:String,
        f:Function):void {
        getInstance().removeEventListener(t,f);
    }
}
}