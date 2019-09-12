library(dslabs)
data("gapminder")
head(gapminder)

#all countries color by continent, 1962 and 2012
filter(gapminder, year%in%c(1962, 2012))%>%
  ggplot(aes(fertility, life_expectancy, color=continent)) +
  geom_point() +
#  facet_grid(continent~year) let's not have a variable for the rows. We only want onw row, two columns
  facet_grid(.~year)

#Only Europe and Aisa color by continent, 5 different years
filter(gapminder, year%in%c(1962,1972, 1982, 1992,2002, 2012) & continent %in% c("Europe", "Asia"))%>%
  ggplot(aes(fertility, life_expectancy, color=continent)) +
  geom_point() +
  facet_wrap(~year)
