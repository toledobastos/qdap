\name{dir_map}
\alias{dir_map}
\title{Map Transcript Files from a Directory to a Script}
\usage{
  dir_map(loc, obj.prefix = "dat",
    col.names = c("person", "dialogue"), file = NULL,
    copy2clip = TRUE)
}
\arguments{
  \item{loc}{The path/location of the transcript data
  files.}

  \item{obj.prefix}{A character string that will be used as
  the prefix (followed by a unique digit) as the assignment
  object.}

  \item{col.names}{Supplies a vector of column names to the
  transcript columns.}

  \item{file}{A connection, or a character string naming
  the file to print to.}

  \item{copy2clip}{logical.  If TRUE attempts to copy the
  output to the clipboard.}
}
\value{
  Prints a read in script text to the console, optionally
  copies the wrapped text to the clipboard on a Mac or
  Windows machine and optionally prints to an outside file.
}
\description{
  Generate script text (and optionally output it to the
  clipboard and/or an external file) that can be used to
  individually read in every file in a directory and assign
  it to an object.
}
\details{
  Generally, the researcher will want to read in and parse
  every transcript document separately.  The task of
  writing the script for multiple transcript documents can
  be tedious.  This function is designed to make the
  process more efficient and less prone to errors.
}
\note{
  \code{skip} is set to 0, however, it is likely that this
  value will need to be changed for each transcript.
}
\examples{
\dontrun{
(DIR <- system.file("extdata", package = "qdap"))
dir_map(DIR)
}
}
\seealso{
  \code{\link[qdap]{read.transcript}}
}

