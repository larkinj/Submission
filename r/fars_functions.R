#' Reads a Fatality Analysis Reporting System (FARS) file.
#'
#' The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
#' It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' FARS files can be downloaded from the NHTSA website - \url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}.
#'
#' This function reads a FARS file into the R namespace.
#'
#' @param filename A character string that represents the location of the FAR file on your computer.
#'
#' @return A Tibble containing the information in the FARS file.
#' @export
#'
#' @examples
#' \dontrun{fars_read("./data/accident_2013.csv.bz2")}
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' Constructs a FARS filename based on the year of interest.
#'
#' The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
#' It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' @param year The integer year that is of interest.
#'
#' @return A character string that represents the name of the file that is of interest given the input year.
#' @export
#'
#' @examples
#' \dontrun{make_filename(2013)}
make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}

#' Reads multiple Fatality Analysis Reporting System (FARS) files.
#'
#' The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
#' It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' Years must be represented by numeric values. Years represented as character strings will cause an error.
#'
#' FARS files should be situated in the working directory.
#' FARS files can be downloaded from the NHTSA website - \url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}.
#'
#' @param years A list of integer years that are of interest.
#'
#' @return A Tibble containing the information in a FARS file for each year of interest.
#' @export
#'
#' @examples
#' \dontrun{fars_read_years(2013:2015)}
#'
#' @importFrom dplyr mutate select
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' The information in FARS files for a given set of years is aggregated to provide a count of the number of incidents occuring each month.
#'
#' The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
#' It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' Years must be represented by numeric values. Years represented as character strings will cause an error.
#'
#' FARS files should be situated in the working directory.
#' FARS files can be downloaded from the NHTSA website - \url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}.
#'
#' @param years A list of integer years that are of interest.
#'
#' @return A Tibble containing the summarised information. The Tibble will have three columns - year, MONTH, and n.
#' @export
#'
#' @examples
#' \dontrun{fars_summarize_years(2013:2015)}
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}

#' Maps all the incidents occuring in a given state for a given year.
#'
#' The FARS is a nationwide census prepared by the US National Highway Traffic Safety Administration.
#' It provides the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' Years must be represented by numeric values. Years represented as character strings will cause an error.
#'
#' FARS files should be situated in the working directory.
#' FARS files can be downloaded from the NHTSA website - \url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}.
#'
#' Use of an invalid state number will cause an error.
#' The list of state numbers can be found in FARS user manual - \url{https://crashstats.nhtsa.dot.gov/Api/Public/ViewPublication/812602}
#'
#' @param state.num The numeric identifier of the state that is of interest.
#' @param year The integer year that is of interest.
#'
#' @return A graphic showing a map of the state of interest with the FARS incidents overlaid.
#' @export
#'
#' @examples
#' \dontrun{fars_map_state(1, 2013)}
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
