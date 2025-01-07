# Rscript 1.2.r

data = read.csv("input/1.txt")

list1 <- data$list1
list2 <- data$list2

sum <- 0

for (v in list1) {
  n <- sum(list2 == v)
  
  sum <- sum + (v * n)
}

cat("", sum, "\n")