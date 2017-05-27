<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<talk>
  <xsl:for-each select="//ClauseUnit">
    <sentence>
    <xsl:for-each select="Bunsetsu">
      <xsl:for-each select="LUW">
        <xsl:choose>

<!--
          <xsl:when test="@LUWPOS = '名詞' and @LUWLemma = '一人'">
            &lt;LUW l_lemma="一人" l_lForm="ヒトリ" l_pos="名詞-数詞"&gt;
              &lt;SUW lemma="一" lForm="一" pos="名詞-数詞"&gt;一&lt;/SUW&gt;
              &lt;SUW lemma="人" lForm="人" pos="名詞-普通名詞-助数詞可能"&gt;人&lt;/SUW&gt;
            &lt;/LUW&gt;
          </xsl:when>
-->

          <xsl:when test="@LUWPOS = '名詞' and @LUWLemma = '自分'">
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="代名詞"&gt;
            <xsl:for-each select="SUW">
              &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
              <xsl:value-of select="@OrthographicTranscription"/>
              &lt;/SUW&gt;
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:when>

          <xsl:when test="@LUWPOS = '名詞' and SUW[1]/@SUWMiscPOSInfo1 = '固有名詞'">
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="名詞-固有名詞"&gt;
            <xsl:for-each select="SUW">
              <xsl:choose>
                <xsl:when test="@SUWMiscPOSInfo1">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>-<xsl:value-of select="@SUWMiscPOSInfo1"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:otherwise>
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:when>

          <xsl:when test="(SUW[1]/@SUWMiscPOSInfo1 = '数詞' or SUW[2]/@SUWMiscPOSInfo1 = '数詞') and (SUW[last()]/@SUWPOS = '接尾辞' or SUW[last()-1]/@SUWPOS = '接尾辞' or SUW[last()]/@SUWMiscPOSInfo1 = '数詞')">
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="名詞-数詞"&gt;
            <xsl:for-each select="SUW">
              <xsl:choose>
                <xsl:when test="@SUWPOS = '接尾辞' and not(preceding-sibling::SUW/@SUWPOS = '接尾辞')">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="名詞-普通名詞-助数詞可能"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:when test="@SUWPOS = '接尾辞' and preceding-sibling::SUW/@SUWPOS = '接尾辞' and not(@SUWLemma = '生')">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="名詞"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:when test="@SUWMiscPOSInfo1">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>-<xsl:value-of select="@SUWMiscPOSInfo1"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:otherwise>
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:when>

          <xsl:when test="@LUWPOS = '動詞' and SUW[1]/@SUWPOS = '名詞'">
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="動詞-一般"&gt;
            <xsl:for-each select="SUW">
              <xsl:choose>
                <xsl:when test="@SUWPOS = '名詞'">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="名詞-普通名詞-サ変可能"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:when test="@SUWPOS = '動詞'">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="動詞-非自立可能"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:when test="@SUWMiscPOSInfo1">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>-<xsl:value-of select="@SUWMiscPOSInfo1"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:otherwise>
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:when>


          <xsl:when test="@LUWMiscPOSInfo1">
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="<xsl:value-of select="@LUWPOS"/>-<xsl:value-of select="@LUWMiscPOSInfo1"/>"&gt;
            <xsl:for-each select="SUW">
              <xsl:choose>
                <xsl:when test="@SUWMiscPOSInfo1">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>-<xsl:value-of select="@SUWMiscPOSInfo1"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:otherwise>
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:when>

          <xsl:otherwise>
            &lt;LUW l_lemma="<xsl:value-of select="@LUWLemma"/>" l_lForm="<xsl:value-of select="@LUWDictionaryForm"/>" l_pos="<xsl:value-of select="@LUWPOS"/>"&gt;
            <xsl:for-each select="SUW">
              <xsl:choose>
                <xsl:when test="@SUWMiscPOSInfo1">
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>-<xsl:value-of select="@SUWMiscPOSInfo1"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:when>
                <xsl:otherwise>
                  &lt;SUW lemma="<xsl:value-of select="@SUWLemma"/>" pron="<xsl:value-of select="@PhoneticTranscription"/>" lForm="<xsl:value-of select="@SUWDictionaryForm"/>" pos="<xsl:value-of select="@SUWPOS"/>"&gt;
                  <xsl:value-of select="@OrthographicTranscription"/>
                  &lt;/SUW&gt;
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            &lt;/LUW&gt;
          </xsl:otherwise>

        </xsl:choose>
      </xsl:for-each>
    </xsl:for-each>
    </sentence>
  </xsl:for-each>
</talk>
</xsl:template>

</xsl:stylesheet>
