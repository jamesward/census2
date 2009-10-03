package com.jamesward.census2;

import java.io.IOException;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import flex.messaging.MessageBroker;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

public class SendCensusResult extends HttpServlet
{
  private static final long serialVersionUID = 1962080763247784362L;

  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
  {
    String clientId = request.getParameter("clientId");
    String testId = request.getParameter("testId");
    String resultType = request.getParameter("resultType");
    Integer resultData = Integer.parseInt(request.getParameter("resultData"));

    if ((clientId == null) || (testId == null) || (resultType == null)
        || (resultData == null) || (clientId.length() <= 0)
        || (testId.length() <= 0) || (resultType.length() <= 0))
    {
      throw new ServletException("data not sent correctly!");
    }
    else
    {
      Hashtable<String, Object> body = new Hashtable<String, Object>();
      body.put("testId", testId);
      body.put("resultType", resultType);
      body.put("resultData", resultData);

      AsyncMessage msg = new AsyncMessage();

      msg.setClientId(UUIDUtils.createUUID(false));

      msg.setMessageId(UUIDUtils.createUUID(false));

      msg.setHeader(AsyncMessage.SUBTOPIC_HEADER_NAME, clientId);

      msg.setDestination("censusResultsDestination");
      msg.setTimestamp(System.currentTimeMillis());
      msg.setBody(body);

      System.out.println("getting the message broker");

      MessageBroker mb = MessageBroker.getMessageBroker(null);

      System.out.println("got the message broker, sending message");

      mb.routeMessageToService(msg, null);

      System.out.println("message sent");
      
      ServletOutputStream out = response.getOutputStream();
      response.setHeader("Content-Type", "text/xml");
      out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
      out.println("<resultsSent>true</resultsSent>");
      out.close();
    }
  }
}