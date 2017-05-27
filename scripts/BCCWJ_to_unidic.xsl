<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

<xsl:template match="//sentence">
  <xsl:apply-templates select="LUW/SUW | LUW/NumTrans" />
  <xsl:text>EOS
</xsl:text>
</xsl:template>

<xsl:template match="NumTrans">
  <xsl:value-of select="@originalText"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="@originalText"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="@originalText"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="@originalText"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="SUW[1]/@pos"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="SUW[1]/@cType"/>
  <xsl:text>	</xsl:text>
  <xsl:value-of select="SUW[1]/@cForm"/>
  <xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="SUW">
  <xsl:choose>
    <xsl:when test="not(@pos='空白')">
      <xsl:value-of select="."/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@pron"/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@lForm"/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@lemma"/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@pos"/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@cType"/>
      <xsl:text>	</xsl:text>
      <xsl:value-of select="@cForm"/>
      <xsl:text>
</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
