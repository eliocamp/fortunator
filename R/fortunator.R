#' Create a fortune
#'
#' Creates a random fortune-like quote based on word frequency derived from the dataset in the
#' fortunes package.
#'
#' @param seed optional seed.
#'
#'
#' @examples
#'
#' fortunator(-814)
#' fortunator(943)
#' fortunator(-499)
#' fortunator(c(339, 12450))
#'
#'@export
fortunator <- function(seed = NULL) {
  checkmate::assert_numeric(seed, any.missing = FALSE, null.ok = TRUE)

  if (is.null(seed)) {
    res <- create_fortune()
  } else {
    res <- lapply(seed, function(s) withr::with_seed(s, create_fortune()))
    res <- stats::setNames(res, seed)
  }
  return(res)
}



create_fortune <- function(seed = NULL, n_max = 50) {
  next_word <- function(prev_word) {
    if (prev_word %in% freq$word) {
      next_word <- sample(freq[freq$word == prev_word, ]$next_word, size = 1, prob = freq[freq$word == prev_word, ]$prob)
    } else {
      # Si la palabra no aparece...
      next_word <- sample(freq$word, 1, prob = freq$prob)
    }

    return(next_word)
  }

  first_word <- sample(first_words$word, size = 1, prob = first_words$N)

  verse <- first_word
  next_word_word <- verse

  end_verse <- FALSE
  n <- 1
  while(end_verse == FALSE && n < n_max) {
    # browser(expr = n == 9)
    # browser()
    next_word_word <- next_word(next_word_word)

    capitalize_words <- c("r", "i")
    if (next_word_word %in% capitalize_words) {
      next_word_word <- toupper(next_word_word)
    }

    end_verse <- grepl("[?.!]$", next_word_word, perl = TRUE)
    punctuation <- grepl("[[:punct:]]", next_word_word) & nchar(next_word_word) == 1

    if (punctuation) {

      verse <- paste0(verse, next_word_word)
    } else {
      verse <- paste0(verse, " ", next_word_word)
    }
    n <- n + 1
  }

  verse
}

