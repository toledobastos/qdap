#' Kullback Leibler Statistic
#' 
#' A proximity measure between two probability distributions applied to speech.
#' 
#' @param x A numeric vector, matrix or data frame.
#' @param y A second numeric vector if x is also a vector.  Default is NULL.
#' @return Returns a matrix of the Kullback Leibler measure between each vector 
#' of probabilities.
#' @details Uses Kullback & Leibler's (1951) formula:
#' \deqn{D_{KL}(P||Q)=\sum_i{ln\left ( \frac{P_{i}}{Q_{i}} \right )}P_{i}}
#' @note The \code{kullback.leibler} function generally receives the output of
#' either \code{wfm} or \code{wfdf} functions.
#' @references  Kullback, S., & Leibler, R.A. (1951). On Information and 
#' sufficiency. Annals of Mathematical Statistics 22 (1): 79-86. 
#' doi:10.1214/aoms/1177729694
#' @keywords Kullback-Leibler
#' @export
#' @examples
#' \dontrun{
#' p.df <- wfdf(DATA$state, DATA$person)
#' p.mat <- wfm(text.var = DATA$state, grouping.var = DATA$person)
#' kullback.leibler(p.mat)
#' (x <- kullback.leibler(p.df))
#' print(x, digits = 5)
#' kullback.leibler(p.df$greg, p.df$sam)
#' 
#' ## p.df2 <- wfdf(raj$dialogue, raj$person)
#' ## x <- kullback.leibler(p.df2)
#' }
kullback.leibler <-
function(x, y = NULL){
    kl <- function(x, y){
        x1 <- x/sum(x)
        y1 <- y/sum(y)
        x1[x1==0] <- NA
        y1[y1==0] <- NA
        z <- na.omit(data.frame(x1, y1))
        sum(z[, 1] * log(z[, 1]/z[, 2]))
    }
    if(is.null(y) & !is.null(comment(x))){
        if (comment(x) %in% c("t.df")) {
            x <- x[, -c(1)]
        } else {
             if (is.null(y) & comment(x) %in% c("m.df")) { 
                 x <- x[-nrow(x), -c(1, ncol(x))]
             } else { 
                 x <- x
             }
        }
    } else {
        x <- x
    }
    if (is.null(y)) { 
        z <- v.outer(x, "kl")
    } else {
        z <- kl(x = x, y = y)
    }
    class(z) <- c("kullback.leibler", "data.frame")
    z
}

#' Prints a kullback.leibler Object.
#' 
#' Prints a kullback.leibler object.
#' 
#' @param x The kullback.leibler object
#' @param digits Number of decimal places to print. 
#' @param \ldots ignored
#' @method print kullback.leibler
#' @S3method print kullback.leibler
print.kullback.leibler <-
function(x, digits = 3, ...) {
    if (length(x) == 1) {
        y <- unclass(x)
        print(y)
    } else {
        WD <- options()[["width"]]
        options(width=3000)
        class(x) <- "matrix"
        if (!is.null(digits)) {
            x <- round(x, digits = digits)
        }
        print(x)
        options(width=WD)  
    }
}