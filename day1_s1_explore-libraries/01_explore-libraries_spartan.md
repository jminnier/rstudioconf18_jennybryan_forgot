01\_explore-libraries\_spartan.R
================
minnier
Wed Jan 31 14:25:53 2018

``` r
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
    ## ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
    ## ✔ tidyr   0.7.2          ✔ stringr 1.2.0     
    ## ✔ readr   1.1.1          ✔ forcats 0.2.0

    ## Warning: package 'tibble' was built under R version 3.4.3

    ## ── Conflicts ─────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(janitor)
library(fs)
```

Which libraries does R search for packages?

``` r
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
.libPaths()
```

    ## [1] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

``` r
path_real(.Library) # this actually is my true path, the .Library result is a symbolic link!!
```

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

-   reminder to use file.path() or other functions that are made to work with paths, not paste()
-   jenny is learning this new package `fs` with us Installed packages

``` r
## use installed.packages() to get all installed packages
ip <- installed.packages()
ip <- tbl_df(ip)
head(ip)
```

    ## # A tibble: 6 x 16
    ##   Package  LibPath  Version Priority Depends Imports  LinkingTo Suggests  
    ##   <chr>    <chr>    <chr>   <chr>    <chr>   <chr>    <chr>     <chr>     
    ## 1 abind    /Librar… 1.4-5   <NA>     R (>= … methods… <NA>      <NA>      
    ## 2 acepack  /Librar… 1.4.1   <NA>     <NA>    <NA>     <NA>      testthat  
    ## 3 addinsl… /Librar… 0.2     <NA>     R (>= … "curl, … <NA>      <NA>      
    ## 4 ade4     /Librar… 1.7-10  <NA>     R (>= … graphic… <NA>      "ade4TkGU…
    ## 5 AER      /Librar… 1.2-5   <NA>     "R (>=… stats, … <NA>      "boot, dy…
    ## 6 affxpar… /Librar… 1.48.0  <NA>     R (>= … <NA>     <NA>      R.oo (>= …
    ## # ... with 8 more variables: Enhances <chr>, License <chr>,
    ## #   License_is_FOSS <chr>, License_restricts_use <chr>, OS_type <chr>,
    ## #   MD5sum <chr>, NeedsCompilation <chr>, Built <chr>

``` r
## how many packages?
nrow(ip)
```

    ## [1] 673

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ip%>%count(LibPath)
```

    ## # A tibble: 1 x 2
    ##   LibPath                                                            n
    ##   <chr>                                                          <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources/library   673

``` r
ip%>%count(LibPath,Priority)
```

    ## # A tibble: 3 x 3
    ##   LibPath                                                 Priority       n
    ##   <chr>                                                   <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>         644

``` r
##   * what proportion need compilation?
ip%>%tabyl(NeedsCompilation) # jenny uses count and then mutate to calculate a prop = n/sum(n)
```

    ##  NeedsCompilation   n    percent valid_percent
    ##                no 344 0.51114413     0.5530547
    ##               yes 278 0.41307578     0.4469453
    ##              <NA>  51 0.07578009            NA

``` r
##   * how break down re: version of R they were built on
ip%>%tabyl(Built)
```

    ##  Built   n     percent
    ##  3.0.0   1 0.001485884
    ##  3.4.0 378 0.561664190
    ##  3.4.1 100 0.148588410
    ##  3.4.2 145 0.215453195
    ##  3.4.3  49 0.072808321

``` r
ip%>%filter(Built=="3.0.0")
```

    ## # A tibble: 1 x 16
    ##   Package  LibPath     Version Priority Depends Imports LinkingTo Suggests
    ##   <chr>    <chr>       <chr>   <chr>    <chr>   <chr>   <chr>     <chr>   
    ## 1 SVGAnno… /Library/F… 0.93-1  <NA>     Cairo,… <NA>    <NA>      RJSONIO 
    ## # ... with 8 more variables: Enhances <chr>, License <chr>,
    ## #   License_is_FOSS <chr>, License_restricts_use <chr>, OS_type <chr>,
    ## #   MD5sum <chr>, NeedsCompilation <chr>, Built <chr>

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
```

-   a good number need compilation (45%)
-   only a few Priority base (14), recommended (15)

``` r
##   * does the number of base + recommended packages make sense to you? yes
##   * how does the result of .libPaths() relate to the result of .Library?
```

-   .Library is in the Resources folder, .libPaths is in the versions folder and is specific to my R version Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended? I have no packages in .Library
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ip %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)[1:10]
```

    ##  [1] "abind"      "acepack"    "addinslist" "ade4"       "AER"       
    ##  [6] "affxparser" "affy"       "affyio"     "affyPLM"    "airway"

``` r
## study package naming style (all lower case, contains '.', etc
ip%>%mutate(has_dot = str_detect(Package,pattern=fixed(".")),
            has_underscore = str_detect(Package,pattern=fixed("_")),
            all_lowercase = str_to_lower(Package)==Package)%>%
  count(has_dot,has_underscore,all_lowercase)
```

    ## # A tibble: 4 x 4
    ##   has_dot has_underscore all_lowercase     n
    ##   <lgl>   <lgl>          <lgl>         <int>
    ## 1 F       F              F               211
    ## 2 F       F              T               436
    ## 3 T       F              F                12
    ## 4 T       F              T                14

``` r
## use `fields` argument to installed.packages() to get more info and use it!
ipf <- installed.packages(fields = c("License","Author"))
ipf <- tbl_df(ipf)
ipf%>%tabyl(License)%>%arrange(desc(n))
```

    ##                                        License   n     percent
    ## 1                                   GPL (>= 2) 133 0.197622585
    ## 2                                        GPL-2  90 0.133729569
    ## 3                           MIT + file LICENSE  86 0.127786033
    ## 4                                 Artistic-2.0  69 0.102526003
    ## 5                                        GPL-3  69 0.102526003
    ## 6                                          GPL  29 0.043090639
    ## 7                                GPL-2 | GPL-3  25 0.037147103
    ## 8                                   GPL (>= 3)  21 0.031203566
    ## 9                         GPL-3 | file LICENSE  15 0.022288262
    ## 10                             Part of R 3.4.2  14 0.020802377
    ## 11                                 LGPL (>= 2)  13 0.019316493
    ## 12                                        LGPL  11 0.016344725
    ## 13                 BSD_3_clause + file LICENSE   9 0.013372957
    ## 14                                         CC0   8 0.011887073
    ## 15                        GPL-2 | file LICENSE   7 0.010401189
    ## 16                                      LGPL-3   5 0.007429421
    ## 17                 BSD_2_clause + file LICENSE   4 0.005943536
    ## 18                               LGPL (>= 2.1)   4 0.005943536
    ## 19                     Apache License (== 2.0)   3 0.004457652
    ## 20                                file LICENSE   3 0.004457652
    ## 21                                GPL (>= 2.0)   3 0.004457652
    ## 22                                   GPL (>=2)   3 0.004457652
    ## 23                                         MIT   3 0.004457652
    ## 24                                      AGPL-3   2 0.002971768
    ## 25           Apache License 2.0 | file LICENSE   2 0.002971768
    ## 26                 Artistic-2.0 + file LICENSE   2 0.002971768
    ## 27                                         BSD   2 0.002971768
    ## 28                                         EPL   2 0.002971768
    ## 29                   GPL (>= 2) | file LICENCE   2 0.002971768
    ## 30                   GPL (>= 2) | file LICENSE   2 0.002971768
    ## 31                                 GPL (>=2.0)   2 0.002971768
    ## 32                               LGPL (>= 2.0)   2 0.002971768
    ## 33                                      LGPL-2   2 0.002971768
    ## 34                                   Unlimited   2 0.002971768
    ## 35                       AGPL-3 | file LICENSE   1 0.001485884
    ## 36                                  Apache 2.0   1 0.001485884
    ## 37      Apache License (== 2.0) | file LICENSE   1 0.001485884
    ## 38                     Apache License (>= 2.0)   1 0.001485884
    ## 39                          Apache License 2.0   1 0.001485884
    ## 40                        Artistic License 2.0   1 0.001485884
    ## 41                 Artistic-2.0 | file LICENSE   1 0.001485884
    ## 42                 BSD_3_clause + file LICENCE   1 0.001485884
    ## 43                                     BSL-1.0   1 0.001485884
    ## 44                                file LICENCE   1 0.001485884
    ## 45              FreeBSD | GPL-2 | file LICENSE   1 0.001485884
    ## 46                                GPL (>= 2.1)   1 0.001485884
    ## 47                        GPL-2 | file LICENCE   1 0.001485884
    ## 48 GPL-2 | GPL-3 | BSD_3_clause + file LICENSE   1 0.001485884
    ## 49                GPL-2 | GPL-3 | file LICENSE   1 0.001485884
    ## 50                  GPL-2 | LGPL-2.1 | MPL-1.1   1 0.001485884
    ## 51                                   GPL(>= 2)   1 0.001485884
    ## 52                                 LGPL (>= 3)   1 0.001485884
    ## 53                                  LGPL (>=2)   1 0.001485884
    ## 54                                    LGPL-2.1   1 0.001485884
    ## 55                       Lucent Public License   1 0.001485884
    ## 56              MIT + file LICENSE | Unlimited   1 0.001485884
    ## 57                                  MPL (>= 2)   1 0.001485884
    ## 58                   What license is it under?   1 0.001485884

How many packages are by one of the Wickhams?

``` r
ipf <- ipf%>%mutate(by_hadley = str_detect(Author,"Hadley"),
             by_wickham = str_detect(Author,"Wickham"))
ipf%>%count(by_hadley,by_wickham)
```

    ## # A tibble: 3 x 3
    ##   by_hadley by_wickham     n
    ##   <lgl>     <lgl>      <int>
    ## 1 F         F            607
    ## 2 F         T              2
    ## 3 T         T             64

Where's Charlotte?

``` r
ipf%>%filter((!by_hadley)&by_wickham)%>%pull(Author)
```

    ## [1] "Charlotte Wickham <cwickham@gmail.com>"               
    ## [2] "Jennifer Bryan [aut, cre],\n  Charlotte Wickham [ctb]"

``` r
ipf%>%filter((!by_hadley)&by_wickham)%>%pull(Package)
```

    ## [1] "munsell"     "repurrrsive"

``` r
devtools::session_info()
```

    ## Session info -------------------------------------------------------------

    ##  setting  value                       
    ##  version  R version 3.4.2 (2017-09-28)
    ##  system   x86_64, darwin15.6.0        
    ##  ui       X11                         
    ##  language (EN)                        
    ##  collate  en_US.UTF-8                 
    ##  tz       America/Los_Angeles         
    ##  date     2018-01-31

    ## Packages -----------------------------------------------------------------

    ##  package    * version    date       source                            
    ##  assertthat   0.2.0      2017-04-11 CRAN (R 3.4.0)                    
    ##  backports    1.1.2      2017-12-13 CRAN (R 3.4.2)                    
    ##  base       * 3.4.2      2017-10-04 local                             
    ##  bindr        0.1        2016-11-13 CRAN (R 3.4.0)                    
    ##  bindrcpp   * 0.2        2017-06-17 CRAN (R 3.4.0)                    
    ##  broom        0.4.3      2017-11-20 CRAN (R 3.4.2)                    
    ##  cellranger   1.1.0      2016-07-27 cran (@1.1.0)                     
    ##  cli          1.0.0      2017-11-05 CRAN (R 3.4.2)                    
    ##  colorspace   1.3-2      2016-12-14 cran (@1.3-2)                     
    ##  compiler     3.4.2      2017-10-04 local                             
    ##  crayon       1.3.4      2017-09-16 CRAN (R 3.4.1)                    
    ##  datasets   * 3.4.2      2017-10-04 local                             
    ##  devtools     1.13.4     2017-11-09 CRAN (R 3.4.2)                    
    ##  digest       0.6.14     2018-01-14 cran (@0.6.14)                    
    ##  dplyr      * 0.7.4      2017-09-28 CRAN (R 3.4.2)                    
    ##  evaluate     0.10.1     2017-06-24 CRAN (R 3.4.1)                    
    ##  forcats    * 0.2.0      2017-01-23 cran (@0.2.0)                     
    ##  foreign      0.8-69     2017-06-22 CRAN (R 3.4.2)                    
    ##  fs         * 1.1.0      2018-01-31 Github (r-lib/fs@46a39e6)         
    ##  ggplot2    * 2.2.1.9000 2018-01-20 Github (tidyverse/ggplot2@f61bfd6)
    ##  glue         1.2.0      2017-10-29 CRAN (R 3.4.2)                    
    ##  graphics   * 3.4.2      2017-10-04 local                             
    ##  grDevices  * 3.4.2      2017-10-04 local                             
    ##  grid         3.4.2      2017-10-04 local                             
    ##  gtable       0.2.0      2016-02-26 cran (@0.2.0)                     
    ##  haven        1.1.0      2017-07-09 cran (@1.1.0)                     
    ##  hms          0.4.0      2017-11-23 CRAN (R 3.4.3)                    
    ##  htmltools    0.3.6      2017-04-28 CRAN (R 3.4.0)                    
    ##  httr         1.3.1      2017-08-20 CRAN (R 3.4.1)                    
    ##  janitor    * 0.4.0.9000 2018-01-17 Github (sfirke/janitor@d71ab8c)   
    ##  jsonlite     1.5        2017-06-01 CRAN (R 3.4.0)                    
    ##  knitr        1.17       2017-08-10 CRAN (R 3.4.1)                    
    ##  lattice      0.20-35    2017-03-25 CRAN (R 3.4.2)                    
    ##  lazyeval     0.2.1      2017-10-29 CRAN (R 3.4.2)                    
    ##  lubridate    1.7.1      2017-11-03 CRAN (R 3.4.2)                    
    ##  magrittr     1.5        2014-11-22 CRAN (R 3.4.0)                    
    ##  memoise      1.1.0      2017-04-21 CRAN (R 3.4.0)                    
    ##  methods    * 3.4.2      2017-10-04 local                             
    ##  mnormt       1.5-5      2016-10-15 CRAN (R 3.4.0)                    
    ##  modelr       0.1.1      2017-07-24 cran (@0.1.1)                     
    ##  munsell      0.4.3      2016-02-13 cran (@0.4.3)                     
    ##  nlme         3.1-131    2017-02-06 CRAN (R 3.4.2)                    
    ##  parallel     3.4.2      2017-10-04 local                             
    ##  pillar       1.1.0      2018-01-14 cran (@1.1.0)                     
    ##  pkgconfig    2.0.1      2017-03-21 CRAN (R 3.4.0)                    
    ##  plyr         1.8.4      2016-06-08 CRAN (R 3.4.0)                    
    ##  psych        1.7.8      2017-09-09 CRAN (R 3.4.2)                    
    ##  purrr      * 0.2.4      2017-10-18 CRAN (R 3.4.2)                    
    ##  R6           2.2.2      2017-06-17 CRAN (R 3.4.0)                    
    ##  Rcpp         0.12.15    2018-01-20 cran (@0.12.15)                   
    ##  readr      * 1.1.1      2017-05-16 CRAN (R 3.4.0)                    
    ##  readxl       1.0.0      2017-04-18 cran (@1.0.0)                     
    ##  reshape2     1.4.3      2017-12-11 CRAN (R 3.4.3)                    
    ##  rlang        0.1.6.9003 2018-01-31 Github (tidyverse/rlang@c6747f9)  
    ##  rmarkdown    1.8        2017-11-17 CRAN (R 3.4.2)                    
    ##  rprojroot    1.2        2017-01-16 CRAN (R 3.4.0)                    
    ##  rstudioapi   0.7        2017-09-07 CRAN (R 3.4.1)                    
    ##  rvest        0.3.2      2016-06-17 cran (@0.3.2)                     
    ##  scales       0.5.0.9000 2018-01-17 Github (hadley/scales@d767915)    
    ##  stats      * 3.4.2      2017-10-04 local                             
    ##  stringi      1.1.6      2017-11-17 CRAN (R 3.4.2)                    
    ##  stringr    * 1.2.0      2017-02-18 CRAN (R 3.4.0)                    
    ##  tibble     * 1.4.2      2018-01-22 cran (@1.4.2)                     
    ##  tidyr      * 0.7.2      2017-10-16 CRAN (R 3.4.2)                    
    ##  tidyverse  * 1.2.1      2017-11-14 CRAN (R 3.4.2)                    
    ##  tools        3.4.2      2017-10-04 local                             
    ##  utf8         1.1.3      2018-01-03 cran (@1.1.3)                     
    ##  utils      * 3.4.2      2017-10-04 local                             
    ##  withr        2.1.1.9000 2018-01-17 Github (jimhester/withr@df18523)  
    ##  xml2         1.2.0      2018-01-24 cran (@1.2.0)                     
    ##  yaml         2.1.16     2017-12-12 CRAN (R 3.4.3)
