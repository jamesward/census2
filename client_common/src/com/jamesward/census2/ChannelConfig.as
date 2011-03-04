package com.jamesward.census2{
  import flash.events.Event;
  import flash.events.EventDispatcher;
  
  import mx.messaging.ChannelSet;
  import mx.messaging.Consumer;
  import mx.messaging.channels.AMFChannel;
  import mx.messaging.channels.StreamingAMFChannel;
  import mx.messaging.events.MessageEvent;
  import mx.rpc.events.ResultEvent;
  import mx.rpc.http.HTTPService;
  import mx.rpc.remoting.RemoteObject;
  import mx.utils.UIDUtil;

  [Event(name="message", type="mx.messaging.events.MessageEvent")]
  [Event(name="setup")]

  public class ChannelConfig extends EventDispatcher
  {

    private const configUrl:String = "blazeds_config.xml";
    private const consumerDestination:String = "CensusResultsDestination";
    private const remotingDestination:String = "CensusResultService";

    private var consumer:Consumer;

    public var subtopic:String;
    
    public var sendCensusResultURL:String;
    
    public var remoteObject:RemoteObject;

    public function ChannelConfig()
    {
      consumer = new Consumer();
      consumer.subtopic = subtopic = UIDUtil.createUID();
      consumer.destination = consumerDestination;

      var srv:HTTPService = new HTTPService();
      srv.url = configUrl;

      srv.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void
        {
          remoteObject = new RemoteObject(remotingDestination);
          remoteObject.endpoint = event.result.config.remotingEndpoint;
          dispatchEvent(new Event("setup"));
          
          sendCensusResultURL = event.result.config.sendCensusResultURL;
          
          var channelSet:ChannelSet = new ChannelSet();

          if (!(event.result.config.channels.channel is Array))
          {
            //trace('no array');
            event.result.config.channels.channel = new Array(event.result.config.channels.channel);
            //trace(event.result.config.channels.channel);
          }
          
          for each (var channelInfo:Object in event.result.config.channels.channel)
          {
            var channel:AMFChannel;

            if (channelInfo.type == "StreamingAMF")
            {
              channel = new StreamingAMFChannel();
            }
            else if (channelInfo.type == "PollingAMF")
            {
              channel = new AMFChannel();
            }
            else
            {
              throw new Error("Channel type not understood");
            }

            channel.id = channelInfo.id;
            channel.uri = channelInfo.endpoint;

            try
            {
              channel.pollingEnabled = new Boolean(channelInfo['polling-enabled']);
            }
            catch (e:Error)
            {
            }

            try
            {
              channel.pollingInterval = channelInfo['polling-interval-seconds'];
            }
            catch (e:Error)
            {
            }

            channelSet.addChannel(channel);
            consumer.channelSet = channelSet;
          }

          consumer.addEventListener(MessageEvent.MESSAGE, function(event:MessageEvent):void
            {
              dispatchEvent(event);
            });

          consumer.subscribe();
        });

      srv.send();
    }

  }
}