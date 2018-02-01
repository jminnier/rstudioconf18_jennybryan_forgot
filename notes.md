Notes - Things They Forgot to Teach You In R, rstuido::conf18
================
Jessica Minnier
1/31/2018

Thanks to the excellent contributions (via `pull` request!) from classmate [Peter Higgins!](https://github.com/higgi13425)

Links:
======

Materials: [rstd.io/forgot](https://github.com/jennybc/what-they-forgot)

To use "in building" mirror: `options(repos = c(CRAN = "https://cran.rstudio.com/"))`

Random thoughts
===============

Day 1: Morning - library exploration
------------------------------------

-   JB has us go to issues and put emoji on OS, tests that we've signed into github! also sees how many windows users there are
-   it's ok that things take a long time
-   make things self explaining, don't spend a lot of time writing wordy explainers that you have to maintain and won't want to read later
-   organize your files and keep readme up to date!
-   "unless you can keep it current, don't write it"
-   it helps to know about your R installation and where packages go in order to make a package
-   new package `fs`, helps us work with file paths. note, don't use paste() to work with file paths like they are strings, they are not!

Day 1: Mid-morning - file copying and naming, projects
------------------------------------------------------

-   turn of .RData loading and never ask to save .RData
-   restart R often!
-   no absolute paths
-   use a stable base: `here::here("data","raw-data.csv")` in your project directory, `fs::path_home()`
-   form paths at runtime relative to a stable base
-   normalizePath() makes it work on both windows and mac
-   Rstudio set up a mirror for downloading packages **in** the building! What!
-   use `basename` instead of `strsplit` to get name of file (don't have to specify  or /)
-   name files and directories as thing\_thing-info\_thing2 so for instance day\_session\_topic so you can order and deliminate them later

Side note from my own issues in moving this repo to github
----------------------------------------------------------

How to add an existing Rstudio repo to github:

This has changed since [git 2.9](https://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories), now when you add remote and then pull you need a special option. This only needs to happen if you added a Readme. Just don't do this and life will be easier.

    git remote add origin https://github.com/jminnier/rstudioconf18_jennybryan_forgot.git
    git pull origin master --allow-unrelated-histories

Most easy option from [happywithgitr](http://happygitwithr.com/existing-github-last.html)

    usethis::use_github()

Day 1: Afternoon - git/github
-----------------------------

-   git is scary but you should learn the 3 things you always have to do and just do them over and over until you are comfortable ("get off the beach!")
-   easier to start from github then go to rstudio (sad)
-   when you clone a repo in Rstudio and copy the ssh (or https) into the prompt, then press TAB, it will auto-fill the name of the repo into the next field!
-   in git commit: two yellow question marks: local file git has never seen before
-   jenny commits her .Rproj (this is controversial)
-   intermediate step "staging" tells git you do want these files to be part of the next commit, this way you can commit files separately
-   use conventional file extensions so that github can show you customized diffs
-   jenny thinks putting derived products in version control is a good idea (i.e. html from Rmds)
-   jim hester will show us how github makes it easy to search code
-   when using workbook button from .R files we get a html report (jenny says html maybe not best option, more later)
-   oh yeah, html does not look good on github =( too raw!
-   mullet: what you need to write (.R, .Rmd) = this business in front; what you want to read/see (.html, .md) = party in the back (or is it the other way around?)
-   .html is not useful but .md is useful for github; use YAML:

        #' ---
        #' output: github_document
        #' ---

-   now github will render the resulting .md file this to look pretty nice!
-   source only hard-liners say don't version control output (only source code). but this makes it really useful to see what the output looks like and how it changes.
-   JB takeaway 1: if you want to make your stuff immediately consumable, rending to markdown and commiting that at the same time as the R file, gives something others can look at with little to no effort (be kind and be realistic!)
-   JB takeaway 2: markdown is vastly more useful than .html and .pdf (on github)
-   More about github\_documents [here](http://rmarkdown.rstudio.com/github_document_format.html)
-   files that look nice in github: .csv, .png, .md, see the browsability section of happywithgitr

Day 1: Afternoon after break
============================

-   to upload an existing git directory to github without going through all the steps, just do `usethis::use_github()`!!!
-   JB showing that .R and .Rmd can make same github\_document output
-   Good options for knitr:

        knitr::opts_chunk$set(
              collapse = TRUE,
              comment = "#>",
              out.width = "100%"
        )

-   git can detect simmple push conflicts (i.e. you forgot to pull first)
-   if you are collaborating on code: commit and push (and pull) often, so that you make small changes that git's troubleshooting push fail algorithm can handle it; "sync to the mothership really often"
-   also working with binary files like pdf makes this really hard since git can't look inside them to figure out what the problem is. so, don't put them in your repo very often!
-   use githooks to avoid pushing files that have conflicts (they can look for the markers from the merge conflict)
-   you can search github for code snippets (I need to do this more!), such as: ["llply" user:cran language:R](https://github.com/search?l=r&q=%22llply%22+user%3Acran+language%3AR&ref=searchresults&type=Code&utf8=%E2%9C%93); Jim Hester will talk more about this tomorrow

Q's
===

-   what about versioning data? for small to medium you can easily use github, might need to just keep it in a separate repo and git that, or might need to use gitfs for large file systems
-   in the analysis pipeline, if I want to generate an html (or pdf etc) file along with the github\_document, is there a way to always generate both? you can "keep md" but can you "keep github\_document"? Sort of, but you need to use `rmarkdown::render` (in theory, though JB can't get it to work yet for github\_docs...)
-   why is `fs` package making Rstudio crash every time I want to view an object created with it? May be related to this [issue](https://github.com/r-lib/fs/issues/58)
