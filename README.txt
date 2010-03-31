Deployment instructions

- Update the jboss/server/default/deployers/jbossws.deployer/META-INF/jboss-beans.xml file:
<!--<property name="webServiceHost"></property>-->

- Add the Valve to jbossweb.sar/server.xml
<Engine name="jboss.web" defaultHost="localhost">
         <Valve className="com.jamesward.census2.CensusValve"/>

- Add the class files from the census2-tests/valve project to jbossweb.sar/

- Add dependency libs for the Valve to jbossweb.sar/
  apache-mime4j-0.6.jar
  httpclient-4.0.jar
  httpcore-4.0.1.jar
  httpmime-4.0.jar

- deploy census2-tests.war

- deploy census2.war
