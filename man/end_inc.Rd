\name{end_inc}
\alias{end_inc}
\title{Test for Incomplete Sentences}
\usage{
  end_inc(dataframe, text.var, warning.report = TRUE,
    which.mode = FALSE)
}
\arguments{
  \item{dataframe}{A dataframe that contains the person and
  text variable.}

  \item{text.var}{A character string of the text variable.}

  \item{warning.report}{logical.  If TRUE prints a warning
  of regarding removal of incomplete sentences.}

  \item{which.mode}{logical.  If TRUE outputs two logical
  vectors: NOT (logical test of not being an incomplete
  sentence) and INC (logical test of being an incomplete
  sentence)}
}
\value{
  Generates a dataframe with incomplete sentences removed.
}
\description{
  Test for incomplete sentences and optionally remove them.
}
\examples{
\dontrun{
dat <- sentSplit(DATA, "state", stem.col = FALSE)
dat$state[c(2, 5)] <- paste(strip(dat$state[c(2, 5)]), "|")
end_inc(dat, "state")
end_inc(dat, "state", warning.report = FALSE)
end_inc(dat, "state", which.mode = TRUE)
}
}
\keyword{incomplete}

