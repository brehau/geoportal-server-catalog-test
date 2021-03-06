<?xml version="1.0" encoding="UTF-8"?>
<!--
 See the NOTICE file distributed with
 this work for additional information regarding copyright ownership.
 Esri Inc. licenses this file to You under the Apache License, Version 2.0
 (the "License"); you may not use this file except in compliance with
 the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no"/>
	<xsl:template match="/">
		<xsl:element name="csw:GetRecords" use-attribute-sets="GetRecordsAttributes" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:ogc="http://www.opengis.net/ogc" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:gml="http://www.opengis.net/gml">
			<csw:Query typeNames="csw:Record">
				<csw:ElementSetName>summary</csw:ElementSetName>
				<csw:Constraint version="1.1.0">
					<ogc:Filter xmlns="http://www.opengis.net/ogc">
						<xsl:choose>
							<xsl:when test="count(/GetRecords/KeyWord) + count(/GetRecords/FromDate) > 1">
								<ogc:And>
									<!-- Key Word search -->
									<xsl:apply-templates select="/GetRecords/KeyWord"/>
									<!-- LiveDataOrMaps search -->
									<!-- xsl:apply-templates select="/GetRecords/LiveDataMap"/ -->
									<!-- Envelope search, e.g. ogc:BBOX -->
									<!-- xsl:apply-templates select="/GetRecords/Envelope"/ -->
								</ogc:And>
							</xsl:when>
							<xsl:otherwise>
								<!-- only one criterion is given, do not include enclosing ogc:And elements -->
								
								<!-- Key Word search -->
								<xsl:apply-templates select="/GetRecords/KeyWord"/>
								<!-- LiveDataOrMaps search -->
								<!-- xsl:apply-templates select="/GetRecords/LiveDataMap"/ -->
								<!-- Envelope search, e.g. ogc:BBOX -->
								<!-- xsl:apply-templates select="/GetRecords/Envelope"/ -->
							</xsl:otherwise>
						</xsl:choose>
					</ogc:Filter>
				</csw:Constraint>
			</csw:Query>
		</xsl:element>
	</xsl:template>
	<!-- key word search -->
	<xsl:template match="/GetRecords/KeyWord" xmlns:ogc="http://www.opengis.net/ogc">
		<xsl:if test="normalize-space(.)!=''">
			<ogc:PropertyIsLike wildCard="*" escapeChar="-" singleChar="%">
				<ogc:PropertyName>AnyText</ogc:PropertyName>
				<ogc:Literal>
					<xsl:value-of select="."/>
				</ogc:Literal>
			</ogc:PropertyIsLike>
		</xsl:if>
	</xsl:template>
	<!-- LiveDataOrMaps search -->
	<xsl:template match="/GetRecords/LiveDataMap" xmlns:ogc="http://www.opengis.net/ogc">
		<xsl:if test="translate(normalize-space(./text()),'true', 'TRUE') ='TRUE'">
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>Format</ogc:PropertyName>
				<ogc:Literal>liveData</ogc:Literal>
			</ogc:PropertyIsEqualTo>
		</xsl:if>
	</xsl:template>
	<!-- envelope search -->
	<xsl:template match="/GetRecords/Envelope" xmlns:ogc="http://www.opengis.net/ogc">
		<!-- generate BBOX query if minx, miny, maxx, maxy are provided -->
		<xsl:if test="./MinX and ./MinY and ./MaxX and ./MaxY">
			<ogc:BBOX xmlns:gml="http://www.opengis.net/gml">
				<ogc:PropertyName>Geometry</ogc:PropertyName>
				<gml:Envelope srsName="http://www.opengis.net/gml/srs/epsg.xml#63266405">
					<gml:lowerCorner><xsl:value-of select="translate(MinX, ',', '.')"/>,<xsl:value-of select="translate(MinY, ',', '.')"/></gml:lowerCorner>
					<gml:upperCorner><xsl:value-of select="translate(MaxX, ',', '.')"/>,<xsl:value-of select="translate(MaxY, ',', '.')"/></gml:upperCorner>					
				</gml:Envelope>
			</ogc:BBOX>
		</xsl:if>
	</xsl:template>
	<!--
    <xsl:attribute-set name="GetRecordsAttributes">
		<xsl:attribute name="version">2.0.0</xsl:attribute>
		<xsl:attribute name="service">CSW</xsl:attribute>
		<xsl:attribute name="resultType">RESULTS</xsl:attribute>
		<xsl:attribute name="startPosition"><xsl:value-of select="/GetRecords/StartPosition"/></xsl:attribute>
		<xsl:attribute name="maxRecords"><xsl:value-of select="/GetRecords/MaxRecords"/></xsl:attribute>
		<xsl:attribute name="outputSchema">csw:Record</xsl:attribute>
	</xsl:attribute-set>
    -->
	<xsl:attribute-set name="GetRecordsAttributes">
		<xsl:attribute name="version">2.0.2</xsl:attribute>
		<xsl:attribute name="service">CSW</xsl:attribute>
		<xsl:attribute name="resultType">RESULTS</xsl:attribute>
		<xsl:attribute name="startPosition"><xsl:value-of select="/GetRecords/StartPosition"/></xsl:attribute>
		<xsl:attribute name="maxRecords"><xsl:value-of select="/GetRecords/MaxRecords"/></xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
