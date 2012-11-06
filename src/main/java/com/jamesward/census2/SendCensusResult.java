package com.jamesward.census2;

import flex.messaging.MessageBroker;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Hashtable;


public class SendCensusResult extends HttpServlet
{
    private static final long serialVersionUID = 1962080763247784362L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String clientId = request.getParameter("clientId");
        String testId = request.getParameter("testId");
        String resultType = request.getParameter("resultType");

        String ipAddress;

        if (request.getParameter("ipAddress") != null)
        {
            ipAddress = request.getParameter("ipAddress");
        }
        else if (request.getHeader("X-Forwarded-For") != null)
        {
            ipAddress = request.getHeader("X-Forwarded-For");
        }
        else
        {
            ipAddress = request.getRemoteAddr();
        }


        Boolean gzip = false;

        if (request.getParameter("gzip").equals("true"))
        {
            gzip = true;
        }

        Integer numRows = Integer.parseInt(request.getParameter("numRows"));
        Integer resultData = Integer.parseInt(request.getParameter("resultData"));


        if ((clientId == null) || (testId == null) || (resultType == null) ||
                (resultData == null) || (gzip == null) || (numRows == null) ||
                (clientId.length() <= 0) || (testId.length() <= 0) || (resultType.length() <= 0))
        {
            throw new ServletException("data not sent correctly!");
        }
        else
        {
            CensusResult newCensusResult = new CensusResult(ipAddress, testId, resultType, resultData, gzip, numRows);

            sendResult(newCensusResult, clientId);

            //System.out.println("message sent");

            ServletOutputStream out = response.getOutputStream();
            response.setHeader("Content-Type", "text/xml");
            out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
            out.println("<resultsSent>true</resultsSent>");
            out.close();
        }
    }
    
    public static void sendResult(CensusResult censusResult, String clientId) {
        // save the results to DB

        // check for dups - only allow one entry per IP per testId per resultType
        CensusResult searchCensusResult = new CensusResult(censusResult.getIpAddress(), censusResult.getTestId(), censusResult.getResultType(), null, censusResult.getGzip(), censusResult.getNumRows());

        CensusResultDAO.deleteSimilar(searchCensusResult);
        CensusResultDAO.add(censusResult);
        
        // send result to client
        Hashtable<String, Object> body = new Hashtable<String, Object>();
        body.put("testId", censusResult.getTestId());
        body.put("resultType", censusResult.getResultType());
        body.put("resultData", censusResult.getResultData());

        AsyncMessage msg = new AsyncMessage();

        msg.setClientId(UUIDUtils.createUUID(false));

        msg.setMessageId(UUIDUtils.createUUID(false));

        msg.setHeader(AsyncMessage.SUBTOPIC_HEADER_NAME, clientId);

        msg.setDestination("CensusResultsDestination");
        msg.setTimestamp(System.currentTimeMillis());
        msg.setBody(body);

        //System.out.println("getting the message broker");

        MessageBroker mb = MessageBroker.getMessageBroker(null);

        //System.out.println("got the message broker, sending message");

        mb.routeMessageToService(msg, null);
    }

}