#' ---
#' output: github_document
#' ---

library(tidyverse)
library(janitor)
library(fs)

#' Which libraries does R search for packages?
.Library
.libPaths()
path_real(.Library) # this actually is my true path, the .Library result is a symbolic link!!

#' - reminder to use file.path() or other functions that are made to work with paths, not paste()
#' - jenny is learning this new package `fs` with us

#' Installed packages

## use installed.packages() to get all installed packages
ip <- installed.packages()
ip <- tbl_df(ip)
head(ip)
## how many packages?
nrow(ip)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ip%>%count(LibPath)
ip%>%count(LibPath,Priority)
##   * what proportion need compilation?
ip%>%tabyl(NeedsCompilation) # jenny uses count and then mutate to calculate a prop = n/sum(n)
##   * how break down re: version of R they were built on
ip%>%tabyl(Built)
ip%>%filter(Built=="3.0.0")

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
#' - a good number need compilation (45%)
#' - only a few Priority base (14), recommended (15)
##   * does the number of base + recommended packages make sense to you? yes
##   * how does the result of .libPaths() relate to the result of .Library?
#' - .Library is in the Resources folder, .libPaths is in the versions folder and is specific to my R version

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended? I have no packages in .Library
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ip %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)[1:10]

## study package naming style (all lower case, contains '.', etc
ip%>%mutate(has_dot = str_detect(Package,pattern=fixed(".")),
            has_underscore = str_detect(Package,pattern=fixed("_")),
            all_lowercase = str_to_lower(Package)==Package)%>%
  count(has_dot,has_underscore,all_lowercase)
## use `fields` argument to installed.packages() to get more info and use it!
ipf <- installed.packages(fields = c("License","Author"))
ipf <- tbl_df(ipf)
ipf%>%tabyl(License)%>%arrange(desc(n))

#' How many packages are by one of the Wickhams?
ipf <- ipf%>%mutate(by_hadley = str_detect(Author,"Hadley"),
             by_wickham = str_detect(Author,"Wickham"))
ipf%>%count(by_hadley,by_wickham)
#' Where's Charlotte?
ipf%>%filter((!by_hadley)&by_wickham)%>%pull(Author)
ipf%>%filter((!by_hadley)&by_wickham)%>%pull(Package)

devtools::session_info()
