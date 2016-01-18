package com.jamesward.census2;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class Webapp {

    public static void main(String[] args) throws Exception {

        CensusResultDAO.init();
        
        String webappDirLocation = "src/main/webapp/";

        Tomcat tomcat = new Tomcat();

        String webPort = System.getenv("PORT");
        if ((webPort == null) || webPort.isEmpty()) {
            webPort = "8080";
        }

        tomcat.setPort(Integer.valueOf(webPort));

        Context context = tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());
        
        context.getPipeline().addValve(new CensusValve());

        tomcat.getConnector().setProperty("compression", "force");
        
        tomcat.start();
        tomcat.getServer().await();
    }
    
}
