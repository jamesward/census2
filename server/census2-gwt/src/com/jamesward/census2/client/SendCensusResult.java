package com.jamesward.census2.client;

import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestBuilder;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.RequestException;
import com.google.gwt.http.client.Response;
import com.google.gwt.http.client.URL;

public class SendCensusResult
{
  public static void sendResult(String sendCensusResultURL, String clientId, String testId, String resultType, long resultData, Boolean gzip, Integer numRows)
  {
	String url = sendCensusResultURL + "?clientId=" + clientId +
      "&testId=" + testId +
      "&resultType=" + resultType +
      "&resultData=" + resultData +
      "&gzip=" + gzip +
      "&numRows=" + numRows;
	  
	RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, URL.encode(url));
	
	try
	{
	  Request response = builder.sendRequest(null, new RequestCallback() {
		@Override
		public void onResponseReceived(Request request, Response response)
		{
			
		}
		@Override
		public void onError(Request request, Throwable exception)
		{
			
		}
	  });
	}
	catch (RequestException e)
	{
	  
	}
	
 }
}