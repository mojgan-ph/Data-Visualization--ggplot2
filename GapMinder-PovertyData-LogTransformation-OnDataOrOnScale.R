library(dslabs)
data("gapminder")
gapminder<- gapminder%>%mutate(dollars_per_day=gdp/population/365)
head(gapminder)

gapminder%>% filter(year==1970 & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color="black")

#log2 transformation on x axis
gapminder%>% filter(year==1970 & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) +
  geom_histogram(binwidth = 1, color="black")

# now transform the scale rather than the data
gapminder%>% filter(year==1970 & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color="black") + 
  scale_x_continuous(trans = "log2")
