library(shiny)
library(RCurl)
library(maps)
library(mapproj)

#Load fips of states.
state.fips<-state.fips

#Location of the csv file in my GitHub repository.
url<-getURL("https://raw.githubusercontent.com/ContraMolinos/CourseraDataProducts/master/CA1_1969_2013_PORT.csv")
LAPIncomes<-read.csv2(text=url,header=T,sep=',',as.is = T)

#temporal. Subset one year. Remove fips that don't belong to states. Select only income per capita.
tmp<-subset(tmp,(as.numeric(GeoFIPS)%%1000)==0)
tmp<-subset(LAPIncomes,select=c(1,2,8),LineCode==3)


shinyServer(function(input,output)
{
  #Generate 200 shades of blue.
  colshades<-colorRampPalette(c("white","blue"))(200)
  #Match the states in the data with those in the map
  orderFips<-match(state.fips$fips,as.integer(tmp$GeoFIPS)/1000)

  fills<-shades[as.integer(cut(tmp$X1969[orderFips],200))]
  
  output$map<-renderPlot({
    map("state",fill=T,col=fills)
  })
  
})