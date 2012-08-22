read.transcript <-
function(file, text.var = NULL, header = TRUE, dash = "",
    ellipsis = "...", quote2bracket = FALSE, rm.empty.rows = TRUE, 
    col.names = NULL, sep = ",") {
    require(gdata) 
    x <-gdata::read.xls(file,  header = header, sep = sep, 
        as.is=FALSE, na.strings= c("999", "NA", " "), strip.white = TRUE, 
        stringsAsFactors = FALSE, blank.lines.skip = rm.empty.rows) 
    if (!is.null(text.var) & !is.numeric(text.var)) {
        text.var <- which(colnames(x) == text.var)
    } else {
        text.col <- function(dataframe) {
            dial <- function(x) {
                if(is.factor(x) | is.character(x)) {
                    n <- max(nchar(as.character(x)))
                } else {
                    n <- NA
                }
            }
            which.max(unlist(lapply(dataframe, dial)))
        }
        text.var <- text.col(x)
    }
    x[, text.var] <- as.character(x[, text.var])
    x[, text.var] <- Trim(iconv(x[, text.var], "", "ASCII", "byte"))
    if (quote2bracket == TRUE) {
        rbrac <- "}"
        lbrac <- "{"
    } else {
        if (length(quote2bracket) == 2) {
            rbrac <- quote2bracket[2]
            lbrac <- quote2bracket[1]
        } else {
            lbrac <- rbrac <- ""
        }
    }
    reps <- c(lbrac, rbrac, "'", "'", "'", ellipsis, dash, dash)
    ser <- c("<e2><80><9c>", "<e2><80><9d>", "<e2><80><99>", 
        "<e2><80><9b>", "<ef><bc><87>", "<e2><80><a6>", "<e2><80><93>", 
        "<e2><80><94>")
    Encoding(x[, text.var]) <-"latin1"
    x[, text.var] <- clean(mgsub(ser, reps, x[, text.var]))
    if(rm.empty.rows) {
        x <- rm_empty_row(x) 
    }
    if (!is.null(col.names)) {
        colnames(x) <- col.names
    }
    return(x)
}