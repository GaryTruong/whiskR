#' Calculate Segment Length
#'
#' This function allows you calculate where to cut to represent a specific time period.
#' It uses the discrete step by step Von Bertanlanffy equation
#' @param L numeric; length of the cut sample
#' @param L.asym numeric; asymptotic length for the sample
#' @param Time numeric; time period to be represented by the cut segment in days
#' @param k numeric; growth coefficient, calculate using the function k
#' @keywords whisker segment length, Von-Bertanlanffy
#' @export
#' @author
#' @references Hall-Aspland, S. A., Rogers, T. L., & Canfield, R. B. (2005). Stable carbon and nitrogen isotope analysis reveals seasonal variation in the diet of leopard seals. Marine Ecology Progress Series, 305, 249-259.
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
#' It uses the discrete step by step Von Bertanlanffy equation
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


#' Calculate intradermal
#' @export
Intra.time <- function(L.int, L.asym, L, k){
  time = format((L.int)/(k*(L.asym - (L - L.int))), digits = 3, nsmall = 0)
  paste(time, "days", sep = " ")
}

#' Calculate Maximum Time represented by sample
#'
#' This function uses the simple Von Bertanlanffy equations to calculate the time represented by the entire sample
#' @export
MaxTime <- function(L , L.asym, k){
  Time = format((-log(1-L/L.asym))/(k), digits = 4, nsmall = 1)
  paste(Time, "days", sep = " ")
}
