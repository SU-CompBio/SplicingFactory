% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_difference.R
\name{calculate_difference}
\alias{calculate_difference}
\title{Calculate splicing diversity changes between two conditions.}
\usage{
calculate_difference(
  x,
  samples,
  control,
  method = "mean",
  test = "wilcoxon",
  randomizations = 100,
  pcorr = "BH",
  assayno = 1,
  verbose = FALSE,
  ...
)
}
\arguments{
\item{x}{A \code{SummarizedExperiment} with splicing diversity values for
each gene in each sample or a \code{data.frame} with gene names in the
first column and splicing diversity values for each sample in additional
columns.}

\item{samples}{A vector of length one, specifying the column name of the
\code{colData} annotation column from the \code{SummarizedExperiment}
object, that should be used as the category column or a character vector
with an equal length to the number of columns in the input dataset,
specifying the category of each sample in the case of a \code{data.frame}
input.}

\item{control}{Name of the control sample category, defined in the
\code{samples} vector, e.g. \code{control = 'Normal'} or \code{control =
'WT'}.}

\item{method}{Method to use for calculating the average splicing diversity
value in a condition. Can be \code{'mean'} or \code{'median'}.}

\item{test}{Method to use for p-value calculation: use \code{'wilcoxon'} for
Wilcoxon rank sum test or \code{'shuffle'} for a label shuffling test.}

\item{randomizations}{Number of random shuffles, used for the label shuffling
test (default = 100).}

\item{pcorr}{P-value correction method applied to the Wilcoxon rank sum test
or label shuffling test results, as defined in the \code{p.adjust}
function.}

\item{assayno}{An integer value. In case of multiple assays in a
\code{SummarizedExperiment} input, the argument specifies the assay number
to use for difference calculations.}

\item{verbose}{If \code{TRUE}, the function will print additional diagnostic
messages.}

\item{...}{Further arguments to be passed on for other methods.}
}
\value{
A \code{data.frame} with the mean or median values of splicing
  diversity across sample categories and all samples, log2(fold change) of
  the two different conditions, raw and corrected p-values.
}
\description{
Calculate splicing diversity changes between two conditions.
}
\details{
The function calculates diversity changes between two sample
conditions. It uses the output of the diversity calculation function, which
is a \code{SummarizedExperiment} object of splicing diversity values.
Additionally, it can use a \code{data.frame} as input, where the first column
contains gene names, and all additional columns contain splicing diversity
values for each sample. A vector of sample conditions also serves as input,
used for aggregating the samples by condition.

It calculates the mean or median of the splicing diversity data per sample
condition, the difference of these values and the log2 fold change of the two
conditions. Furthermore, the user can select a statistical method to
calculate the significance of the changes. The p-values and adjusted p-values
are calculated using a Wilcoxon sum rank test or label shuffling test.

The function will exclude genes of low sample size from the significance
calculation, depending on which statistical test is applied.
}
\examples{
# data.frame with splicing diversity values
x <- data.frame(Genes = letters[seq_len(10)], matrix(runif(80), ncol = 8))

# sample categories
samples <- c(rep('Healthy', 4), rep('Pathogenic', 4))

# To calculate the difference of splicing diversity changes between the
# 'Healthy' and 'Pathogenic' condition together with the significance values,
# using mean and Wilcoxon rank sum test, use:
calculate_difference(x, samples, control = 'Healthy', method = 'mean', test = 'wilcoxon')
}
