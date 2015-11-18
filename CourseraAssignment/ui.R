library(shiny)
library(maps)
library(mapproj)

shinyUI(pageWithSidebar(
  headerPanel("Test"),
  sidebarPanel(),
  mainPanel(plotOutput("map"))
))