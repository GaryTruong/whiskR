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
  section = format((L - (Time*(k*L.asym)))/(1-(Time*k)), digits = 4, nsmall = 1)
  section
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
  time
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
  k
}


#' Calculate Time Period Represented by the Intradermal Section of the Whisker
#'
#' `IntraTime` is used to calculate the time period represented by the intradermal section of the whisker
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
#' IntraTime(L = 140, L.int = 10, L.asym = 150, k = 0.0126)
IntraTime <- function(L, L.int, L.asym, k){
  time = format((L.int)/(k*(L.asym - (L - L.int))), digits = 3, nsmall = 0)
  time
}
#paste(time, "days", sep = " ")

#' Calculate Maximum Time Represented by Sample
#'
#' `MaxTime` uses the simple Von Bertanlanffy equations to calculate the time represented by the entire sample
#' @param L      numeric; length of the entire sample
#' @param L.asym numeric; asymptotic length
#' @param k      numeric; growth coefficient, calculate using the function k
#' @keywords intradermal time von-Bertanlanffy
#' @export
#' @author The function was written by Gary Truong with collaboration from Ben Walker
#' and Anna Lewis from the University of New South Wales
#' @return The value returned is the number of days represented by the entire sample
#' @examples
#' MaxTime(L = 140, L.asym = 150, k = 0.0126)
MaxTime <- function(L , L.asym, k){
  time = format((-log(1-L/L.asym))/(k), digits = 4, nsmall = 1)
  time
}
#paste(Time, "days", sep = " ")
