path <- "~/R/UCI HAR Dataset"
nrows <- -1

getdata <- function(set) {
  # subject
  subject <- read.table(file = file.path(path, set, paste0("subject_", set, ".txt")), nrows = nrows)  
  # activity
  y <- read.table(file = file.path(path, set, paste0("y_",set,".txt")), nrows = nrows)
  act <- read.table(file = file.path(path, "activity_labels.txt"))
  y <- factor(y[, 1], levels = act[, 1], labels = act[, 2])
  # features
  X <- read.table(file = file.path(path, set, paste0("X_", set, ".txt")), nrows = nrows)
  fea <- read.table(file = file.path(path, "features.txt"))[, 2]
  colnames(X) <- fea
  ii <- c(grep("mean[()]", fea), grep("std[()]", fea))
  
  cbind(subject = subject[, 1], activity = y, X[ii])  
}

# merge data sets
train <- getdata("train")
test <- getdata("test")
dataset <- rbind(train, test)

# calc means per subject and activity for each var, and format results
s <- split(dataset[, -(1:2)], list(dataset$subject, dataset$activity), drop = TRUE)
d <- sapply(s, colMeans)
n <- unlist(strsplit(colnames(d), "[.]"))
subject <- n[seq(1, length(n), 2)]
activity <- n[seq(2, length(n), 2)]
dataset.means <- cbind(subject = subject, activity = activity, as.data.frame(t(d)))

write.table(dataset.means, "~/R/uci_har_dataset_means.txt", row.names = FALSE, quote = FALSE)