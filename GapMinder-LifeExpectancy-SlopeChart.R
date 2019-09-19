library(dslabs)
data("gapminder")
head(gapminder)

west<-c("Western Europe", "Northern Europe", "Northern America", "Australia and New Zealand", "Southern Europe")

#all countries color by continent, 1962 and 2012
dat<-filter(gapminder, year%in%c(2010, 2015) & region%in% west & !is.na(life_expectancy) & population>10^7)

dat%>% mutate(location=ifelse(year==2010, 1,2),
              location=ifelse(year==2015 & country%in%c("United Kingdom", "Portugal"), location + 0.22, location),
              hjust=ifelse(year==2010, 1, 0))%>%
  mutate(year=as.factor(year))%>% 
  ggplot(aes(year, life_expectancy, group=country)) +
  geom_line(aes(color=country) , show.legend = FALSE) +
  geom_text(aes(x=location,label=country,hjust=hjust), show.legend = FALSE) 
