package com.jamesward.census2;

import java.io.IOException;

import javax.servlet.ServletException;

import org.apache.catalina.Valve;
import org.apache.catalina.valves.ValveBase;
import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.coyote.OutputBuffer;
import org.apache.coyote.http11.InternalAprOutputBuffer;
import org.apache.coyote.http11.InternalOutputBuffer;
import org.apache.coyote.http11.OutputFilter;
import org.apache.coyote.http11.filters.GzipOutputFilter;

public class CensusValve extends ValveBase implements Valve
{
    public void invoke(Request request, Response response) throws IOException, ServletException
    {
        /*

        long contentLength = 0;

        String sendCensusResultURL = request.getParameter("sendCensusResultURL");
        String clientId = request.getParameter("clientId");
        String testId = request.getParameter("testId");
        Boolean gzip = false;

        if ((request.getParameter("gzip") != null) && (request.getParameter("gzip").equals("true")))
        {
            gzip = true;
        }

        if ( !gzip || (request.getParameter("resultType") != null) || (!request.getContextPath().equals("/census2-tests")) )
        {
            request.getCoyoteRequest().getMimeHeaders().removeHeader("accept-encoding");
        }

        long startTime = System.currentTimeMillis();

        getNext().invoke(request, response);

        if ( (request.getParameter("rows") != null) && (clientId != null) &&
                (testId != null) && (sendCensusResultURL != null) )
        {
            String ipAddress;

            if (request.getHeader("X-Forwarded-For") != null)
            {
                ipAddress = request.getHeader("X-Forwarded-For");
            }
            else
            {
                ipAddress = request.getRemoteAddr();
            }

            if (gzip)
            {
                response.flushBuffer();
                //((org.apache.coyote.http11.InternalOutputBuffer)response.getCoyoteResponse().getOutputBuffer()).flush();

                OutputFilter[] filters;

                if (response.getCoyoteResponse().getOutputBuffer() instanceof InternalOutputBuffer)
                {
                    filters = ((InternalOutputBuffer)response.getCoyoteResponse().getOutputBuffer()).getFilters();
                }
                else if (response.getCoyoteResponse().getOutputBuffer() instanceof InternalAprOutputBuffer)
                {
                    filters = ((InternalAprOutputBuffer)response.getCoyoteResponse().getOutputBuffer()).getFilters();
                }
                else
                {
                    return;
                }

                for (int i = 0; i < filters.length; i++)
                {
                    if (filters[i] instanceof GzipOutputFilter)
                    {
                        try
                        {
                            contentLength = ((GzipOutputFilter)filters[i]).getBytesWritten();
                            if (contentLength == 0)
                            {
                                contentLength = response.getContentCountLong();
                            }
                        }
                        catch (Exception e)
                        {
                            contentLength = response.getContentCountLong();
                        }
                    }
                }
            }
            else
            {
                contentLength = response.getContentCountLong();
            }

            long execTime = System.currentTimeMillis() - startTime;

            try
            {
                Integer numRows = Integer.parseInt(request.getParameter("rows"));

                SendCensusResult.sendResult(sendCensusResultURL, clientId, testId, "totalServerTime", execTime, gzip, numRows, ipAddress);
                SendCensusResult.sendResult(sendCensusResultURL, clientId, testId, "contentLength", contentLength, gzip, numRows, ipAddress);
            }
            catch (Exception e)
            {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }

        }
        */

    }
}