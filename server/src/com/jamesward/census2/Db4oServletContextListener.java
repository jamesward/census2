package com.jamesward.census2;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.db4o.Db4oEmbedded;
import com.db4o.ObjectContainer;
  
public class Db4oServletContextListener implements ServletContextListener
{   
  public static final String KEY_DB4O_FILE_NAME = "db4oFileName";
  public static final String KEY_DB4O_SERVER = "db4oServer";
 
  private ObjectContainer server = null;
 
  public void contextInitialized(ServletContextEvent event)
  {
     close();   
     ServletContext context = event.getServletContext();
     String filePath = context.getRealPath("WEB-INF/db/" + context.getInitParameter(KEY_DB4O_FILE_NAME));
     server = Db4oEmbedded.openFile(Db4oEmbedded.newConfiguration(), filePath);
     context.setAttribute(KEY_DB4O_SERVER, server);
     context.log("db4o startup on " + filePath);
  }   
 
  public void contextDestroyed(ServletContextEvent event)
  {   
     ServletContext context = event.getServletContext();   
     context.removeAttribute(KEY_DB4O_SERVER);   
     close();   
     context.log("db4o shutdown");
  }   
 
  private void close()
  {   
     if (server != null)
     {   
        server.close();   
     }   
     server = null;   
  }   
}