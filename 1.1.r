# Rscript 1.1.r

data = read.csv("input/1.txt")

list1 <- data$list1
list2 <- data$list2

slist1 <- sort(list1)
slist2 <- sort(list2)

d <- abs(slist1 - slist2)

sum_d <- sum(d)

cat("", sum_d, "\n")