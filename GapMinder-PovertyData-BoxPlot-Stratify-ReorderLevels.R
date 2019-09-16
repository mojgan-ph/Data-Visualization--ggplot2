library(dslabs)
data("gapminder")
gapminder<- gapminder%>%mutate(dollars_per_day=gdp/population/365)

gapminder%>% filter(year==1970 & !is.na(gdp)) %>%mutate(region=reorder(region, dollars_per_day, FUN=median)) %>%
  ggplot(aes(region, dollars_per_day, fill=continent)) +
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
  