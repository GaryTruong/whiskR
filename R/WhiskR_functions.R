#' Calculate Segment Length Based on Specific Time Period
#'
#' `LP1` allows you calculate where to cut to represent a specific time period.
#' It uses the discrete step by step von Bertanlanffy equation solved for L(p-1)
#' @param L      numeric; length of the sample
#' @param L.asym numeric; asymptotic length
#' @param Time   numeric; time period in days to be represented by the cut segment
#' @param k      numeric; growth coefficient, calculate using the function k
#' @keywords whisker segment length, von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @references Hall-Aspland, S. A., Rogers, T. L., & Canfield, R. B. (2005). Stable carbon and nitrogen isotope
#' analysis reveals seasonal variation in the diet of leopard seals. Marine Ecology Progress Series, 305, 249-259.
#' @return The value returned is the location in millimetres, along the sample, to be cut to obtain a segment
#' representing the number of days indicated by the Time argument
#' @examples
#' LP1(L = 100, L.asym = 150, Time = 28, k = 0.0126)
#'
LP1 <- function(L, L.asym, Time, k){
  section = format((L - (Time*(k*L.asym)))/(1-(Time*k)))
  as.numeric(section)
}
#paste(section, "mm", sep = "")

#' Calculate Time Represented by Cut Segment
#'
#' `TP1` allows you calculate how much time is represented by a section of sampled tissue.
#' It uses the discrete step by step von Bertanlanffy equation solved for time
#' @param L      numeric; length of the sample
#' @param L.asym numeric; asymptotic length
#' @param LP1    numeric; length of the sample minus the cut sampled segment
#' @param k      numeric; growth coefficient, calculate using the function k
#' @keywords whisker segment time von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @references Hall-Aspland, S. A., Rogers, T. L., & Canfield, R. B. (2005). Stable carbon and nitrogen isotope
#' analysis reveals seasonal variation in the diet of leopard seals. Marine Ecology Progress Series, 305, 249-259.
#' @return The value returned is the number of days represented by the cut segment.
#' @examples
#' TP1(L = 100, L.asym = 150, LP1 = 90, k = 0.0126)
#'
TP1 <- function(L, L.asym, LP1, k){
  time = format((L - LP1)/(k*(L.asym-LP1)), digits = 3, nsmall = 0)
  as.numeric(time)
}
#paste(Time, "days", sep = " ")


#' Calculate k Growth Coefficient
#'
#' The `k` function is used to calculate the growth coefficient 'k' used in the von Bertanlanffy growth models.
#' @param L.max  numeric; maximum length observed across all samples
#' @param L.asym numeric; asymptotic length
#' @param Time   numeric; estimated time to reach maximum length
#' @keywords k growth coefficient, von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @references Hall-Aspland, S. A., Rogers, T. L., & Canfield, R. B. (2005). Stable carbon and nitrogen isotope
#' analysis reveals seasonal variation in the diet of leopard seals. Marine Ecology Progress Series, 305, 249-259.
#' @return The value returned is the growth coefficient 'k' used in the von Bertanlanffy growth model
#' @examples
#' k(L.max = 148.5, L.asym = 150, Time = 365)
#'
k <- function(L.max, L.asym, Time){
  k = format((-log(1-L.max/L.asym))/(Time), digits = 4)
  as.numeric(k)
}


#' Calculate Time Period Represented by the Intradermal Section of the Whisker
#'
#' `intraTime` is used to calculate the time period represented by the intradermal section of the whisker
#' @param L      numeric; length of the entire whisker minus the intradermal section
#' @param L.int  numeric; intradermal length of the whisker
#' @param L.asym numeric; asymptotic length
#' @param k      numeric; growth coefficient, calculate using the function k
#' @keywords intradermal time von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @return The value returned is the number of days represented by the intradermal section of the whisker
#' @examples
#' intraTime(L = 140, L.int = 10, L.asym = 150, k = 0.0126)
intraTime <- function(L, L.int, L.asym, k){
  time = format((L.int)/(k*(L.asym - (L - L.int))), digits = 3, nsmall = 0)
  as.numeric(time)
}
#paste(time, "days", sep = " ")

#' Calculate Maximum Time Represented by Sample
#'
#' `maxTime` uses the simple Von Bertanlanffy equations to calculate the time represented by the entire sample
#' @param L      numeric; length of the entire sample
#' @param L.asym numeric; asymptotic length
#' @param k      numeric; growth coefficient, calculate using the function k
#' @keywords intradermal time von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @return The value returned is the number of days represented by the entire sample
#' @examples
#' maxTime(L = 140, L.asym = 150, k = 0.0126)
maxTime <- function(L , L.asym, k){
  time = format((-log(1-L/L.asym))/(k), digits = 4, nsmall = 1)
  as.numeric(time)
}
#paste(Time, "days", sep = " ")


#' Generate a Table of Section Positions
#'
#' `section` uses the LP1 function to generate a tibble of all the sections legnths representing 1 day of growth.
#' @param L       numeric; the starting length of the sample
#' @param L.asym. numeric; asymptotic length
#' @param k       numeric; growth coefficient, calculate using the function k
#' @param Time    numeric; period of growth to be represented by each section. Default is 1 day.
#' @importFrom magrittr %>%
#' @export
section <- function(L, L.asym, k, Time = 1){
  out <- list(0)
  name <- value <- L.start <- L.end <- NULL
  a <- as.numeric(whiskR::LP1(L, L.asym, Time, k))
  out[1] <- a
  out[2] <- Time
  out[3] <- L
  out[[3]][2] <- a
  for(i in 1:1000){
    if(a > 0 & a < L){
      a <- as.numeric(out[[1]][i]) %>%
        whiskR::LP1(L.asym, Time, k)
      out[[1]][i+1] = a
      out[[2]][i+1] = Time
      out[[3]][i+2] = a
    }else{
      stop
    }
  }
  x <- tibble::enframe(as.numeric(out[[3]])) %>%
    dplyr::select(name, L.start = value)
  y <- tibble::enframe(as.numeric(out[[2]])) %>%
    dplyr::select(name, time = value)
  z <- tibble::enframe(as.numeric(out[[1]])) %>%
    dplyr::select(name,L.end = value)
  x %>% dplyr::left_join(z) %>% dplyr::left_join(y) %>%
    dplyr::filter(L.end > 0) %>%
    dplyr::mutate(SectionLength = L.start-L.end, Date = date())
}
