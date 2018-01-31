library(fs)
library(here)

## Sketch of how I would copy the .R files from, e.g.,
## ~/Desktop/day1_s1_explore-libraries
## to the current project

#' JM: Since i already pade a project containing both folders, I will copy from one folder to this folder.

## build a path to the other project
## try to practice "safe file paths" -- but first, just make it work!

#other_path <- fs::path("day1_s1_explore-libraries/") # doing this and then `other_path` makes R studio abort!
other_path <- here::here("day1_s1_explore-libraries/")
dir(other_path)

new_path <- fs::path("day1_s2_copy-files/")
dir(new_path)


## get paths to the files in that directory ... just the .R files
myfiles <- dir(
  other_path,
  pattern = "\\.R$", #needed Jenny's help for this
  full.names = TRUE
)

## these are what you need to copy!

## form the new file names, based on existing file names
myfiles_new <- fs::path(new_path,fs::path_file(myfiles)) # trying to look at myfiles_new crashes R


## copy the files from there to here

fs::file_copy(path = myfiles,new_path = myfiles_new)

## list the files here (and look in file browser) to verify success

dir(new_path)
file.remove(myfiles_new) # clean it up
dir(new_path)


## Done already? Ideas to keep you going:
## Can you make your code cleaner, tighter, more readable, more robust? DO IT.
## Try again, now using the fs package.

## Copy again, using fs ----
from_dir <- path("day1_s1_explore-libraries")
from_files <- dir_ls(from_dir, glob = "*.R")
to_files <- path("day1_s2_copy-files",path_file(from_files))
out <- file_copy(from_files, to_files)
dir_ls("day1_s2_copy-files")
dir_info("day1_s2_copy-files")

## Can you figure out why Jenny names projects and files the way she does?
## Can you make a nice data frame of metadata, with one row per file or project?
