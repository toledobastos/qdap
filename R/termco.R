#' Search For and Count Terms
#' 
#' \code{termco} - Search a transcript by any number of grouping variables for 
#' categories (themes) of grouped root terms.  While there are other termco 
#' functions in the termco family (e.g., \code{\link[qdap]{termco.d}}) 
#' \code{termco} is a more powerful and flexible wrapper intended for general 
#' use.
#' 
#' @param text.var The text variable.
#' @param grouping.var The grouping variables.  Default NULL generates one word 
#' list for all text.  Also takes a single grouping variable or a list of 1 or 
#' more grouping variables.
#' @param match.list A list of named character vectors.
#' @param short.term logical.  If TRUE column names are trimmed versions of the 
#' match list, otherwise the terms are wrapped with 'term(phrase)'
#' @param ignore.case logical.  If TRUE case is ignored.
#' @param elim.old logical.  If TRUE eliminates the columns that are combined 
#' together by the named match.list.
#' @param percent logical.  If TRUE output given as percent.  If FALSE the 
#' output is proportion.
#' @param digits Integer; number of decimal places to round when printing.   
#' @param apostrophe.remove logical.  If TRUE removes apostrophes from the text 
#' before examining.
#' @param char.keep A character vector of symbol character (i.e., punctuation) 
#' that strip should keep.  The default is to strip everything except 
#' apostrophes. \code{\link[qdap]{termco}} attempts to auto detect characters to 
#' keep based on the elements in \code{match.list}. 
#' @param digit.remove logical.  If TRUE strips digits from the text before 
#' counting. \code{\link[qdap]{termco}} attempts to auto detect if digits should 
#' be retained based on the elements in \code{match.list}. 
#' @param zero.replace Value to replace 0 values with.
#' @param \ldots Other argument supplied to strip.
#' @return \code{termco} & \code{termco.d} - both return a list, of class 
#' "termco.d", of data frames and information regarding word counts:
#' \item{raw}{raw word counts by grouping variable} 
#' \item{prop}{proportional word counts by grouping variable; proportional to 
#' each individual's word use} 
#' \item{rnp}{a character combination data frame of raw and proportional}     
#' \item{zero_replace}{value to replace zeros with; mostly internal use}   
#' \item{percent}{The value of percent used for plotting purposes.}
#' \item{digits}{integer value of number of digits to display; mostly internal 
#' use}  
#' @section Warning: Percentages are calculated as a ratio of counts of 
#' \code{match.list} elements to word counts.  Word counts do not contain 
#' symbols or digits.  Using symbols, digits or small segments of full words 
#' (e.g., "to") could total more than 100\%.
#' @rdname termco  
#' @note The match.list/match.string is (optionally) case and character 
#' sensitive.  Spacing is an important way to grab specific words and requires 
#' careful thought.  Using "read" will find the words "bread", "read" "reading", 
#' and "ready".  If you want to search for just the word "read" you'd supply a 
#' vector of c(" read ", " reads", " reading", " reader").  To search for non 
#' character arguments (i.e., numbers and symbols) additional arguments from 
#' strip must be passed.
#' @seealso \code{\link[qdap]{termco.c}}
#' @keywords word-search
#' @export
#' @examples
#' \dontrun{
#' #termco examples:
#' 
#' term <- c("the ", "she", " wh")
#' with(raj.act.1,  termco(dialogue, person, term))
#' # General form for match.list as themes
#' #
#' # ml <- list(
#' #     cat1 = c(),
#' #     cat2 = c(),
#' #     catn = c()
#' # )
#' 
#' ml <- list(
#'     cat1 = c(" the ", " a ", " an "),
#'     cat2 = c(" I'" ),
#'     "good",
#'     the = c("the", " the ", " the", "the")
#' )
#' 
#' (dat <- with(raj.act.1,  termco(dialogue, person, ml)))
#' names(dat)
#' dat$rnp  #useful for presenting in tables
#' dat$raw  #prop and raw are useful for performing calculations
#' dat$prop
#' datb <- with(raj.act.1, termco(dialogue, person, ml,
#'     short.term = FALSE, elim.old=FALSE))
#' ltruncdf(datb, 20, 6)
#'     
#' (dat2 <- data.frame(dialogue=c("@@bryan is bryan good @@br",
#'     "indeed", "@@ brian"), person=qcv(A, B, A)))
#' 
#' ml2 <- list(wrds=c("bryan", "indeed"), "@@", bryan=c("bryan", "@@ br", "@@br"))
#' 
#' with(dat2, termco(dialogue, person, match.list=ml2))
#' 
#' with(dat2, termco(dialogue, person, match.list=ml2, percent = FALSE))
#' 
#' DATA$state[1] <- "12 4 rgfr  r0ffrg0"
#' termco(DATA$state, DATA$person, '0', digit.remove=FALSE)
#' DATA <- qdap::DATA
#' 
#' #Using with term.match and exclude    
#' exclude(term.match(DATA$state, qcv(th), FALSE), "truth")
#' termco(DATA$state, DATA$person, exclude(term.match(DATA$state, qcv(th), 
#'     FALSE), "truth"))
#' MTCH.LST <- exclude(term.match(DATA$state, qcv(th, i)), qcv(truth, stinks))
#' termco(DATA$state, DATA$person, MTCH.LST)
#' 
#' syns <- synonyms("doubt")
#' syns[1]
#' termco(DATA$state, DATA$person, unlist(syns[1]))
#' synonyms("doubt", FALSE)
#' termco(DATA$state, DATA$person, list(doubt = synonyms("doubt", FALSE)))
#' termco(DATA$state, DATA$person, syns)
#' 
#' #termco.d examples:
#' termco.d(DATA$state, DATA$person, c(" the", " i'"))
#' termco.d(DATA$state, DATA$person, c(" the", " i'"), ignore.case=FALSE)
#' termco.d(DATA$state, DATA$person, c(" the ", " i'"))
#' 
#' # termco2mat example:
#' MTCH.LST <- exclude(term.match(DATA$state, qcv(a, i)), qcv(is, it, am, shall))
#' termco_obj <- termco(DATA$state, DATA$person, MTCH.LST)
#' termco2mat(termco_obj)
#' plot(termco_obj)
#' plot(termco_obj, label = TRUE)
#' plot(termco_obj, label = TRUE, text.color = "red")
#' plot(termco_obj, label = TRUE, text.color="red", lab.digits=3)
#' }
termco <-
function (text.var, grouping.var = NULL, match.list, short.term = TRUE,
    ignore.case = TRUE, elim.old = TRUE, percent = TRUE, digits = 2, 
    apostrophe.remove = FALSE, char.keep = NULL, digit.remove = NULL, 
    zero.replace = 0, ...) {
    if (!is.list(match.list)) {
        names(match.list) <- NULL
    }  
    x <- unlist(match.list)
    a <- grepl("[^a-zA-Z[:space:]]", x)
    if (any(a)) {
        b <- grepl("[0-9]", x)
        if (any(b) & is.null(digit.remove)) {   
            digit.remove <- FALSE  
        }
        if (any(a + b == 1) & is.null(char.keep)) {  
            char.keep = unlist(strsplit(paste(gsub("[a-zA-Z0-9[:space:]]", 
                "", x), collapse=""), NULL)) 
        }
    }
    if(!all(is.null(names(match.list))) && 
        any(duplicated(unblanker(names(match.list))))) {
        stop("Repeated vector name in match.list")
    }
    if (is.list(match.list) & length(match.list) == 1 & is.null(names(match.list))) {
        match.list <- unlist(match.list)
    }
    mprot <- names(match.list) != "" & sapply(match.list, length) == 1
    if (is.null(grouping.var)) {
        NAME <- "all"
    } else {
        if (is.list(grouping.var)) {
            m <- unlist(as.character(substitute(grouping.var))[-1])
            m <- sapply(strsplit(m, "$", fixed = TRUE), 
                function(x) x[length(x)])
            NAME <- paste(m, collapse = "&")
        } else {
            G <- as.character(substitute(grouping.var))
            NAME <- G[length(G)]
        }
    }
    preIND <- match.list
    IND <- unlist(lapply(preIND, length))
    new.names <- paste0("term(", names(IND)[IND != 1], ")")
    CC <- match.list[names(match.list) != ""]
    ML <- unlist(match.list)
    TD <- termco.d(text.var = text.var, grouping.var = grouping.var, 
        match.string = ML, ignore.case = ignore.case, percent = percent, 
        apostrophe.remove = apostrophe.remove, char.keep = NULL, 
        digit.remove = FALSE, digits = digits, zero.replace = zero.replace, ...)
    colnames(TD[[3]]) <- colnames(TD[[1]])
    if (is.list(preIND)) {
        if(length(IND) == sum(IND)){
            o <- TD
        } else {
            o <- termco.c(TD, combined.columns = CC, new.name = new.names, 
                zero.replace = zero.replace, short.term = TRUE, 
                elim.old = elim.old, percent = percent, digits = digits)
        }
    } else {
        o <- TD
    }
    colnames(o[[3]]) <- colnames(o[[2]]) <- colnames(o[[1]])
    if (is.list(match.list) && length(CC) != length(match.list)){
        lens <- sapply(match.list, length)
        if(any(names(match.list) %in% "")) {
            blanks <- names(match.list) %in% ""
            if (any(lens[blanks] > 1)) {
                stop("Vectors in match.list must be named or of length one")
            }
            names(match.list)[blanks] <- unlist(match.list[blanks])
        }
    }
    o[1:3] <- lapply(o[1:3], function(x) {
        nms2 <- colnames(x)[!colnames(x) %in% names(match.list)]
        mat <- x[, !colnames(x) %in% names(match.list), drop=FALSE]
        colnames(mat) <- nms2
        mat2 <- x[, names(match.list), drop=FALSE]
        x <- data.frame(mat, mat2, check.names = FALSE)
        colnames(x)[1] <- NAME
        rownames(x) <- NULL
        x
    })
    if (!short.term & is.list(match.list)) {
        o[1:3] <- lapply(o[1:3], function(x) {
            colnames(x)[-c(1:2)] <- paste0("term(", colnames(x)[-c(1:2)], ")")
            return(x)
        })
    }
    if (short.term) {
        o <- termco2short.term(o)
    }
    class(o) <- "termco"
    o
}

#' Search for Terms
#' 
#' \code{termco.d} - Search a transcript by any number of grouping variables for 
#' root terms.
#' 
#' @param match.string A vector of terms to search for.  When using inside of 
#' \code{term.match} the term(s) must be words or partial words but do not have 
#' to be when using \code{\link[qdap]{termco.d}} (i.e., they can be phrases, 
#' symbols etc.).
#' @rdname termco
#' @export
termco.d <-
  function (text.var, grouping.var=NULL, match.string, short.term = FALSE,
    ignore.case = TRUE, zero.replace = 0, percent = TRUE,  digits = 2, 
    apostrophe.remove = FALSE, char.keep = NULL, digit.remove = TRUE, ...){
    x <- unlist(match.string)
    a <- grepl("[^a-zA-Z[:space:]]", x)
    if (any(a)) {
        b <- grepl("[0-9]", x)
        if (any(b) & is.null(digit.remove)) {   
            digit.remove <- FALSE  
        } 
        if (any(a + b == 1) & is.null(char.keep)) {  
            char.keep = unlist(strsplit(paste(gsub("[a-zA-Z0-9[:space:]]", 
                "", x), collapse=""), NULL)) 
        }
    }
    if (is.null(grouping.var)) {
        NAME <- "all"
    } else {
        if (is.list(grouping.var)) {
            m <- unlist(as.character(substitute(grouping.var))[-1])
            m <- sapply(strsplit(m, "$", fixed = TRUE), function(x) {
                x[length(x)]
            })
            NAME <- paste(m, collapse = "&")
        } else {
            G <- as.character(substitute(grouping.var))
            NAME <- G[length(G)]
        }
    }
    x <- termco.h(text.var = strip(text.var, lower.case = FALSE, 
       char.keep = char.keep, digit.remove = digit.remove,
        apostrophe.remove = apostrophe.remove, ...), 
        match.string = match.string, grouping.var = grouping.var, 
        ignore.case = ignore.case)
    colnames(x)[1] <- NAME
    y <- termco.p(tco = x, percent = percent)
    rnp <- raw_pro_comb(raw = x[, -c(1:2), drop =FALSE], 
        pro = y[, -c(1:2), drop =FALSE], digits = digits, 
        percent = percent, zero.replace = 0, override = TRUE)
    rnp  <- data.frame(x[, 1:2], rnp, check.names = FALSE)
    o <- list(raw = x, prop = y, rnp = rnp, zero.replace = zero.replace,
        percent = percent, digits = digits)
    class(o) <- "termco"
    if (short.term) {
        o <- termco2short.term(o)
    }
    class(o) <- "termco"    
    o 
}


#' Search a Transcript for Terms
#' 
#' \code{term.match} - Search a transcript for words that exactly match term(s).
#' 
#' @param terms The terms to search for in the \code{text.var}.  Similar to 
#' \code{match.list} but these terms must be words or partial words rather than 
#' multiple words and symbols.
#' @param return.list logical.  If TRUE returns the output for multiple terms as 
#' a list by term rather than a vector.
#' @return \code{term.match} -  returns a list or vector of possible words that 
#' match term(s).
#' @rdname termco
#' @export
term.match <-
function(text.var, terms, return.list=TRUE, apostrophe.remove=FALSE) {
    y <- stopwords(text.var, stopwords = NULL, 
        unlist=TRUE, strip=TRUE, unique=TRUE, apostrophe.remove=apostrophe.remove)
    x <- lapply(unlist(terms), function(z) {
        v <- term.find(y, mat = z, logic=TRUE)
        y[v]
    })
    names(x) <- unlist(terms)
    if (!return.list){
        x <- sort(unique(unlist(x)))
    }
    x
}


#' Convert a termco dataframe to a matrix
#' 
#' \code{termco2mat} - Convert a termco dataframe to a matrix for use with 
#' visualization functions (e.g., \code{\link[gplots]{heatmap.2}}).
#' 
#' @param dataframe A termco (or termco.d) dataframe or object.
#' @param drop.wc logical.  If TRUE the word count column will be dropped.
#' @param rm.zerocol logical.  If TRUE any column containing all zeros will be 
#' removed from the matrix.
#' @param no.quote logical.  If TRUE the matrix will be printed without quotes
#' if it's character.
#' @param transform logical.  If TRUE the matrix will be transformed.
#' @param trim.terms logical.  If TRUE trims the column header/names to ensure 
#' there is not a problem with spacing when using in other R functions.
#' @return \code{termco2mat} - returns a matrix of term counts.
#' @rdname termco
#' @export
termco2mat <-function (dataframe, drop.wc = TRUE, short.term = TRUE, 
  rm.zerocol = FALSE, no.quote = TRUE, transform = TRUE, trim.terms = TRUE) {
  if (class(dataframe) %in% c("termco")) {
    dataframe <- dataframe[["raw"]]
  }
  if (!is.data.frame(dataframe)) {
    stop("Please supply a data.frame to termco2mat")
  }
  ind <- if (drop.wc) {
    1:2
  } else {
    1
  }
  MAT <- as.matrix(dataframe[, -c(ind), drop = FALSE])
  rownames(MAT) <- dataframe[, 1]
  if (short.term) {
    mn <- gsub("(.*)\\)([^\\)]*)", "\\1\\2", colnames(MAT))
    colnames(MAT) <- gsub("term(", "", mn, fixed=TRUE)
  }
  if (rm.zerocol) {
    fun <- function(x) all(ifelse(x == 0, T, F))
    MAT <- MAT[, !apply(MAT, 2, fun)]
  }
  OC <- length(grep("(", as.vector(unlist(MAT)), fixed = TRUE)) == 0
  if (OC) {
    z <- rownames(MAT)
    MAT <- apply(MAT, 2, as.numeric)
    rownames(MAT) <- z
  }
  if (no.quote & !OC){ 
    MAT <- noquote(MAT)
  }
  if (transform){
    MAT <- t(MAT)
  }
  if (trim.terms) {
    rownames(MAT) <- Trim(rownames(MAT))
  }
  MAT
}

#' Prints a termco object.
#' 
#' Prints a termco object.
#' 
#' @param x The termco object
#' @param digits Integer values specifying the number of digits to be 
#' printed.
#' @param percent logical.  If TRUE output given as percent.  If FALSE the 
#' output is proportion.  If NULL uses the value from 
#' \code{\link[qdap]{termco}}.  Only used if \code{label} is TRUE.
#' @param zero.replace Value to replace 0 values with.  If NULL uses the value 
#' from \code{\link[qdap]{termco}}.  Only used if \code{label} is TRUE.
#' @param \ldots ignored
#' @S3method print termco
#' @method print termco
print.termco <-
function(x, digits = NULL, percent = NULL, zero.replace = NULL, ...) {
    WD <- options()[["width"]]
    options(width=3000)
    if (!is.null(percent)) {
        if (percent != x$percent) {
            DF <- as.matrix(x$prop[, -c(1:2)])
            if (percent) {
                DF <- DF*100    
            } else {
                DF <-  DF/100
            }
            x$prop <- data.frame(x$prop[, 1:2], DF, check.names = FALSE) 
        }
    } else {
        percent <- x$percent 
    }
    if (is.null(zero.replace)) {
        zero.replace <- x$zero.replace
    }
    if (is.null(digits)) {
        digits <- x$digits
    }    
    rnp <- raw_pro_comb(x$raw[, -c(1:2), drop = FALSE], 
        x$prop[, -c(1:2), drop = FALSE], digits = digits, percent = percent, 
        zero.replace = zero.replace, override = TRUE)  
    rnp <- data.frame(x$raw[, 1:2], rnp, check.names = FALSE)  
    colnames(rnp) <- colnames(x[[1]])   
    print(rnp)
    options(width=WD)
}

#' Plots a termco object
#' 
#' Plots a termco object.
#' 
#' @param x The termco object.
#' @param label logical.  If TRUE the cells of the heat map plot will be labeled 
#' with count and proportional values.
#' @param lab.digits Integer values specifying the number of digits to be 
#' printed if \code{label} is TRUE.
#' @param percent logical.  If TRUE output given as percent.  If FALSE the 
#' output is proportion.  If NULL uses the value from 
#' \code{\link[qdap]{termco}}.  Only used if \code{label} is TRUE.
#' @param zero.replace Value to replace 0 values with.  If NULL uses the value 
#' from \code{\link[qdap]{termco}}.  Only used if \code{label} is TRUE.
#' @param \ldots Other arguments passed to qheat.
#' @method plot termco
#' @export
plot.termco <- function(x, label = FALSE, lab.digits = 1, percent = NULL, 
    zero.replace = NULL, ...) {
    if (label) {
        if (!is.null(percent)) {
            if (percent != x$percent) {
                DF <- as.matrix(x$prop[, -c(1:2)])
                if (percent) {
                    DF <- DF*100    
                } else {
                    DF <-  DF/100
                }
                x$prop <- data.frame(x$prop[, 1:2], DF, check.names = FALSE) 
            }
        } else {
            percent <- x$percent 
        }
        if (is.null(zero.replace)) {
            zero.replace <- x$zero.replace
        }
    rnp <- raw_pro_comb(x$raw[, -c(1:2), drop = FALSE], 
        x$prop[, -c(1:2), drop = FALSE], digits = lab.digits, percent = percent, 
        zero.replace = zero.replace) 
        rnp <- data.frame(x$raw[, 1:2], rnp, check.names = FALSE) 
        qheat(x$prop, values=TRUE, mat2 = rnp, ...)
    } else {
        qheat(x$prop, ...)  
    }
}