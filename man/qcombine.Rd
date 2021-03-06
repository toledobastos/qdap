\name{qcombine}
\alias{qcombine}
\title{Combine Columns}
\usage{
  qcombine(mat, combined.columns, elim.old = TRUE)
}
\arguments{
  \item{mat}{A matrix or dataframe with numeric combine
  columns.}

  \item{combined.columns}{A list of named vectors of the
  colnames/indexes of the numeric columns to be combined
  (summed).  If a vector is unnamed a name will be
  assigned.}

  \item{elim.old}{logical.  If TRUE eliminates the columns
  that are combined together by the named match.list. TRUE
  outputs the table proportionally (see
  \code{\link[qdap]{prop}}).}
}
\value{
  Returns a dataframe with combines columns.
}
\description{
  Quickly combine columns (summed) and rename.
}
\examples{
\dontrun{
A <- list(
    a = c(1, 2, 3),
    b = qcv(mpg, hp),
    c = c("disp", "am")
)
B <- list(
    c(1, 2, 3),
    d = qcv(mpg, hp),
    c("disp", "am")
)

qcombine(head(mtcars), A)
qcombine(head(mtcars), B)
qcombine(head(mtcars), B, elim.old = FALSE)
}
}
\seealso{
  \code{\link[base]{transform}}
}
\keyword{combine,}
\keyword{transform}

