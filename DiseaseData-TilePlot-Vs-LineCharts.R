data("us_contagious_diseases")
str(us_contagious_diseases)
dat<- us_contagious_diseases%>% filter(!state%in%c("Hawaii", "Alaska")& disease=="Measles") %>% 
  mutate(rate=count/population*10000) %>%
  mutate(state=reorder(state,rate))

str(dat)
head(dat)

#a line plot of disease rate with a vertical line for the year that vaccination was introduced
dat%>% filter(state=="California") %>%
  ggplot(aes(year, rate)) +
  geom_line() +ylab("Cases per 10,000") +
  geom_vline(xintercept = 1963, col="blue")

library("RColorBrewer")
display.brewer.all(type = "seq")
display.brewer.all()

#tile plot, for having more than 2 dimensions
dat%>% ggplot(aes(year, state, fill=rate)) +
  geom_tile(color="grey50") +
  scale_x_continuous(expand=c(0,0)) +
  scale_fill_gradientn(colors = brewer.pal(9,"Reds"), trans="sqrt") +
  geom_vline(xintercept = 1963, col="blue") +
  theme_minimal() + theme(panel.grid = element_blank()) +
  ggtitle("Measles") + ylab("") +xlab("")

avg<- us_contagious_diseases%>% filter(disease=="Measles") %>% group_by(year) %>% 
  summarise(us_rate= sum(count, na.rm = TRUE)/sum(population, na.rm=TRUE)*10000)

dat%>% ggplot() +
  geom_line(aes(year, rate, group=state),color="grey50", alpha=0.2, size=1, show.legend = FALSE) +
  geom_line(mapping = aes(year, us_rate),  data = avg, size = 1, color = "black") +  
  geom_vline(xintercept = 1963, col="blue") +
  ggtitle("Measles rate per 10000") + ylab("") +xlab("")
