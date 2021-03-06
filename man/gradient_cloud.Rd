\name{gradient_cloud}
\alias{gradient_cloud}
\title{Gradient Word Cloud}
\usage{
  gradient_cloud(text.var, bigroup.var, rev.bivar = FALSE,
    X = "red", Y = "blue", stem = FALSE, stopwords = NULL,
    caps = TRUE, caps.list = NULL, I.list = TRUE,
    random.order = FALSE, rot.per = 0, min.freq = 1,
    max.word.size = NULL, min.word.size = 0.5, breaks = 10,
    cloud.font = NULL, title = NULL, title.font = NULL,
    title.color = "black", title.padj = 0.25,
    title.location = 3, title.cex = NULL, legend.cex = 0.8,
    legend.location = c(0.025, 0.025, 0.25, 0.04),
    char2space = "~~")
}
\arguments{
  \item{text.var}{The text variable.}

  \item{bigroup.var}{A binary grouping variable.}

  \item{rev.bivar}{logical.  If TRUE the ordering of the
  bi-variate levels is reversed.}

  \item{X}{The first gradient color for variable X.}

  \item{Y}{The second gradient color for variable Y.}

  \item{stem}{logical.  If TRUE the \code{text.var} will be
  stemmed.}

  \item{stopwords}{Words to exclude from the cloud.  Words
  will be removed after determing proportional word usage.}

  \item{caps}{logical.  If TRUE selected words will be
  capitalized.}

  \item{caps.list}{A vector of words to capitalize
  (\code{caps} must be TRUE).}

  \item{I.list}{logical.  If TRUE capitalizes I words and
  contractions.}

  \item{random.order}{Plot words in random order. If false,
  they will be plotted in decreasing frequency.}

  \item{rot.per}{Proportion words with 90 degree rotation.}

  \item{min.freq}{An integer value indicating the minimum
  frequency a word must appear to be included.}

  \item{max.word.size}{A size argument to control the
  minimum size of the words.}

  \item{min.word.size}{A size argument to control the
  maximum size of the words.}

  \item{breaks}{An integer describing the number of breaks
  (odd numbers will be rounded up).}

  \item{cloud.font}{The font family of the cloud text.}

  \item{title}{A character string used as the plot title.}

  \item{title.font}{The font family of the cloud title.}

  \item{title.color}{A character vector of length one
  corresponding to the color of the title.}

  \item{title.padj}{Adjustment for the title. For strings
  parallel to the axes, padj = 0 means right or top
  alignment, and padj = 1 means left or bottom alignment.}

  \item{title.location}{On which side of the plot
  (1=bottom, 2=left, 3=top, 4=right).}

  \item{title.cex}{Character expansion factor for the
  title. NULL and NA are equivalent to 1.0.}

  \item{legend.cex}{Character expansion factor for the
  legend. NULL and NA are equivalent to 1.0.}

  \item{legend.location}{A vector of length 4 denoting the
  lower left (x and y left) and upper right (x and y right)
  coordinates of the rectange of colors in user
  coordinates.}

  \item{char2space}{A vector of characters to be turned
  into spaces.}
}
\value{
  Plots a gradient word cloud and invisibly returns the
  dataframe used to make the cloud.
}
\description{
  Produces a gradient word cloud colored by a binary
  grouping variable.
}
\details{
  Breaking is done using \code{\link[stats]{quantile}}.
  This will ensure a certain percentage of words will be
  colored at each bin.
}
\examples{
\dontrun{
DATA$state <- space_fill(DATA$state, c("is fun", "too fun", "you liar"))

gradient_cloud(DATA$state, DATA$sex, title="fun")
gradient_cloud(DATA$state, DATA$sex, title="fun", rev.bivar = TRUE)
gradient_cloud(DATA$state, DATA$sex, title="fun", max.word.size = 5,
    min.word.size = .025)

with(mraja1, gradient_cloud(dialogue, died, stopwords = Top25Words,
    rot.per = .5, title="Heatcloud", title.color="orange", title.cex=1.75))
x <- with(subset(mraja1, fam.aff \%in\% qcv(cap, mont)),
    gradient_cloud(dialogue, fam.aff))
head(x)
}
}
\seealso{
  \code{\link[qdap]{trans.cloud}},
  \code{\link[wordcloud]{wordcloud}},
  \code{\link[plotrix]{color.legend}}
}
\keyword{heatcloud}

