#' Calculate entropy for a vector of transcript-level
#' expression values of one gene.
#'
#' @param x Vector of expression values.
#' @param norm If \code{TRUE}, the entropy values are normalized to the number
#' of transcripts for each gene. The normalized entropy values are always
#' between 0 and 1. If \code{FALSE}, genes cannot be compared to each other,
#' due to possibly different maximum entropy values.
#' @param pseudocount Pseudocount added to each transcript expression value.
#' Default is 0, while Laplace entropy uses a pseudocount of 1.
#' @export
#' @return A single gene-level entropy value.
#' @details
#' The function calculates an entropy value as part of different
#' diversity calculations. Given a vector of transcript-level expression values
#' of a gene, this function characterizes the diversity of splicing isoforms for
#' a gene. If there only a single transcript, the diversity value will be NaN,
#' as it cannot be calculated. If the expression of the given gene is 0,
#' the diversity value will be NA.
#' @examples
#' # read counts for the transcripts of a single gene with 5 transcripts
#' x <- rnbinom(5, size = 10, prob = 0.4)
#' # calculate non-normalized naive entropy value
#' entropy <- calculate_entropy(x, norm = FALSE)
#' # calculate Laplace-entropy, also normalized for transcript number
#' # (the default)
#' norm_laplace_entropy <- calculate_entropy(x, pseudocount = 1)
calculate_entropy <- function(x, norm = TRUE, pseudocount = 0) {
    if (sum(x) != 0 & length(x) > 1) {
        x <- (x + pseudocount) / sum(x + pseudocount)
        x_log = ifelse(is.finite(log(x, base = 2)), log(x, base = 2), 0)

        if (norm == FALSE) {
            x = -sum(x * x_log)
        }
        if (norm == TRUE) {
            x = -sum(x * x_log) / log2(length(x))
        }
    } else if (length(x) == 1) {
        x = NaN
    } else {
        x = NA
    }
    return(x)
}

#' Calculate Gini coefficient for a vector of transcript-level
#' expression values of one gene.
#'
#' @param x Vector of expression values.
#' @export
#' @return A single gene-level Gini coefficient.
#' @details
#' The function calculates a Gini coefficient as part of different
#' diversity calculations. Given a vector of transcript-level expression values
#' of a gene, this function characterize the diversity of splicing isoforms for
#' a gene. If there only one single transcript, the resulted index will be NaN,
#' as diversity cannot be calculated. If the expression of the given gene is 0,
#' the diversity index will be NA.
#' @examples
#' # read counts for the transcripts of a single gene with 5 transcripts
#' x <- rnbinom(5, size = 10, prob = 0.4)
#' # calculate Gini index
#' gini <- calculate_gini(x)
calculate_gini <- function(x) {
    if (sum(x) != 0 & length(x) > 1) {
        x <- sort(x)
        y <- 2 * sum(x * seq_len(length(x))) / sum(x) - (length(x) + 1L)
        y <- y / (length(x) - 1L)
    } else if (length(x) == 1) {
        y = NaN
    } else {
        y = NA
    }
    return(y)
}

#' #' Calculate Simpson index for a vector of transcript-level
#' expression values of one gene.
#'
#' @param x Vector of expression values.
#' @export
#' @return A single gene-level Simpson index.
#' @details
#' The function calculates a Simpson index as part of different
#' diversity calculations. Given a vector of transcript-level expression values
#' of a gene, this function characterize the diversity of splicing isoforms for
#' a gene. If there only one single transcript, the resulted index will be NaN,
#' as diversity cannot be calculated. If the expression of the given gene is 0,
#' the diversity index will be NA.
#' @examples
#' # read counts for the transcripts of a single gene with 5 transcripts
#' x <- rnbinom(5, size = 10, prob = 0.4)
#' # calculate Simpson index
#' simpson <- calculate_simpson(x)
calculate_simpson <- function(x) {
    if (sum(x) != 0 & length(x) > 1) {
        x <- x / sum(x)
        x <- 1 - sum(x * x)
    } else if (length(x) == 1) {
        x = NaN
    } else {
        x = NA
    }
    return(x)
}

#' #' Calculate inverse Simpson index for a vector of transcript-level
#' expression values of one gene.
#'
#' @param x Vector of expression values.
#' @export
#' @return A single gene-level inverse Simpson index.
#' @details
#' The function calculates an inverse Simpson index as part of different
#' diversity calculations. Given a vector of transcript-level expression values
#' of a gene, this function characterize the diversity of splicing isoforms for
#' a gene. If there only one single transcript, the resulted index will be NaN,
#' as diversity cannot be calculated. If the expression of the given gene is 0,
#' the diversity index will be NA.
#' @examples
#' # read counts for the transcripts of a single gene with 5 transcripts
#' x <- rnbinom(5, size = 10, prob = 0.4)
#' # calculate inverse Simpson index
#' invsimpson <- calculate_inverse_simpson(x)
calculate_inverse_simpson <- function(x) {
    if (sum(x) != 0 & length(x) > 1) {
        x <- x / sum(x)
        x <- 1 / sum(x * x)
    } else if (length(x) == 1) {
        x = NaN
    } else {
        x = NA
    }
    return(x)
}
