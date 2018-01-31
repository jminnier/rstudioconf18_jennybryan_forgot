library(tidyverse)
library(janitor)



#' Which libraries does R search for packages?
.Library
.libPaths()

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
ip%>%group_by(LibPath)%>%count()
ip%>%group_by(LibPath,Priority)%>%count()
##   * what proportion need compilation?
ip%>%tabyl(NeedsCompilation)
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
## study package naming style (all lower case, contains '.', etc
ip%>%mutate(has_dot = str_detect(Package,pattern=fixed(".")),
            has_underscore = str_detect(Package,pattern=fixed("_")),
            all_lowercase = str_to_lower(Package)==Package)%>%
  count(has_dot,has_underscore,all_lowercase)
## use `fields` argument to installed.packages() to get more info and use it!
