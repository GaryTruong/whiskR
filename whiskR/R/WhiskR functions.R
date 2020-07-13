#' Calculate Segment Length
#'
#' This function allows you calculate where to cut to represent a specific time period.
#' @param L Length of the cut whisker
#' @param L.asym Asymptotic length
#' @param Time Time period to be represented by the cut segment in days
#' @param k Growth coefficient, calculate using the function k
#' @keywords whisker segment length
#' @export
#' @return Where to cut along the whisker
#' @examples
#' LP1(L=100, L.asym=150,Time=28 k=0.0126)
#'
LP1 <- function(L, L.asym, Time, k){
  section = format((L - (Time*(k*L.asym)))/(1-(Time*k)), digits = 4, nsmall = 1)
  paste(section, "mm", sep = "")
}

#' Calculate Time Represented by Segment
#'
#' This function allows you calculate how much time is represented by a sampled section of whisker.
#' @param L Length of the cut whisker
#' @param L.asym Asymptotic length
#' @param LP1 Length of the whisker minus the cut sampled segment
#' @param k Growth coefficient, calculate using the function k
#' @keywords whisker segment time
#' @export
#' @return Time represented by the sampled segment in days
#' @examples
#' TP1(L=100, L.asym=150, LP1=90, k=0.0126)
#'
TP1 <- function(L, L.asym, LP1, k){
  Time = format((L - LP1)/(k*(L.asym-LP1)), digits = 3, nsmall = 0)
  paste(Time, "days", sep = " ")
}


#' Calculate k growth coefficient
#'
#'
#' @param ML Maximum length
#' @param L.asym Asymptotic length
#' @param Time Estimated time to reach maximum length
#' @keywords k growth coefficient
#' @export
#' @return Time represented by the sampled segment in days
#' @examples
#' k(L= 100, )
#'
k <- function(ML, L.asym, Time){
  k = format((-log(1-ML/L.asym))/(Time), digits = 4)
  k
}




Intra.time <- function(L.int, L.asym, L, k){
  time = format((L.int)/(k*(L.asym - (L - L.int))), digits = 3, nsmall = 0)
  paste(time, "days", sep = " ")
}




MaxTime <- function(L , L.asym, k){
  Time = format((-log(1-L/L.asym))/(k), digits = 4, nsmall = 1)
  paste(Time, "days", sep = " ")
}
