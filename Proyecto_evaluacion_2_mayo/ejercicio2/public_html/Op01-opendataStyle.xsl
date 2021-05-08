<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- indica que tipo de archivo va a generar -->
    <xsl:output method="html"/>

    <xsl:key name="pais" match="/records/record" use="countriesAndTerritories" />

    <xsl:template match="records">
        <html>
            <head>
                <title>Víctor Visús García - LMSGI - Ejercicio 2 proyecto 2ªEvaluación </title>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />

                <meta name="author" content="Víctor Visús García" />
                <meta name="description" content="Ejercicio 2 - XSLT - Proyecto 2ª Evaluación" />
            </head>
            <body>
                <header></header>
                <main>

                    <h1>
                        <xsl:text>Ejercicio 2 - XSLT - Proyecto 2ª Evaluación</xsl:text>
                    </h1>
                    <h2>
                        <xsl:text>Tabla 1 - Datos agrupados por País</xsl:text>
                    </h2>

                    <table style="width:100%;" border="1">
                        <thead>
                            <th>
                                <font color="#000">
                                    <xsl:text>Pais</xsl:text>
                                </font>
                            </th>
                            <th>
                                <font color="#000">
                                    <xsl:text>Total Cases</xsl:text>
                                </font>
                            </th>
                            <th>
                                <font color="#000">
                                    <xsl:text>Total Deaths</xsl:text>
                                </font>
                            </th>
                            <th>
                                <font color="#000">
                                    <xsl:text>Deaths por 1000 habitantes</xsl:text>
                                </font>
                            </th>
                        </thead>

                        <tbody>
                            <!-- <xsl:apply-templates select="record"></xsl:apply-templates> -->
                            <xsl:apply-templates select="record[generate-id() = generate-id(key('pais', countriesAndTerritories)[1])]" />

                        </tbody>
                    </table>
                </main>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="record">
        <xsl:for-each select=".">
            <tr>
                <!-- Pais -->
                <td>
                    <!-- <xsl:value-of select="current-grouping-key()" /> -->
                    <xsl:value-of select="countriesAndTerritories" />
                </td>
                <!-- Total Cases -->
                <td>
                    <!-- <xsl:value-of select="sum(current-group()/cases" /> -->
                    <xsl:value-of select="sum(key('pais', countriesAndTerritories)/cases)" />
                </td>
                <!-- Total Deaths -->
                <td>
                    <!-- <xsl:value-of select="sum(current-group()/deaths" /> -->
                    <xsl:value-of select="sum(key('pais', countriesAndTerritories)/deaths)" />
                </td>
                <!-- Deaths por 1000 habitantes -->
                <td>
                    <!-- <xsl:value-of select="Deaths por 1000 habitantes" /> -->
                    <xsl:value-of select="format-number(sum(key('pais', countriesAndTerritories)/deaths) div 1000, '0.00000')" />
                </td>
            </tr>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>
