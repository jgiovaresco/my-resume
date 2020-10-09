<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns="http://www.giovaresco.fr/resume"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cv="http://www.giovaresco.fr/resume"
	>

	<xsl:output method="text" indent="no" />

	<xsl:template match="/">
\documentclass[a4paper,11pt,sans]{moderncv}
\moderncvstyle{casual}                             % style options are 'casual' (default), 'classic', 'banking', 'oldstyle' and 'fancy'
\moderncvcolor{burgundy}                           % color options 'black', 'blue' (default), 'burgundy', 'green', 'grey', 'orange', 'purple' and 'red'
\usepackage[top=0.5cm, bottom=1.9cm, left=0.5cm, right=0.5cm]{geometry}

\newcommand{\externalhref}[3][color1]{\href{#2}{\color{#1}{\textit{#3}}}}%

<xsl:apply-templates select="cv:resume/cv:personal" />
<xsl:apply-templates select="cv:resume/cv:title" />

\begin{document}

\vspace*{-1.8\baselineskip}
\makecvtitle
\vspace{-2\baselineskip}

<xsl:apply-templates select="cv:resume/cv:experiences"/>
<xsl:apply-templates select="cv:resume/cv:educations"/>
<xsl:apply-templates select="cv:resume/cv:trainings"/>
<xsl:apply-templates select="cv:resume/cv:skills"/>
<xsl:apply-templates select="cv:resume/cv:languages"/>
<xsl:apply-templates select="cv:resume/cv:hobbies"/>
\end{document}
	</xsl:template>

	<!-- Personal Informations -->
	<xsl:template match="cv:personal">
\photo[64pt][0pt]{myface.jpg}
\name{<xsl:value-of select="cv:firstname" />}{<xsl:value-of select="cv:lastname" />}
<!--\address{<xsl:value-of select="cv:address/cv:street"/>}{<xsl:value-of select="cv:address/cv:zipcode"/>}{<xsl:value-of select="cv:address/cv:city"/>}-->
\mobile{<xsl:value-of select="cv:mobile"/>}
\email{<xsl:value-of select="cv:email"/>}
<xsl:for-each select="cv:webAddress/cv:www">
	<xsl:choose>
		<xsl:when test="@type = 'homepage'">
\homepage{<xsl:value-of select="@url" />}</xsl:when>
		<xsl:otherwise>
\social[<xsl:value-of select="@type" />][<xsl:value-of select="@url" />]{}</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
	</xsl:template>

	<!-- Resume Title -->
	<xsl:template match="cv:title">
\title{<xsl:value-of select="cv:profession" />}
	</xsl:template>

	<!-- Educations -->
	<xsl:template match="cv:educations">
\section{Diplômes et Études}<xsl:for-each select="cv:education[@abstract='true']">
\cventry{<xsl:value-of select="cv:year"/>}{<xsl:value-of select="cv:certificate"/>}{<xsl:value-of select="cv:school/cv:title"/>}{<xsl:value-of select="cv:school/cv:city"/>}{<xsl:value-of select="cv:speciality"/>}{}</xsl:for-each>
	</xsl:template>

	<!-- Trainings -->
	<xsl:template match="cv:trainings">

\section{Formations et Certifications}<xsl:for-each select="cv:training[@abstract='true']">
\cventry{<xsl:value-of select="cv:year"/>}{<xsl:value-of select="cv:title"/>}{<xsl:value-of select="cv:organization/cv:title"/>}{}{}{<xsl:if test="cv:organization/cv:www != ''">\externalhref{<xsl:value-of select="cv:organization/cv:www"/>}{<xsl:value-of select="cv:organization/cv:www"/>}</xsl:if>}</xsl:for-each>
	</xsl:template>

	<!-- Professional experiences -->
	<xsl:template match="cv:experiences">

\section{Expériences}
<xsl:for-each select="cv:experience[@abstract='true']">\cventry{<xsl:value-of select="cv:year"/>}{<xsl:value-of select="cv:title"/>}{<xsl:value-of select="cv:company/cv:title"/>}{}{}{<xsl:apply-templates select="cv:description" /> }
</xsl:for-each>
	</xsl:template>

	<!-- Skills -->
	<xsl:template match="cv:skills">
\section{Compétences}<xsl:for-each select="cv:skill"><xsl:if test="position() mod 2 != 0">
\cvdoubleitem</xsl:if>{<xsl:value-of select="cv:type"/>}{<xsl:value-of select="cv:value"/>}</xsl:for-each>
	</xsl:template>

	<xsl:template match="cv:languages">
<xsl:for-each select="cv:language">
\cvitem{<xsl:value-of select="cv:name"/>}{<xsl:value-of select="cv:level"/>}{}</xsl:for-each>
	</xsl:template>

	<!--Hobbies-->
	<xsl:template match="cv:hobbies">

\section{Centres d'intérêt}
\cvline{Loisirs}{<xsl:for-each select="cv:hobby">
		<xsl:value-of select="."/>
		<xsl:choose>
			<xsl:when test="position() != last()">, </xsl:when>
		</xsl:choose>
	</xsl:for-each>}
	</xsl:template>

	<xsl:template match="cv:description">
		<xsl:copy-of select="@*" /><xsl:apply-templates />
	</xsl:template>

	<xsl:template match="cv:newline">\newline{}</xsl:template>
	<xsl:template match="cv:underline">\underline{<xsl:apply-templates />}</xsl:template>
	<!-- list item -->
	<xsl:template match="cv:list">\begin{itemize}<xsl:apply-templates />\end{itemize}</xsl:template>
	<xsl:template match="cv:item">\item <xsl:value-of select="normalize-space(.)"/></xsl:template>
</xsl:stylesheet>
