Deployment instructions

- Update the jboss/server/default/deployers/jbossws.deployer/META-INF/jboss-beans.xml file:
<!--<property name="webServiceHost"></property>-->

- Add the Valves to jbossweb.sar/server.xml
<Engine name="jboss.web" defaultHost="localhost">
         <Valve className="com.jamesward.census2.CensusValve"/>

- Update the Connector in the jbossweb.sar/server.xml
<Connector protocol="HTTP/1.1" port="8080" address="${jboss.bind.address}"
               connectionTimeout="20000" redirectPort="8443" compression="force"
                maxThreads="500" minSpareThreads="100" maxSpareThreads="75"
                proxyName="www.jamesward.com" proxyPort="80"/>

- Add the class files from the census2-tests/valve project to jbossweb.sar/

- Add dependency libs for the Valve to jbossweb.sar/
  apache-mime4j-0.6.jar
  httpclient-4.0.jar
  httpcore-4.0.1.jar
  httpmime-4.0.jar

- deploy census2-tests.war

- deploy census2.war

- update the deploy/census2.war/tests.xml file

- update the deploy/census2.war/blazeds_config.xml file
