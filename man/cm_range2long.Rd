\name{cm_range2long}
\alias{cm_range2long}
\title{Transform Codes to Start-End Durations}
\usage{
  cm_range2long(..., v.name = "variable", list.var = TRUE,
    debug = TRUE)
}
\arguments{
  \item{\ldots}{list object(s) in the form generated by
  \code{\link[qdap]{cm_time.temp}}.}

  \item{v.name}{sn optional name for the column created for
  the list.var argument.}

  \item{list.var}{logical.  If TRUE creates a column for
  the data frame created by each time.list passed to
  \code{cm_t2l}.}

  \item{debug}{logical. If TRUE debugging mode is on.
  \code{\link[qdap]{cm_time2long}} will return possible
  errors in time span inputs.}
}
\value{
  Generates a data frame of start and end times for each
  code.
}
\description{
  Transforms the range coding structure(s) from
  cm_range.temp (in list format) into a data frame of start
  and end durations in long format.
}
\examples{
\dontrun{
foo <- list(
    person_greg = qcv(terms='7:11, 20:24, 30:33, 49:56'),
    person_researcher = qcv(terms='42:48'),
    person_sally = qcv(terms='25:29, 37:41'),
    person_sam = qcv(terms='1:6, 16:19, 34:36'),
    person_teacher = qcv(terms='12:15'),
    adult_0 = qcv(terms='1:11, 16:41, 49:56'),
    adult_1 = qcv(terms='12:15, 42:48'),
    AA = qcv(terms="1"),
    BB = qcv(terms="1:2, 3:10, 19"),
    CC = qcv(terms="1:9, 100:150")
)

foo2  <- list(
    person_greg = qcv(terms='7:11, 20:24, 30:33, 49:56'),
    person_researcher = qcv(terms='42:48'),
    person_sally = qcv(terms='25:29, 37:41'),
    person_sam = qcv(terms='1:6, 16:19, 34:36'),
    person_teacher = qcv(terms='12:15'),
    adult_0 = qcv(terms='1:11, 16:41, 49:56'),
    adult_1 = qcv(terms='12:15, 42:48'),
    AA = qcv(terms="40"),
    BB = qcv(terms="50:90"),
    CC = qcv(terms="60:90, 100:120, 150"),
    DD = qcv(terms="")
)

(dat <- cm_range2long(foo, foo2, v.name = "time"))
gantt_wrap(dat, "code", "time")
}
}
\references{
  Miles, M. B. & Huberman, A. M. (1994). An expanded
  sourcebook: Qualitative data analysis. 2nd ed. Thousand
  Oaks, CA: SAGE Publications.
}
\seealso{
  \code{\link[qdap]{cm_df2long}},
  \code{\link[qdap]{cm_time.temp}},
  \code{\link[qdap]{cm_df.transcript}}
}
\keyword{coding,}
\keyword{span}
\keyword{time}

