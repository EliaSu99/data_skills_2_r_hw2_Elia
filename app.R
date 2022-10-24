## https://eliasu99.shinyapps.io/data_skills_2_r_hw2_elia/

library(tidyverse)
library(shiny)
library(plotly)
library(scales)
library(sf)
library(spData)

ui <- fluidPage( 
  fluidRow( 
    column(width = 12,
           align = "center",
           tags$h1("Covid19 Vaccination Rate and Vulnable Age Group\nby Zip Code in Chicago"),
           tags$hr()
    )
  ),
  fluidRow( 
    column(width = 6,
           align = "center",
           tags$h3("Homewrok 2, Data and Programming II in R")
    ),
    column(width = 6,
           align = "center",
           tags$h3("Elia Su
                   12265085")
    )
  ),
  fluidRow( 
    column(width = 6,
           align = "center",
           selectInput(inputId = "major_streets1",
                       label = "Please choose a map of vaccination series completion status in Chicago",
                       choices = c("Map by Zip Code with Main Streets", "Map by Zip Code")),
           plotlyOutput("vaxx_disp")
    ),
    column(width = 6,
           align = "center",
           selectInput(inputId = "major_streets2",
                       label = "Please choose a map of vulnerable age group in Chicago",
                       choices = c("Map by Zip Code with Main Streets", "Map by Zip Code")),
           plotlyOutput("pop_disp")
    ) 
  )
)


server <- function(input, output) {
  
  path <- "~/Desktop/data_skills_2_r_hw2_Elia/Major_Streets"
  streets_shape <- read_sf(file.path(path, "Major_Streets.shp"))
  chicago_vaxx <- read_sf("chicago_vaxx.shp")
  chicago_pop_60plus <- read_sf("chicago_pop_60plus.shp")
  
  output$vaxx_disp <- renderPlotly({
    if (input$major_streets1 == "Map by Zip Code") {
      plt_1 <- ggplot() +
        geom_sf(data = chicago_vaxx, aes(fill = cmplt_p)) +
        labs(title = "Vaccination Series Completion Status\nin Chicago",
             fill = "Vaccination\nCompletion\nStatus\n(% of Population)",
             caption = "Source: Chicago Data Portal") +
        theme_void()
    } else if (input$major_streets1 == "Map by Zip Code with Main Streets") {
      plt_1 <- ggplot() +
        geom_sf(data = chicago_vaxx, aes(fill = cmplt_p)) +
        geom_sf(data = streets_shape, color = "red", alpha = 0.2)+
        labs(title = "Vaccination Series Completion Status\nin Chicago",
             fill = "Vaccination\nCompletion\nStatus\n(% of Population)",
             caption = "Source: Chicago Data Portal") +
        theme_void()
    }
    ggplotly(plt_1)
    
  })
  
  output$pop_disp <- renderPlotly({
    if (input$major_streets2 == "Map by Zip Code") {
      plt_2 <- ggplot() +
        geom_sf(data = chicago_pop_60plus, aes(fill = ovr_60_)) +
        labs(title = "COVID-19 Vulnerable Age Group Percentage\nin Chicago",
             fill = "Aged 60+\n(% of Population)",
             caption = "Source: Chicago Data Portal") +
        theme_void()
    } else if (input$major_streets2 == "Map by Zip Code with Main Streets") {
      plt_2 <- ggplot() +
        geom_sf(data = chicago_pop_60plus, aes(fill = ovr_60_)) +
        geom_sf(data = streets_shape, color = "red", alpha = 0.2) +
        labs(title = "COVID-19 Vulnerable Age Group Percentage\nin Chicago",
             fill = "Aged 60+\n(% of Population)",
             caption = "Source: Chicago Data Portal") +
        theme_void()
    }
    ggplotly(plt_2)
  })
}

shinyApp(ui = ui, server = server)
