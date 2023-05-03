
# Highcharts theme for plots
hc_theme_jc <- hc_theme(#colors = c("#D25E2D", "#EDB799", "#C7E8F5", "#236ca7", "#D6C246", "#dcdcdc"),

  # colors = c(orange, yellow, red, purple, darkblue, teal, blue, neutralBkgndMedium),
  colors = c(orange, yellow, purple, darkblue, teal, blue),

  chart = list(style = list(fontFamily = "Graphik",
                            color      = neutralBlackText)),
  title = list(align = "center",
               style = list(fontFamily = "Graphik",
                            fontWeight = "bold",
                            color = neutralBlackText,
                            fontSize   = "16px")),
  subtitle = list(align = "center",
                  style = list(fontFamily = "Graphik",
                               fontWeight = "bold",
                               color = neutralBlackText,
                               fontSize   = "14px")),
  chart = list(style = list(fontFamily = "Graphik", color = neutralBlackText)),
  legend = list(align = "center", verticalAlign = "top"),
  xAxis = list(labels = list(enabled = TRUE),
               gridLineColor = "transparent",
               lineColor = "transparent",
               minorGridLineColor = "transparent",
               tickColor = "transparent"),
  yAxis = list(labels = list(enabled = TRUE),
               gridLineColor = "transparent",
               lineColor = "transparent",
               majorGridLineColor = "transparent",
               minorGridLineColor = "transparent",
               tickColor = "transparent"),
  plotOptions = list(line = list(marker = list(enabled = FALSE)),
                     spline = list(marker = list(enabled = FALSE)),
                     area = list(marker = list(enabled = FALSE)),
                     areaspline = list(marker = list(enabled = FALSE)),
                     arearange = list(marker = list(enabled = FALSE)),
                     bubble = list(maxSize = "10%")))

# Highcharts theme for plots
hc_theme_jc_pie <- hc_theme(
  colors = c(teal, neutralBkgndMedium),
  chart =
    list(style =
           list(fontFamily = "Graphik",
                color      = neutralBlackText)),
  title =
    list(align = "center",
         style =
           list(fontFamily = "Graphik",
                fontWeight = "bold",
                color      = neutralBlackText,
                fontSize   = "16px")),
  subtitle =
    list(align = "center",
         style =
           list(fontFamily = "Graphik",
                fontWeight = "bold",
                color      = neutralBlackText,
                fontSize   = "14px")),
  chart =
    list(style =
           list(fontFamily = "Graphik",
                color      = neutralBlackText)),
  legend =
    list(align = "center", verticalAlign = "top"),

  xAxis =
    list(labels =
           list(enabled = TRUE),
                gridLineColor = "transparent",
                lineColor = "transparent",
                minorGridLineColor = "transparent",
                tickColor = "transparent"),
  yAxis =
    list(labels =
           list(enabled = TRUE),
                gridLineColor = "transparent",
                lineColor = "transparent",
                majorGridLineColor = "transparent",
                minorGridLineColor = "transparent",
                tickColor = "transparent"),
  plotOptions =
    list(line =
           list(marker = list(enabled = FALSE)),
                spline = list(marker = list(enabled = FALSE)),
                area = list(marker = list(enabled = FALSE)),
                areaspline = list(marker = list(enabled = FALSE)),
                arearange = list(marker = list(enabled = FALSE)),
                bubble = list(maxSize = "10%")))

# Highcharts download buttons
hc_setup <- function(x) {
  highcharter::hc_add_dependency(x, name = "plugins/series-label.js") %>%
    highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
    highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
    highcharter::hc_add_dependency(name = "plugins/export-data.js") %>%
    highcharter::hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%
    highcharter::hc_exporting(enabled = TRUE)
}


# Create pie chart with labels
fnc_pie_chart <- function(df,
                          x_variable,
                          y_variable,
                          point_format,
                          accessibility_text){

  df$x_variable <- get(x_variable, df)
  df$y_variable <- get(y_variable, df)

  df %>%
    hchart("pie",
           hcaes(x = x_variable, y = y_variable),
           dataLabels = list(
             style = list(fontSize = "1.25em",
                          fontWeight = "regular",
                          alignTo = "connectors",
                          color = neutralBlackText),
             enabled = TRUE,
             y = -10,
             format = point_format)) %>%

    hc_add_theme(hc_theme_jc) %>%
    hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%
    hc_plotOptions(series = list(animation = FALSE,
                                 cursor = "pointer",
                                 borderWidth = 3),
                   accessibility = list(enabled = TRUE,
                                        keyboardNavigation = list(enabled = TRUE),
                                        linkedDescription = accessibility_text,
                                        landmarkVerbosity = "one"),
                   area = list(accessibility = list(description = accessibility_text)))
}

