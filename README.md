
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fortunator

<!-- badges: start -->

<!-- badges: end -->

Have you already memorised all qutoes int the
[fortunes](https://cran.r-project.org/web/packages/fortunes/index.html)
package and you are hungry for more? fortunator is for you\! Using our
higly advanced AI™ and Machine Learning™ algorithm, we’ve developed a
function that can create literally\["literal\] infinite fortunes\!

## Installation

You can install the latest, shiniest version of fortunator from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("eliocamp/fortunator")
```

## Example

Using fortunator couldn’t be easier just load the library and start
enjoying deep, thoughful quotes about your faviourite programming
language\!

``` r
library(fortunator)

fortunator(seed = 943)
#> $`943`
#> [1] "This is not the way?"
fortunator(611)
#> $`611`
#> [1] "As one or patent know it."
fortunator(339)
#> $`339`
#> [1] "Don't documentation."
```

If you want unreproducible wisdom, then you can omit the seed and be
surprised every time\!

``` r
fortunator()
#> [1] "It gently also do what I want informative statistical practice\" Mess!"
```
