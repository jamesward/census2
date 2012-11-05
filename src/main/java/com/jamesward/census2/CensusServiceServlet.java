/*
Copyright (C) 2007 James Ward
http://www.jamesward.org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

package com.jamesward.census2;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jamesward.census2.shared.CensusEntryVO;

import net.sf.json.JSONArray;
import flex.messaging.io.MessageIOConstants;
import flex.messaging.io.SerializationContext;
import flex.messaging.io.amf.ActionMessage;
import flex.messaging.io.amf.AmfMessageSerializer;
import flex.messaging.io.amf.AmfTrace;
import flex.messaging.io.amf.MessageBody;

public class CensusServiceServlet extends HttpServlet
{

  private static final long serialVersionUID = 6356748329799174984L;
  
  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
        
    try
    {
      ConnectionManager.createConnection(config.getServletContext().getRealPath("/"));
      Connection c = ConnectionManager.getConnection();
      c.commit();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public void destroy()
  {
    try
    {
      Connection c = ConnectionManager.getConnection();
      ConnectionManager.closeConnection(c);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    doPost(request,response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    String command = request.getParameter("command");
    int rows = 1000;
    if (request.getParameter("rows") != null)
    {
      rows = Integer.parseInt(request.getParameter("rows"));
    }
    
    //String sendCensusResultURL = request.getParameter("sendCensusResultURL");
    //String clientId = request.getParameter("clientId");
    //String testId = request.getParameter("testId");
    //Boolean gzip = false;
    
    //if ((request.getParameter("gzip") != null) && (request.getParameter("gzip").equals("true")))
    //{
    //  gzip = true;
    //}
    
    //long startTime = System.currentTimeMillis();

    CensusService srv = new CensusService();
    CensusEntryVO[] list = srv.getElements(0, rows);
    
    //SendCensusResult.sendResult(sendCensusResultURL, clientId, testId, "dataFetchTime", (System.currentTimeMillis() - startTime), gzip, rows);
    
    //startTime = System.currentTimeMillis();

    if (command.equals("getHTML"))
    {
      outputHTML(list,response);
    }
    else if (command.equals("getXML"))
    {
      outputXML(list,response);
    }
    else if (command.equals("getJSON"))
    {
      outputJSON(list,response);
    }
    else if (command.equals("getAMF3"))
    {
      outputAMF3(list, response);
    }
    else
    {
      throw new ServletException("command not set correctly!");
    }
    
    //SendCensusResult.sendResult(sendCensusResultURL, clientId, testId, "serializationTime", (System.currentTimeMillis() - startTime), gzip, rows);
  }

  private void outputHTML(CensusEntryVO[] list, HttpServletResponse response) throws IOException
  {
    ServletOutputStream out = response.getOutputStream();

    out.println("<table id=\"myTable\" width=\"100%\" cellpadding=\"4\" cellspacing=\"0\">");
    for (int i=0; i<list.length; i++)
    {
      CensusEntryVO vo = list[i];
      out.println("<tr onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)'>");
      out.println("<td class=\"cell\">" + vo.getId() + "</td>");
      out.println("<td class=\"cell\">" + vo.getAge() + "</td>");
      out.println("<td class=\"cell\">" + vo.getClassOfWorker() + "</td>");
      out.println("<td class=\"cell\">" + vo.getEducation() + "</td>");
      out.println("<td class=\"cell\">" + vo.getMaritalStatus() + "</td>");
      out.println("<td class=\"cell\">" + vo.getRace() + "</td>");
      out.println("<td class=\"cell\">" + vo.getSex() + "</td>");
      out.println("</tr>");
    }
    out.println("</table>");
    out.close();
  }

  private void outputXML(CensusEntryVO[] list, HttpServletResponse response) throws IOException
  {
    response.setHeader("Content-Type", "text/xml");
    ServletOutputStream out = response.getOutputStream();
    out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
    out.println("<list>");

    for (int i=0; i<list.length; i++)
    {
      CensusEntryVO vo = list[i];
      out.println("<item>");
      out.println("<itemId>" + vo.getId() + "</itemId>");
      out.println("<age>" + vo.getAge() + "</age>");
      out.println("<classOfWorker>" + vo.getClassOfWorker() + "</classOfWorker>");
      out.println("<education>" + vo.getEducation() + "</education>");
      out.println("<maritalStatus>" + vo.getMaritalStatus() + "</maritalStatus>");
      out.println("<race>" + vo.getRace() + "</race>");
      out.println("<sex>" + vo.getSex() + "</sex>");
      out.println("</item>");
    }
    out.println("</list>");
    out.close();
  }

  private void outputJSON(CensusEntryVO[] list, HttpServletResponse response) throws IOException
  {
    ServletOutputStream out = response.getOutputStream();
    JSONArray jsonArray = JSONArray.fromObject(list);
    out.print("{\"items\":" + jsonArray.toString() + "}");
    out.close();
  }
  
  private void outputAMF3(CensusEntryVO[] list, HttpServletResponse response) throws IOException
  {
    response.setHeader("Content-Type", "application/x-amf");
    ServletOutputStream out = response.getOutputStream();
        
    ActionMessage requestMessage = new ActionMessage(MessageIOConstants.AMF3);
    
    MessageBody amfMessage = new MessageBody();
    amfMessage.setData(list);
    requestMessage.addBody(amfMessage);
    
    AmfMessageSerializer amfMessageSerializer = new AmfMessageSerializer();
    amfMessageSerializer.initialize(SerializationContext.getSerializationContext(), out, new AmfTrace());
    amfMessageSerializer.writeMessage(requestMessage);
    
    out.close();
  }

}