\name{exclude}
\alias{exclude}
\title{Exclude Elements From a Vector}
\usage{
  exclude(word.list, ...)
}
\arguments{
  \item{word.list}{A list of words/terms to exclude from.}

  \item{\dots}{A vector (character/numeric) if element(s)
  to be excluded from the \code{word.list}.}
}
\value{
  Returns a vector with the excluded terms removed.
}
\description{
  Quickly exclude words from a word list
}
\examples{
\dontrun{
exclude(1:10, 3, 4)
exclude(1:10, 3:4)
Top25Words
exclude(Top25Words, qcv(the, of, and))
exclude(Top25Words, "the", "of", "an")

#Using with term.match and termco
terms <- term.match(DATA$state, qcv(th), FALSE)
exclude(terms, "truth")
#all together
termco(DATA$state, DATA$person, exclude(term.match(DATA$state, qcv(th),
    FALSE), "truth"))

MTCH.LST <- exclude(term.match(DATA$state, qcv(th, i)), qcv(truth, stinks))
termco(DATA$state, DATA$person, MTCH.LST)
}
}

