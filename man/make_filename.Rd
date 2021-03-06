% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{make_filename}
\alias{make_filename}
\title{Constructs a FARS filename based on the year of interest.}
\usage{
make_filename(year)
}
\arguments{
\item{year}{The integer year that is of interest.}
}
\value{
A character string that represents the name of the file that is of interest given the input year.
}
\description{
The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
}
\examples{
\dontrun{make_filename(2013)}

}
