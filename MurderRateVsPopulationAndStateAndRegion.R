library(dslabs)
library(dplyr)
library(ggplot2)
data("murders")
murders<-mutate(murders, rate=total/population*100000)
#The following two lines are equivalent
#p<-ggplot(data=murders)
#p<-murders %>% ggplot()
murders %>% ggplot() + 
  geom_point(aes(x=population/10^6, y=total), size=3) +
  geom_text(aes(x=population/10^6, y=total, label = abb), nudge_x = 1)
#in order to avoid doing the aesthetic mapping twice, we can do a global aesthetic mapping in the ggplot function itself:
murders %>% ggplot(aes(x=population/10^6, y=total, label = abb)) + 
  geom_point(size=3) +
  geom_text(nudge_x = 1)
#the local mapping overrides the global mapping
#murders %>% ggplot(aes(x=population/10^6, y=total, label = abb)) + 
#  geom_point(size=3) +
#  geom_text(aes(x=10,y=800, label= "Hello There"))

#now do the scale to log10
murders %>% ggplot(aes(x=population/10^6, y=total, label = abb)) + 
  geom_point(size=3) +
  geom_text(nudge_x = 0.05) +
  scale_x_continuous(trans = "log10")+
  scale_y_continuous(trans = "log10")
#log10 scale is so common that ggplot has functions for it. we also set the lables and the title
p<-murders %>% ggplot(aes(x=population/10^6, y=total, label = abb)) + 
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("population in millions (log scale)") + 
  ylab("total number of murders (log scale)") + 
  ggtitle("Gun murders in US 2010")
p+   geom_point(size=3)

#Change the point layer to have collors representing the regions
p+   geom_point(size=3, aes(col=region)) 


#define r as the average rate for the entire country
r<-murders%>% summarize(rate= sum(total/sum(population)*10^6))%>%.$rate
r
#use r to draw the average line
#it should be y=rx but we are doing log scale, so log(rx)=log(r)+log(x). 
#log(x) is our x with slope 1 which is the default, and log(r) is teh intercept
p+   geom_point(size=3, aes(col=region)) +
  geom_abline(intercept=log10(r))

#change thetype of line to dashed and the colour to grey. And put geom_abline before geom_points
p<-p +
  geom_abline(intercept=log10(r), lty=2, color="darkgrey") +
  geom_point(size=3, aes(col=region))
p
#capitalise the R of region in the legend
p<-p+scale_color_discrete(name="Region")
p

#Use of add-on packages
# use the theme_economist from the ggthemes package
library(ggthemes)
p+theme_economist()

#we do not want labels to fall on each other
library(ggrepel)

p<-murders %>% ggplot(aes(x=population/10^6, y=total, label = abb)) + 
  geom_abline(intercept=log10(r), lty=2, color="darkgrey") +
  geom_point(size=3, aes(col=region))+
  geom_text_repel()+
  scale_x_log10() +
  scale_y_log10() +
  xlab("population in millions (log scale)") + 
  ylab("total number of murders (log scale)") + 
  ggtitle("Gun murders in US 2010")+
  scale_color_discrete(name="Region") +
  theme_economist()
p
