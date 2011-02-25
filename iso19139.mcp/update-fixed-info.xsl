<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
						xmlns:gml="http://www.opengis.net/gml"
						xmlns:srv="http://www.isotc211.org/2005/srv"
						xmlns:gmx="http://www.isotc211.org/2005/gmx"
						xmlns:gco="http://www.isotc211.org/2005/gco"
						xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
						xmlns:xlink="http://www.w3.org/1999/xlink"
						xmlns:mcp="http://bluenet3.antcrc.utas.edu.au/mcp"
						xmlns:gmd="http://www.isotc211.org/2005/gmd">

	<xsl:include href="convert/functions.xsl"/>

	<!-- ================================================================= -->
	
	<xsl:template match="/root">
		 <xsl:apply-templates select="mcp:MD_Metadata"/>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="mcp:MD_Metadata">
		 <xsl:copy>
		 	<xsl:copy-of select="@*[name(.)!='xsi:schemaLocation']"/>
			<xsl:attribute name="xsi:schemaLocation">http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd http://bluenet3.antcrc.utas.edu.au/mcp http://bluenet3.antcrc.utas.edu.au/mcp/schema.xsd</xsl:attribute>
		 	<xsl:choose>
				<xsl:when test="not(gmd:fileIdentifier)">
		 			<gmd:fileIdentifier>
						<gco:CharacterString><xsl:value-of select="/root/env/uuid"/></gco:CharacterString>
					</gmd:fileIdentifier>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="gmd:fileIdentifier"/>
				</xsl:otherwise>
			</xsl:choose>
      <xsl:apply-templates select="gmd:language"/>
      <xsl:apply-templates select="gmd:characterSet"/>
      <xsl:apply-templates select="gmd:parentIdentifier"/>
      <xsl:apply-templates select="gmd:hierarchyLevel"/>
      <xsl:apply-templates select="gmd:hierarchyLevelName"/>
      <xsl:apply-templates select="gmd:contact"/>
      <xsl:apply-templates select="gmd:dateStamp"/>
      <xsl:apply-templates select="gmd:metadataStandardName"/>
      <xsl:apply-templates select="gmd:metadataStandardVersion"/>
      <xsl:apply-templates select="gmd:dataSetURI"/>
      <xsl:apply-templates select="gmd:locale"/>
      <xsl:apply-templates select="gmd:spatialRepresentationInfo"/>
      <xsl:apply-templates select="gmd:referenceSystemInfo"/>
      <xsl:apply-templates select="gmd:metadataExtensionInfo"/>
      <xsl:apply-templates select="gmd:identificationInfo"/>
			<xsl:apply-templates select="gmd:contentInfo"/>
			<xsl:choose>
				<xsl:when test="not(gmd:distributionInfo)">
					<gmd:distributionInfo>
						<gmd:MD_Distribution>
							<gmd:transferOptions>
								<gmd:MD_DigitalTransferOptions>
									<xsl:call-template name="addMetadataURL"/>
								</gmd:MD_DigitalTransferOptions>
							</gmd:transferOptions>
						</gmd:MD_Distribution>
					</gmd:distributionInfo>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="gmd:distributionInfo"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="gmd:dataQualityInfo"/>
      <xsl:apply-templates select="gmd:portrayalCatalogueInfo"/>
      <xsl:apply-templates select="gmd:metadataConstraints"/>
      <xsl:apply-templates select="gmd:applicationSchemaInfo"/>
      <xsl:apply-templates select="gmd:metadataMaintenance"/>
      <xsl:apply-templates select="gmd:series"/>
      <xsl:apply-templates select="gmd:describes"/>
      <xsl:apply-templates select="gmd:propertyType"/>
      <xsl:apply-templates select="gmd:featureType"/>
      <xsl:apply-templates select="gmd:featureAttribute"/>
			<xsl:choose>
				<xsl:when test="not(mcp:revisionDate)">
					<mcp:revisionDate>
						<gco:DateTime><xsl:value-of select="/root/env/changeDate"/></gco:DateTime>
					</mcp:revisionDate>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="mcp:revisionDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="gmd:MD_Distribution">
		 <xsl:copy>
		 		<xsl:copy-of select="@*"/>
      	<xsl:apply-templates select="gmd:distributionFormat"/>
      	<xsl:apply-templates select="gmd:distributor"/>
				<xsl:choose>
					<xsl:when test="not(gmd:transferOptions)">
						<gmd:transferOptions>
							<gmd:MD_DigitalTransferOptions>
								<xsl:call-template name="addMetadataURL"/>
							</gmd:MD_DigitalTransferOptions>
						</gmd:transferOptions>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="gmd:transferOptions"/>
					</xsl:otherwise>
				</xsl:choose>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="gmd:fileIdentifier" priority="10">
		<xsl:copy>
			<gco:CharacterString><xsl:value-of select="/root/env/uuid"/></gco:CharacterString>
		</xsl:copy>
	</xsl:template>
	
	<!-- ================================================================= -->
	
	<xsl:template match="mcp:revisionDate" priority="10">
		<xsl:copy>
			<gco:DateTime><xsl:value-of select="/root/env/changeDate"/></gco:DateTime>
		</xsl:copy>
	</xsl:template>
	
	<!-- ================================================================= -->
	
	<xsl:template match="gmd:metadataStandardName" priority="10">
		<xsl:copy>
			<gco:CharacterString>Australian Marine Community Profile of ISO 19115:2005/19139</gco:CharacterString>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="gmd:metadataStandardVersion" priority="10">
		<xsl:copy>
			<gco:CharacterString>MCP:BlueNet V1.5</gco:CharacterString>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="mcp:MD_CreativeCommons" priority="10">
		<mcp:MD_Commons mcp:commonsType="Creative Commons" gco:isoType="gmd:MD_Constraints">
			<xsl:copy-of select="*"/>
		</mcp:MD_Commons>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="mcp:MD_DataCommons" priority="10">
		<mcp:MD_Commons mcp:commonsType="Data Commons" gco:isoType="gmd:MD_Constraints">
			<xsl:copy-of select="*"/>
		</mcp:MD_Commons>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="gmd:dateStamp">
		<xsl:choose>
			<xsl:when test="/root/env/updateDateStamp='yes'">
				<gmd:dateStamp>
					<gco:DateTime><xsl:value-of select="/root/env/changeDate"/></gco:DateTime>
				</gmd:dateStamp>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="gmd:languageCode[gmd:LanguageCode/@codeList]" priority="10">
		 <xsl:copy>
		 	<gmd:LanguageCode codeList="http://www.isotc211.org/2005/resources/Codelist/ML_gmxCodelists.xml#LanguageCode" codeListValue="eng">English</gmd:LanguageCode>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="gmd:country[gmd:Country/@codeList]" priority="10">
		 <xsl:copy>
		 	<gmd:Country codeList="http://www.isotc211.org/2005/resources/Codelist/ML_gmxCodelists.xml#Country" codeListValue="AU">Australia</gmd:Country>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template match="@gml:id">
		<xsl:choose>
			<xsl:when test="normalize-space(.)=''">
				<xsl:attribute name="gml:id">
					<xsl:value-of select="generate-id(.)"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ==================================================================== -->
	<!-- Fix srsName attribute generate CRS:84 (long/lat ordering) by default -->

	<xsl:template match="@srsName">
		<xsl:choose>
			<xsl:when test="normalize-space(.)=''">
				<xsl:attribute name="srsName">
					<xsl:text>CRS:84</xsl:text>
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ================================================================= -->
	
	<xsl:template match="*[gco:CharacterString]">
		<xsl:copy>
			<xsl:copy-of select="@*[not(name()='gco:nilReason')]"/>
			<xsl:if test="normalize-space(gco:CharacterString)=''">
				<xsl:attribute name="gco:nilReason">
					<xsl:value-of select="'missing'"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="gco:CharacterString"/>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	<!-- codelists: set @codeList path -->
	<!-- ================================================================= -->
	
	<xsl:template match="gmd:*[@codeListValue]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="codeList">
				<xsl:value-of select="concat('http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#',local-name(.))"/>
			</xsl:attribute>
			<xsl:value-of select="@codeListValue"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mcp:*[@codeListValue]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="codeList">
				<xsl:value-of select="concat('http://bluenet3.antcrc.utas.edu.au/mcp/resources/Codelist/gmxCodelists.xml#',local-name(.))"/>
			</xsl:attribute>
			<xsl:value-of select="@codeListValue"/>
		</xsl:copy>
	</xsl:template>

	<!-- can't find official location of the 19119 codelists - so use local -->

	<xsl:template match="srv:*[@codeListValue]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="codeList">
				<xsl:value-of select="concat(/root/env/baseURL,'/web/geonetwork/xml/schemas/iso19139.mcp/schema/resources/Codelist/gmxCodelists.xml#',local-name(.))"/>
			</xsl:attribute>
			<xsl:value-of select="@codeListValue"/>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	<!-- online resources: metadata URL -->
	<!-- ================================================================= -->

	<!-- test and see whether we need to add a metadata URL to the
			 distributionInfo -->
	     
	<xsl:template match="gmd:transferOptions[ancestor::gmd:distributionInfo and position()=1]/gmd:MD_DigitalTransferOptions">
		<xsl:copy>
		 	<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="gmd:unitsOfDistribution"/>
			<xsl:apply-templates select="gmd:transferSize"/>
			<xsl:choose>
				<xsl:when test="not(gmd:onLine)">
						<xsl:call-template name="addMetadataURL"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- find out whether we need to add the METADATA URL -->
					<xsl:if test="not(../..//gmd:protocol[starts-with(gco:CharacterString,'WWW:LINK-') and contains(gco:CharacterString,'metadata-URL')])">
						<xsl:call-template name="addMetadataURL"/>
					</xsl:if>
					<!-- process the onLine blocks anyway -->
					<xsl:apply-templates select="gmd:onLine"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="gmd:offLine"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="gmd:CI_OnlineResource[starts-with(gmd:protocol/gco:CharacterString,'WWW:LINK-') and contains(gmd:protocol/gco:CharacterString,'metadata-URL') and ancestor::gmd:distributionInfo]" priority="20">
		<xsl:copy>
			<xsl:call-template name="addMetadataURLInternals"/>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	<!-- online resources: download -->
	<!-- ================================================================= -->

	<xsl:template match="gmd:CI_OnlineResource[starts-with(gmd:protocol/gco:CharacterString,'WWW:DOWNLOAD-') and contains(gmd:protocol/gco:CharacterString,'http--download') and gmd:name]">
		<xsl:variable name="fname" select="gmd:name/gco:CharacterString|gmd:name/gmx:MimeFileType"/>
		<xsl:variable name="mimeType">
			<xsl:call-template name="getMimeTypeFile">
				<xsl:with-param name="datadir" select="/root/env/datadir"/>
				<xsl:with-param name="fname" select="$fname"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<gmd:linkage>
				<gmd:URL>
					<xsl:choose>
						<xsl:when test="/root/env/config/downloadservice/simple='true' or contains(gmd:protocol/gco:CharacterString,'direct')">
							<xsl:value-of select="concat(/root/env/siteURL,'/resources.get?id=',/root/env/id,'&amp;fname=',$fname,'&amp;access=private')"/>
						</xsl:when>
						<xsl:when test="/root/env/config/downloadservice/withdisclaimer='true'">
							<xsl:value-of select="concat(/root/env/siteURL,'/file.disclaimer?id=',/root/env/id,'&amp;fname=',$fname,'&amp;access=private')"/>
						</xsl:when>
						<xsl:otherwise> <!-- /root/env/config/downloadservice/leave='true' -->
							<xsl:value-of select="gmd:linkage/gmd:URL"/>
						</xsl:otherwise>
					</xsl:choose>
				</gmd:URL>
			</gmd:linkage>
			<xsl:copy-of select="gmd:protocol"/>
			<xsl:copy-of select="gmd:applicationProfile"/>
			<gmd:name>
				<gmx:MimeFileType type="{$mimeType}">
					<xsl:value-of select="$fname"/>
				</gmx:MimeFileType>
			</gmd:name>
			<xsl:copy-of select="gmd:description"/>
			<xsl:copy-of select="gmd:function"/>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	<!-- online resources: link-to-downloadable data etc -->
	<!-- ================================================================= -->

	<xsl:template match="gmd:CI_OnlineResource[starts-with(gmd:protocol/gco:CharacterString,'WWW:LINK-') and contains(gmd:protocol/gco:CharacterString,'http--download')]">
		<xsl:variable name="mimeType">
			<xsl:call-template name="getMimeTypeUrl">
				<xsl:with-param name="linkage" select="gmd:linkage/gmd:URL"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:copy-of select="gmd:linkage"/>
			<xsl:copy-of select="gmd:protocol"/>
			<xsl:copy-of select="gmd:applicationProfile"/>
			<gmd:name>
				<gmx:MimeFileType type="{$mimeType}"/>
			</gmd:name>
			<xsl:copy-of select="gmd:description"/>
			<xsl:copy-of select="gmd:function"/>
		</xsl:copy>
	</xsl:template>

	<!-- =================================================================-->
	
	<xsl:template match="gmx:FileName">
		<xsl:copy>
			<xsl:attribute name="src">
				<xsl:value-of select="concat(/root/env/siteURL,'/resources.get?id=',/root/env/id,'&amp;fname=',.,'&amp;access=private')"/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="@*|node()">
		 <xsl:copy>
			  <xsl:apply-templates select="@*|node()"/>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

	<xsl:template name="addMetadataURL">
		<gmd:onLine>
			<gmd:CI_OnlineResource>
				<xsl:call-template name="addMetadataURLInternals"/>
			</gmd:CI_OnlineResource>
		</gmd:onLine>
	</xsl:template>

	<!-- ================================================================= -->
		
	<xsl:template name="addMetadataURLInternals">
		<gmd:linkage>
			<gmd:URL>
				<xsl:value-of select="concat(/root/env/siteURL,'/metadata.show?uuid=',/root/env/uuid)"/>
			</gmd:URL>
		</gmd:linkage>
		<gmd:protocol>
			<gco:CharacterString>WWW:LINK-1.0-http--metadata-URL</gco:CharacterString>
		</gmd:protocol>
		<gmd:description>
			<gco:CharacterString>Point of truth URL of this metadata record</gco:CharacterString>
		</gmd:description>
	</xsl:template>

</xsl:stylesheet>