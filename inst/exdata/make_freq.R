library(data.table)
library(magrittr)

corpus <- as.data.table(na.omit(fortunes::read.fortunes()))



first_words <- corpus %>%
  .[, id := 1:.N] %>%
  .[, tidytext::unnest_tokens(.SD, word, quote, strip_punct = FALSE, to_lower = FALSE), by = id] %>%
  .[, .SD[1], by = id] %>%
  .[, .N, by = word]


freq <- corpus %>%
  copy() %>%
  .[, has_punct := grepl("^[\\w\\s]+[?.!]$", quote, perl = TRUE)] %>%
  .[has_punct == FALSE, quote := paste0(quote, ".")] %>%
  tidytext::unnest_tokens(word, quote, strip_punct = FALSE, to_lower = FALSE) %>%
  as.data.table()  %>%
  .[, next_word := shift(word, type = "lead")] %>%
  na.omit() %>%
  .[, n_word := .N, by = .(word)] %>%               # número de veces que aparece la palabra (para normalizar)
  .[, .(n_next_word = .N, n_word = n_word[1]), by = .(word, next_word)] %>%
  .[, prob := n_next_word/n_word] %>%
  .[n_word > 5] %>%                                    # me quedo con las palabras que aparecen más de 5 veces
  .[order(-prob)]

usethis::use_data(first_words, freq, internal = TRUE, overwrite = TRUE)
