library(dslabs)
data("gapminder")
gapminder<- gapminder%>%mutate(dollars_per_day=gdp/population/365)

west<-c("Western Europe", "Northern Europe", "Northern America", "Australia and New Zealand", "Southern Europe")

l1<-gapminder%>% filter(year%in%c(1970) & !is.na(dollars_per_day))%>% .$country
l2<-gapminder%>% filter(year%in%c(2010) & !is.na(dollars_per_day))%>% .$country
country_list<-intersect(l1,l2)

gapminder<-gapminder%>%mutate(group=case_when(
  .$region %in% west~"West", 
  .$region %in% c("Eastern Asia", "South-Eastern Asia")~"East Asia", 
  .$region %in% c("Caribbean", "Central America", "South America")~"Latin America", 
.$continent=="Africa"& .$region!="Northern Africa"~"Sun-Saharan Africa", 
  TRUE ~"Others", 
))

gapminder<-gapminder%>%mutate(group= factor(group, 
                                            levels = c("Others", "Latin America", "East Asia", "Sun-Saharan Africa", "West")))
                              
                              
#use bw to make the plots smoother, and use position="stack" to stack the plots on top of each other
gapminder%>% filter(year%in%c(1970,2010) & country%in%country_list) %>%
  ggplot(aes(dollars_per_day, y=..count.., fill=group)) +
  geom_density(alpha=0.2, bw=0.75, position = "stack")+ facet_grid(year~.) + scale_x_continuous(trans = "log2")
 
#weight the countries to consider populations. China has impproved a lot, but it is considered only one country. 
#We want the population to be reflected too.
gapminder%>% filter(year%in%c(1970,2010) & country%in%country_list) %>%
  group_by(year)%>%
  mutate(weight=population/sum(population)) %>%
  ggplot(aes(dollars_per_day, y=..count.., fill=group, weight=weight)) +
  geom_density(alpha=0.2, bw=0.75, position = "stack")+ facet_grid(year~.) + scale_x_continuous(trans = "log2")
