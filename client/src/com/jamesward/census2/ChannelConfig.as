package com.jamesward.census2
{
  import flash.events.EventDispatcher;
  
  import mx.messaging.ChannelSet;
  import mx.messaging.Consumer;
  import mx.messaging.channels.AMFChannel;
  import mx.messaging.channels.StreamingAMFChannel;
  import mx.messaging.events.MessageEvent;
  import mx.rpc.events.ResultEvent;
  import mx.rpc.http.HTTPService;
  import mx.utils.UIDUtil;

  [Event(name="message",type="mx.messaging.events.MessageEvent")]

  public class ChannelConfig extends EventDispatcher
  {

    private const configUrl:String = "blazeds_config.xml";
    private const destination:String = "censusResultsDestination";

    private var consumer:Consumer;

    public var subtopic:String;
    
    public var sendCensusResultURL:String;

    public function ChannelConfig()
    {
      consumer = new Consumer();
      consumer.subtopic = subtopic = UIDUtil.createUID();
      consumer.destination = destination;

      var srv:HTTPService = new HTTPService();
      srv.url = configUrl;

      srv.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void
        {
          sendCensusResultURL = event.result.config.sendCensusResultURL;
          
          var channelSet:ChannelSet = new ChannelSet();

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

