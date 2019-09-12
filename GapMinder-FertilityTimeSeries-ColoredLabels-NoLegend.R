library(dslabs)
data("gapminder")

#make a data frame for labels. We want to get rid of the ledend
labelsDF<-data_frame(country=c("South Korea", "Germany"), x= c(1970, 1965), y=c(4.75, 2.75))

#Fertility Trend TimeSeries Plot, two countries different lines and colors
filter(gapminder, country%in%c("South Korea", "Germany"))%>%
  ggplot(aes(year, fertility, color=country)) +
  geom_line() +
  theme(legend.position = "none") +
  geom_text(data=labelsDF, aes(x=x, y=y, label= country))
