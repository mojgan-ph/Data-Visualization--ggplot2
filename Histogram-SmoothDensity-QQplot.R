p<-heights%>%filter(sex=="Male") %>% ggplot(aes(x=height))

#Histogram
p + 
  xlab("Male heights in inches") + geom_histogram(binwidth = 1, fill="blue", color="black") +
  ggtitle("Histogram")

#smooth density
p +  geom_density(fill="blue") +
  ggtitle("Smooth Density")

#qqplot against normal distribution with m=0 and sd=1
p<-heights%>%filter(sex=="Male") %>% ggplot(aes(sample=height))
p+geom_qq()

# do that with mean and sd of the data
params<-heights%>%filter(sex=="Male") %>% summarise(mean=mean(height), sd=sd(height))
p+geom_qq(dparams = params) +geom_abline() +
  ylab("Sample male heights in inches") +
  xlab("Theoretical normal distribution with given mean and standard deviation") + 
  ggtitle("QQ-plot showing that male height data follows a normal distribution")

#scale the data to have standard units rather than finding a normal distribution with mean and sd of data
heights%>%filter(sex=="Male") %>% ggplot(aes(sample=scale(height)))+
  geom_qq() +
  geom_abline()

#make a grid of plots
library(gridExtra)
p1<-heights%>%filter(sex=="Male") %>% ggplot(aes(x=height)) +geom_histogram(binwidth = 1, fill="blue", color="black")
p2<-heights%>%filter(sex=="Male") %>% ggplot(aes(x=height)) +geom_histogram(binwidth = 2, fill="blue", color="black")
p3<-heights%>%filter(sex=="Male") %>% ggplot(aes(x=height)) +geom_histogram(binwidth = 3, fill="blue", color="black")
grid.arrange(p1,p2,p3,ncol=3)

#density of height database - group by sex and use different colors
heights %>% 
  ggplot(aes(height,  color= sex)) + geom_density()
heights %>% 
  ggplot(aes(height, fill = sex)) + 
  geom_density(alpha=0.2) 
