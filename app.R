library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

dat0 <- read.csv("topsongs.dat", h=T)

#mode function from online
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

#dat1 for means
dat1 <- dat0 %>%
  select(c(genre,
           danceability,
           energy,
           loudness,
           speechiness,
           acousticness,
           instrumentalness,
           liveness,
           valence,
           tempo,
           duration_ms))
dat1 <- aggregate(dat1[,-1],
                      by = dat1['genre'],
                      FUN = mean)
dat1[,-1] <- round(dat1[,-1],4)

#dat2 for modes
dat2 <- dat0 %>%
  select(c(genre,
           key,
           mode,
           time_signature))
dat2 <- aggregate(dat2[,-1],
                  by = dat2['genre'],
                  FUN = getmode)

datm <- merge(dat1, dat2, by = 'genre')


ui <- fluidPage(
  navbarPage("Mainstream Spotify",
             tabPanel("Plot",
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          #Checkboxes for the axes feature
                          selectInput("xfeature", "X-Axis",
                                      c("Danceability" = "danceability",
                                        "Energy" = "energy",
                                        "Key" = "key",
                                        "Loudness" = "loudness",
                                        "Mode" = "mode",  
                                        "Speechiness" = "speechiness",
                                        "Acousticness" = "acousticness",
                                        "Instrumentalness" = "instrumentalness",
                                        "Liveness" = "liveness",
                                        "Valence" = "valence",
                                        "Tempo" = "tempo",
                                        "Duration" = "duration_ms",
                                        "Time Signature" = "time_signature")),
                          
                          selectInput("yfeature", "Y-Axis",
                                      c("Danceability" = "danceability",
                                        "Energy" = "energy",
                                        "Key" = "key",
                                        "Loudness" = "loudness",
                                        "Mode" = "mode",  
                                        "Speechiness" = "speechiness",
                                        "Acousticness" = "acousticness",
                                        "Instrumentalness" = "instrumentalness",
                                        "Liveness" = "liveness",
                                        "Valence" = "valence",
                                        "Tempo" = "tempo",
                                        "Duration" = "duration_ms",
                                        "Time Signature" = "time_signature"))
                        ),
                        
                        mainPanel(
                          plotlyOutput("myPlot")
                        )
                      )
             ),
             tabPanel("Genre Summary",
                      dataTableOutput("meansummary")
              ),
             tabPanel("Raw Song Data",
                      dataTableOutput("rawsongs")
             )
  )
  
)

server <- function(input, output){

  output$myPlot <- renderPlotly({
    print(
      ggplotly(
        ggplot(datm, aes(label=genre)) +
      geom_point(aes_string(input$xfeature, input$yfeature)) +
      labs(x=input$xfeature, y=input$yfeature)
      )
    )
  })
  
  output$meansummary <- renderDataTable(datm)
  
  output$rawsongs <- renderDataTable(dat0)
  
}
  

shinyApp(ui, server)