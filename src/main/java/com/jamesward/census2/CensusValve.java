package com.jamesward.census2;

import org.apache.catalina.Valve;
import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.catalina.valves.ValveBase;
import org.apache.coyote.http11.InternalAprOutputBuffer;
import org.apache.coyote.http11.InternalOutputBuffer;
import org.apache.coyote.http11.OutputFilter;
import org.apache.coyote.http11.filters.GzipOutputFilter;

import javax.servlet.ServletException;
import java.io.IOException;

public class CensusValve extends ValveBase implements Valve
{
    public void invoke(Request request, Response response) throws IOException, ServletException
    {
        // early exit if not a request for data
        if (!request.getServletPath().endsWith("CensusServiceServlet"))
        {
            getNext().invoke(request, response);
            return;
        }
        
        long contentLength = 0;

        String sendCensusResultURL = request.getParameter("sendCensusResultURL");
        String clientId = request.getParameter("clientId");
        String testId = request.getParameter("testId");
        Boolean gzip = false;

        if ((request.getParameter("gzip") != null) && (request.getParameter("gzip").equals("true")))
        {
            gzip = true;
        }

        // make sure the response doesn't get gzipped if this is a test that is not supposed to be gzipped
        if (!gzip && request.getServletPath().endsWith("CensusServiceServlet"))
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
                                contentLength = response.getContentLength();
                                //contentLength = response.getContentCountLong();
                            }
                        }
                        catch (Exception e)
                        {
                            contentLength = response.getContentLength();
                            //contentLength = response.getContentCountLong();
                        }
                    }
                }
            }
            else
            {
                contentLength = response.getContentWritten();
                //contentLength = response.getContentCountLong();
            }

            long execTime = System.currentTimeMillis() - startTime;

            try
            {
                Integer numRows = Integer.parseInt(request.getParameter("rows"));
                SendCensusResult.sendResult(new CensusResult(ipAddress, testId, "totalServerTime", (int) execTime, gzip, numRows), clientId);
                SendCensusResult.sendResult(new CensusResult(ipAddress, testId, "contentLength", (int) contentLength, gzip, numRows),clientId);
            }
            catch (Exception e)
            {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }

        }

    }
}