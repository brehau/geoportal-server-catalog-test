
# How to setup geoportal from scratch (Windows)

## Install necessary software

1. Install AdoptOpenJDK 11

2. Install Elasticsearch (7.x or higher)

3. Install Tomcat 9.x

4. Install Maven

	1. Download and unzip into a stable directory
	2. Set MAVEN_HOME environment variable to above directory
	3. Add above MAVEN_HOME/bin to PATH environment variable

## Build

1. Download and unzip https://github.com/Esri/geoportal-server-catalog to a local folder. Or you can download and unzip the customized version of geoportal used in this repository. Cd into the downloaded folder. 

2. Build the files in the geoportal folder

		>>> cd "geoportal"
		>>> mvn clean install

3. Build the files in the geoportal-search folder

		>>> cd "geoportal-search"
		>>> mvn clean install

4. Copy all the folder/target/*.war files built by Maven in steps 2-3 into the "Tomcat 9.0/webapps" folder

## Test

1. Start the Tomcat server

		>>> cd "C:/Program Files/Apache Software Foundation/Tomcat 9.0/bin"
		>>> startup

2. Start the ElasticSearch server

		>>> "C:/Program Files/Elasticsearch/elasticsearch-7.9.3/bin/elasticsearch.bat"

3. Go to http://localhost:8080/geoportal/


