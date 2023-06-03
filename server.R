server <- function(input, output) {
  
  # Subsetting for CheckGroupInput
  EraSubset <-reactive({
    if (is.null(input$Era) == TRUE) {
      return(drone_strikes)
    } else {
      return(filter(drone_strikes, Presidency %in% input$Era))
    }
  })
  
  # Pie Diagrams - Total Serangan
  output$strikes_pie <- renderEcharts4r({
    e_common(font_family = "georgia")
    
  strikes_pie <- 
    drone_strikes %>% 
    select(Country,`Maximum Strikes`) %>% 
    group_by(Country) %>% 
    summarize(Strikes = sum(`Maximum Strikes`)) %>% 
    e_charts(x = Country) %>% 
    e_pie(Strikes, legend = FALSE) %>% 
    e_tooltip() %>% 
    e_title("Total Strikes Reported", "in Each Country") %>% 
    e_theme_custom("www/jsonformatter.json")
  
  strikes_pie
  })

  # Pie Diagrams - Total Serangan Telah Dikonfirmasi oleh USA
  output$confirmed_pie <- renderEcharts4r({
    e_common(font_family = "georgia")
    
    confirmed_pie <- 
      drone_strikes %>% 
      filter(`US Confirmed` %in% "Confirmed") %>% 
      select(Country,`Maximum Strikes`) %>% 
      group_by(Country) %>% 
      summarize(Strikes = sum(`Maximum Strikes`)) %>%  
      e_charts(x = Country) %>% 
      e_pie(Strikes, legend = FALSE, name = "Strikes") %>% 
      e_tooltip() %>% 
      e_title("Strikes Confirmed by USA", "in Each Country") %>% 
      e_theme_custom("www/jsonformatter.json")
    
    confirmed_pie
    })
  
  # Plot Timeline Strikes
  output$timeline_strikes <- renderEcharts4r({
    timeline_strikes <- 
      EraSubset() %>% 
      filter(Country == input$Country) %>%  
      select(Country, Date,`Maximum Strikes`) %>% 
      mutate(Date = floor_date(Date, "quarter")) %>% 
      group_by(Date, Country) %>% 
      summarise(Strikes = sum(`Maximum Strikes`),.groups = 'drop') %>%
      mutate(Quart = case_when(
        month(Date) == "1" ~ "Q1",
        month(Date) == "4" ~ "Q2",
        month(Date) == "7" ~ "Q3",
        month(Date) == "10" ~ "Q4"
      )) %>% 
      mutate(Quart = paste(year(Date), Quart),
             Date = as.Date(Date, format = "%d-%m-%Y"))
    
    style <- list(
      itemStyle = list(
        color = "#A6655F",
        opacity = 0.4
      )
    )
    
    line_base <- timeline_strikes %>% 
      group_by(Country) %>% 
      e_charts(x = Quart) %>% 
      e_datazoom(
        type = "slider", 
        toolbox = FALSE
      ) %>% 
      e_tooltip() %>% 
      e_title("Strikes Timeline per Quartal") %>% 
      e_x_axis(Quart, axisPointer = list(show = TRUE)) %>% 
      e_theme_custom("www/jsonformatter.json")
    
    line_plot <- line_base %>% 
      e_line(serie=Strikes, name = "Strikes", legend = FALSE, emphasis=style)
    line_plot
    })
  
  # Plot Death People
  
  output$plot_death <- renderPlotly({
    plot_death <- 
      EraSubset() %>% 
      filter(Country == input$Country) %>% 
      select(`Minimum Total Killed`, `Maximum Total Killed`, `Minimum Civilians Killed`, `Maximum Civilians Killed`, 
             `Minimum Children Killed`, `Maximum Children Killed`) %>% 
      pivot_longer(cols = c("Minimum Total Killed","Maximum Total Killed",
                            "Minimum Civilians Killed", "Maximum Civilians Killed", 
                            "Minimum Children Killed", "Maximum Children Killed"), 
                   names_to = "Name", values_to = "Value") %>% 
      mutate( Type = case_when(
        Name == "Minimum Total Killed" | Name == "Maximum Total Killed" ~ "Total",
        Name == "Minimum Civilians Killed" | Name == "Maximum Civilians Killed" ~ "Civilians",
        Name == "Minimum Children Killed" | Name == "Maximum Children Killed" ~ "Children")) %>% 
      mutate ( Name = case_when(
        Name == "Minimum Total Killed" | Name == "Minimum Civilians Killed" | Name == "Minimum Children Killed" ~ "Minimum",
        Name == "Maximum Total Killed" | Name == "Maximum Civilians Killed" | Name == "Maximum Children Killed" ~ "Maximum")) %>% 
      group_by(Type, Name) %>% 
      summarize(Value = sum(Value), .groups = 'drop') %>% 
      ungroup() %>%
      mutate(label = glue("{Type}
                      Deaths: {comma(Value)}")) %>% 
      ggplot(aes(Value, Type, text = label)) +
      geom_col(aes(fill = factor(Name, levels=c("Maximum", "Minimum"))),
               position = "stack", width = 0.7) +
      scale_fill_manual(values = alpha(c("#1D267D", "#D4ADFC"),0.9)) +
      scale_x_continuous(breaks = seq(0,14000,2000)) +
      labs(title = "Death",
           x = NULL,
           y = NULL,
           fill = NULL) +
      theme(legend.position = "right",
            legend.direction = "vertical",
            legend.background = element_rect(fill="#C4DFDF", color = "#C4DFDF"),
            legend.key = element_rect(fill="#C4DFDF", color = "#C4DFDF"),
            legend.title = element_text(colour = "Black", face ="bold", size = 9, family = "Georgia"),
            legend.text = element_text(color="Black", face ="italic", family = "Georgia"),
            plot.background = element_rect(fill = "#C4DFDF", color = "#C4DFDF"),
            panel.background = element_rect(fill = "#C4DFDF"),
            panel.grid = element_line(alpha(colour = "#5C469C",alpha = 0.4)),
            axis.title.x = element_text(colour = "Black", family = "Georgia",face = "bold"),
            axis.text.x = element_text(angle = 15, color = "Black", face = "bold", family = "Georgia"),
            axis.text.y = element_text(color="Black", face="italic", family = "Georgia"),
            plot.title = element_text(face = "bold", family = "Georgia"))
    
    ggplotly(plot_death, tooltip = "text")
    })
  
  # Plot Injured People
  
  output$plot_injured <- renderPlotly({
    plot_injured <- 
      EraSubset() %>% 
      filter(Country == input$Country) %>% 
      select(`Minimum Injured`, `Maximum Injured`) %>% 
      rename(Minimum = "Minimum Injured",
             Maximum = "Maximum Injured") %>% 
      pivot_longer(cols = c("Minimum", "Maximum"),
                   names_to = "Injured",
                   values_to = "Value") %>% 
      group_by(Injured) %>% 
      summarize(Total = sum(Value)) %>% 
      mutate(label = glue("Injured: {comma(Total)}")) %>% 
      ggplot(aes(Total, reorder(Injured, Total), text = label, fill = Injured )) +
      scale_x_continuous(breaks = seq(0,1750,250)) +
      geom_col(width = 0.6) +
      scale_fill_manual(values = alpha(c("#1D267D", "#D4ADFC"),0.9)) +
      labs(title = "Injured",
           x = NULL,
           y = NULL,
           fill = NULL) +
      theme(legend.position = "none",
            plot.background = element_rect(fill = "#C4DFDF", color = "#C4DFDF"),
            panel.background = element_rect(fill = "#C4DFDF"),
            panel.grid = element_line(alpha(colour = "#5C469C",alpha = 0.4)),
            axis.title.x = element_text(colour = "Black", family = "Georgia",face = "bold"),
            axis.text.x = element_text(angle = 15, color = "Black", face = "bold", family = "Georgia"),
            axis.text.y = element_text(color="Black", face="italic", family = "Georgia"),
            plot.title = element_text(face = "bold", family = "Georgia"))
    
    ggplotly(plot_injured, tooltip = "text")
    })
  
  # Info Box - Total Strike
  
  output$total_strikes <- renderValueBox({
    
  total_strikes <- 
    EraSubset() %>% 
    filter(Country == input$Country) %>% 
    select(`Maximum Strikes`,`Minimum Strikes`) %>% 
    summarize(`Strikes Reported` = sum(`Maximum Strikes`),
              `Minimum Strikes` = sum(`Minimum Strikes`))
  
  valueBox(tags$p(paste(comma(total_strikes$`Minimum Strikes`),"-",comma(total_strikes$`Strikes Reported`)), 
                  style = "font-size: 100%; color: white;"),
           subtitle = "Total Strikes",
           color = "teal", 
           icon = icon("bomb"))
  })
  
  # Info Box - Innocent Death
  
  output$inno_death <- renderValueBox({
    
    inno_death <- 
      EraSubset() %>% 
      filter(Country == input$Country) %>% 
      select(`Maximum Civilians Killed`,`Maximum Children Killed`,`Minimum Civilians Killed`,`Minimum Children Killed`) %>% 
      summarize(maxCivilians = sum(`Maximum Civilians Killed`),
                maxChildren = sum(`Maximum Civilians Killed`),
                minCivilians = sum(`Minimum Civilians Killed`),
                minChildren = sum(`Minimum Children Killed`)) %>% 
      mutate(DeathMax = maxCivilians + maxChildren,
             DeathMin = minCivilians + minChildren)
    
    valueBox(tags$p(paste(comma(inno_death$DeathMin),"-",comma(inno_death$DeathMax)), 
                    style = "font-size: 100%; color: white;"),
             subtitle = "Civilians Death",
             color = "black", 
             icon = icon("ribbon"))
  })
  
  # Info Box - Total Death
  
  output$total.death <- renderValueBox({
    
    total.death <- 
      EraSubset() %>% 
      filter(Country == input$Country) %>%  
      select(`Maximum Total Killed`,`Minimum Total Killed`) %>% 
      summarize(DeathMax = sum(`Maximum Total Killed`),
                DeathMin = sum(`Minimum Total Killed`))
    
    valueBox(tags$p(paste(comma(total.death$DeathMin),"-",comma(total.death$DeathMax)), 
                    style = "font-size: 100%; color: white;"),
             subtitle = "Total Death",
             color = "teal", 
             icon = icon("hospital"))
  })
  
  # Leaflet Map - Afghanistan
  
  output$lm_afg <- renderLeaflet({
    
    lm_afg <- leaflet(afg_sf) %>% 
      addProviderTiles(providers$Stamen.Terrain) %>% 
      addPolygons(fillColor = ~factpal.a(Intensity),
                  weight = 1,
                  opacity = 1,
                  color = "black",
                  dashArray = "3",
                  fillOpacity = 0.9,
                  label = afg_sf$NAME_1,
                  popup = popup.cont.a) %>% 
      addLegend("bottomright", 
                values = ~Intensity,
                colors =c("#E74646", "#FA9884", "#FFE5CA", "#FFF3E2","#89375F"), 
                labels= c("Very High", "High", "Medium", "Low", "None"),
                title = "Strikes Intensity:",
                labFormat = labelFormat(digits = 2),
                opacity = 1)
    
    lm_afg
  })
  
  # Leaflet Map - Pakistan
  
  output$lm_pks <- renderLeaflet({
    
    lm_pks <- leaflet(pks_sf) %>% 
      addProviderTiles(providers$Stamen.Terrain) %>% 
      addPolygons(fillColor = ~factpal.a(Intensity),
                  weight = 1,
                  opacity = 1,
                  color = "black",
                  dashArray = "3",
                  fillOpacity = 0.9,
                  label = pks_sf$NAME_1,
                  popup = popup.cont.a) %>% 
      addLegend("bottomright", 
                values = ~Intensity,
                colors =c("#E74646", "#FA9884", "#FFE5CA", "#FFF3E2","#89375F"), 
                labels= c("Very High", "High", "Medium", "Low", "None"),
                title = "Strikes Intensity:",
                labFormat = labelFormat(digits = 2),
                opacity = 1)
    
    lm_pks
  })
  
  # Leaflet Map - Somalia
  
  output$lm_soma <- renderLeaflet({
    
    lm_soma <- leaflet(soma_sf) %>% 
      addProviderTiles(providers$Stamen.Terrain) %>% 
      addPolygons(fillColor = ~factpal.a(Intensity),
                  weight = 1,
                  opacity = 1,
                  color = "black",
                  dashArray = "3",
                  fillOpacity = 0.9,
                  label = soma_sf$NAME_1,
                  popup = popup.cont.a) %>% 
      addLegend("bottomright", 
                values = ~Intensity,
                colors =c("#E74646", "#FA9884", "#FFE5CA", "#FFF3E2","#89375F"), 
                labels= c("Very High", "High", "Medium", "Low", "None"),
                title = "Strikes Intensity:",
                labFormat = labelFormat(digits = 2),
                opacity = 1)
    
    lm_soma
  })
  
  # Leaflet Map - Yemen
  
  output$lm_yemen <- renderLeaflet({
    
    lm_yemen <- leaflet(ymn_sf) %>% 
      addProviderTiles(providers$Stamen.Terrain) %>% 
      addPolygons(fillColor = ~factpal.a(Intensity),
                  weight = 1,
                  opacity = 1,
                  color = "black",
                  dashArray = "3",
                  fillOpacity = 0.9,
                  label = ymn_sf$NAME_1,
                  popup = popup.cont.a) %>% 
      addLegend("bottomright", 
                values = ~Intensity,
                colors =c("#E74646", "#FA9884", "#FFE5CA", "#FFF3E2","#89375F"), 
                labels= c("Very High", "High", "Medium", "Low", "None"),
                title = "Strikes Intensity:",
                labFormat = labelFormat(digits = 2),
                opacity = 1)
    
    lm_yemen
  })
  
  # Dataset
  
  output$data_dronewars <- DT::renderDataTable(drone_strikes, options = list(scrollX = T))
}
  
  
  
  
  