library(dslabs)
data("gapminder")
gapminder<- gapminder%>%mutate(dollars_per_day=gdp/population/365)

gapminder%>% filter(year==1970 & !is.na(gdp)) %>%mutate(region=reorder(region, dollars_per_day, FUN=median)) %>%
  ggplot(aes(region, dollars_per_day, fill=continent)) +
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
  
west<-c("Western Europe", "Northern Europe", "Northern America", "Australia and New Zealand", "Southern Europe")

gapminder%>% filter(year%in%c(1970,2010) & !is.na(gdp)) %>%mutate(region=reorder(region, dollars_per_day, FUN=median)) %>%
  mutate(group=ifelse(region%in% west, "West", "Developing"))%>%
  ggplot(aes(region, dollars_per_day, fill=factor(year))) +
  geom_boxplot()+ scale_y_continuous(trans = "log2") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + facet_grid(.~group) 
