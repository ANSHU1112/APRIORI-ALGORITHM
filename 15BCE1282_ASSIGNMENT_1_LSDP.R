#APRIORI METHOD

library(arules)
dataset = read.csv('groceries.csv', header = FALSE)
dataset = read.transactions('groceries.csv', sep = ',', rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 20)
itemFrequencyPlot(dataset, topN = 10)

#Training Apriori on the dataset

rules = apriori(data = dataset, parameter = list(support = 0.001, confidence = 0.8))

#Visualization

options(digits=2)
inspect(rules[1:5])
rules<-sort(rules, by="confidence", decreasing=TRUE)

rules<-apriori(data=dataset, parameter=list(supp=0.001,conf = 0.08), 
               appearance = list(default="lhs",rhs="whole milk"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

rules<-apriori(data=dataset, parameter=list(supp=0.001,conf = 0.15,minlen=2), 
               appearance = list(default="rhs",lhs="whole milk"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

library(arulesViz)
plot(rules)
plot(rules[1:5],method = "graph",control = list(type = "items"))
#plot(rules[1:5],method = "paracoord",control = list(reorder = TRUE))
#plot(rules[1:5],method = "matrix",control = list(reorder = TRUE))
arulesViz::plotly_arules(rules)
