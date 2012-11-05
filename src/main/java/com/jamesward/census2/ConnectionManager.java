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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager
{

  private String url;

  private static ConnectionManager instance;

  public String getUrl()
  {
    return url;
  }
  
  public void setUrl(String url)
  {
    this.url = url;
  }

  private ConnectionManager()
  {
    try
    {
      Class.forName("org.hsqldb.jdbcDriver");
    }
    catch (Exception e)
    {
      
    }
  }

  public static ConnectionManager getInstance()
  {
    if (instance == null)
      instance = new ConnectionManager();
    return instance;
  }
  
  public static void createConnection(String path)
  {
    getInstance().setUrl("jdbc:hsqldb:" + path + "WEB-INF/db/census/census");
  }

  public static Connection getConnection() throws SQLException
  {
    return DriverManager.getConnection(getInstance().getUrl());
  }

  public static void closeConnection(Connection c)
  {
    try
    {
      c.close();
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
  }

}
