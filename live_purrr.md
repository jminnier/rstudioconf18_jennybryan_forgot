Live code from purrr session at rstudio::conf
================
Jenny Bryan
2018-02-01

Where to find this document
---------------------------

Shortlink humans can type:

-   <http://bit.ly/jenny-live-code>

Horrible link that reveals how this is done:

-   <https://www.dropbox.com/s/2b8mi4rir23pvnx/jenny-live-code.R?raw=1>

Using the `raw=1` query trick for rendering a DropBox-hosted file in the browser:

-   <https://www.dropbox.com/en/help/desktop-web/force-download> learned from [Michael Levy](https://twitter.com/ucdlevy).

How this works:

-   I code live in an R script locally. I save often.
-   This file lives in a directory synced to DropBox.
-   You open the DropBox file at <http://bit.ly/jenny-live-code> and refresh as needed.
-   Should allow you to see, copy, paste everything I've typed and save the entire transcript at the end. This file is highly perishable, so save your own copy if you want it.
-   Every now and then the refresh won't work. Just re-open from from the bit.ly link: <http://bit.ly/jenny-live-code>

Workshop material starts here
-----------------------------

``` r
library(tidyverse) ## includes purrr, which is our main attraction today
## ── Attaching packages ──────────────────────────────────────── tidyverse 1.2.1 ──
## ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
## ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
## ✔ tidyr   0.7.2          ✔ stringr 1.2.0     
## ✔ readr   1.1.1          ✔ forcats 0.2.0
## Warning: package 'tibble' was built under R version 3.4.3
## ── Conflicts ─────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
library(repurrrsive)

## Completely frivolous playing around with different idioms
## for iteration
## Will wake everyone up and focus on ITERATION!

## https://github.com/brooke-watson/BRRR
## devtools::install_github("brooke-watson/BRRR")
library(BRRR)
## Error in library(BRRR): there is no package called 'BRRR'

skrrrahh(2)
## Error in skrrrahh(2): could not find function "skrrrahh"
skrrrahh(35)
## Error in skrrrahh(35): could not find function "skrrrahh"
skrrrahh("bigsean5")
## Error in skrrrahh("bigsean5"): could not find function "skrrrahh"

for(i in 1:5) {
  Sys.sleep(0.75)
  skrrrahh(i)
}
## Error in skrrrahh(i): could not find function "skrrrahh"

walk(1:5, ~{Sys.sleep(0.75); BRRR::skrrrahh(.x)})
## Error in loadNamespace(name): there is no package called 'BRRR'

f <- function(sound, sleep = 0.75) {
  Sys.sleep(sleep)
  skrrrahh(sound)
}

walk(30:35, f)
## Error in skrrrahh(sound): could not find function "skrrrahh"

## Hello Game of Thrones characters + list inspection ----

?got_chars

# ick
str(got_chars)
## List of 30
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##   ..$ id         : int 1022
##   ..$ name       : chr "Theon Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 278 AC or 279 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Prince of Winterfell" "Captain of Sea Bitch" "Lord of the Iron Islands (by law of the green lands)"
##   ..$ aliases    : chr [1:4] "Prince of Fools" "Theon Turncloak" "Reek" "Theon Kinslayer"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr [1:2] "A Clash of Kings" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Alfie Allen"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ id         : int 1052
##   ..$ name       : chr "Tyrion Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 273 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Acting Hand of the King (former)" "Master of Coin (former)"
##   ..$ aliases    : chr [1:11] "The Imp" "Halfman" "The boyman" "Giant of Lannister" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/2044"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:2] "A Feast for Crows" "The World of Ice and Fire"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Peter Dinklage"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1074"
##   ..$ id         : int 1074
##   ..$ name       : chr "Victarion Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 268 AC or before, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Lord Captain of the Iron Fleet" "Master of the Iron Victory"
##   ..$ aliases    : chr "The Iron Captain"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1109"
##   ..$ id         : int 1109
##   ..$ name       : chr "Will"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr ""
##   ..$ died       : chr "In 297 AC, at Haunted Forest"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr "A Clash of Kings"
##   ..$ povBooks   : chr "A Game of Thrones"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr "Bronson Webb"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1166"
##   ..$ id         : int 1166
##   ..$ name       : chr "Areo Hotah"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Norvoshi"
##   ..$ born       : chr "In 257 AC or before, at Norvos"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Captain of the Guard at Sunspear"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:2] "Season 5" "Season 6"
##   ..$ playedBy   : chr "DeObia Oparei"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1267"
##   ..$ id         : int 1267
##   ..$ name       : chr "Chett"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "At Hag's Mire"
##   ..$ died       : chr "In 299 AC, at Fist of the First Men"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr "A Storm of Swords"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1295"
##   ..$ id         : int 1295
##   ..$ name       : chr "Cressen"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 219 AC or 220 AC"
##   ..$ died       : chr "In 299 AC, at Dragonstone"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Maester"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:2] "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Clash of Kings"
##   ..$ tvSeries   : chr "Season 2"
##   ..$ playedBy   : chr "Oliver Ford"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/130"
##   ..$ id         : int 130
##   ..$ name       : chr "Arianne Martell"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Dornish"
##   ..$ born       : chr "In 276 AC, at Sunspear"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess of Dorne"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1303"
##   ..$ id         : int 1303
##   ..$ name       : chr "Daenerys Targaryen"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Valyrian"
##   ..$ born       : chr "In 284 AC, at Dragonstone"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:5] "Queen of the Andals and the Rhoynar and the First Men, Lord of the Seven Kingdoms" "Khaleesi of the Great Grass Sea" "Breaker of Shackles/Chains" "Queen of Meereen" ...
##   ..$ aliases    : chr [1:11] "Dany" "Daenerys Stormborn" "The Unburnt" "Mother of Dragons" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1346"
##   ..$ allegiances: chr "House Targaryen of King's Landing"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Emilia Clarke"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1319"
##   ..$ id         : int 1319
##   ..$ name       : chr "Davos Seaworth"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westeros"
##   ..$ born       : chr "In 260 AC or before, at King's Landing"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:4] "Ser" "Lord of the Rainwood" "Admiral of the Narrow Sea" "Hand of the King"
##   ..$ aliases    : chr [1:5] "Onion Knight" "Davos Shorthand" "Ser Onions" "Onion Lord" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1676"
##   ..$ allegiances: chr [1:2] "House Baratheon of Dragonstone" "House Seaworth of Cape Wrath"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Liam Cunningham"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/148"
##   ..$ id         : int 148
##   ..$ name       : chr "Arya Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 289 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess"
##   ..$ aliases    : chr [1:16] "Arya Horseface" "Arya Underfoot" "Arry" "Lumpyface" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : list()
##   ..$ povBooks   : chr [1:5] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" ...
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Maisie Williams"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/149"
##   ..$ id         : int 149
##   ..$ name       : chr "Arys Oakheart"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Reach"
##   ..$ born       : chr "At Old Oak"
##   ..$ died       : chr "In 300 AC, at the Greenblood"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Ser"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Oakheart of Old Oak"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/150"
##   ..$ id         : int 150
##   ..$ name       : chr "Asha Greyjoy"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 275 AC or 276 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Princess" "Captain of the Black Wind" "Conqueror of Deepwood Motte"
##   ..$ aliases    : chr [1:2] "Esgred" "The Kraken's Daughter"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1372"
##   ..$ allegiances: chr [1:2] "House Greyjoy of Pyke" "House Ironmaker"
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:3] "Season 2" "Season 3" "Season 4"
##   ..$ playedBy   : chr "Gemma Whelan"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/168"
##   ..$ id         : int 168
##   ..$ name       : chr "Barristan Selmy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westeros"
##   ..$ born       : chr "In 237 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Ser" "Hand of the Queen"
##   ..$ aliases    : chr [1:5] "Barristan the Bold" "Arstan Whitebeard" "Ser Grandfather" "Barristan the Old" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:2] "House Selmy of Harvest Hall" "House Targaryen of King's Landing"
##   ..$ books      : chr [1:5] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" ...
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:4] "Season 1" "Season 3" "Season 4" "Season 5"
##   ..$ playedBy   : chr "Ian McElhinney"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/2066"
##   ..$ id         : int 2066
##   ..$ name       : chr "Varamyr"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Free Folk"
##   ..$ born       : chr "At a village Beyond the Wall"
##   ..$ died       : chr "In 300 AC, at a village Beyond the Wall"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:3] "Varamyr Sixskins" "Haggon" "Lump"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr "A Storm of Swords"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/208"
##   ..$ id         : int 208
##   ..$ name       : chr "Brandon Stark"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 290 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Prince of Winterfell"
##   ..$ aliases    : chr [1:3] "Bran" "Bran the Broken" "The Winged Wolf"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Isaac Hempstead-Wright"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/216"
##   ..$ id         : int 216
##   ..$ name       : chr "Brienne of Tarth"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 280 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:3] "The Maid of Tarth" "Brienne the Beauty" "Brienne the Blue"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:3] "House Baratheon of Storm's End" "House Stark of Winterfell" "House Tarth of Evenfall Hall"
##   ..$ books      : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Gwendoline Christie"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/232"
##   ..$ id         : int 232
##   ..$ name       : chr "Catelyn Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Rivermen"
##   ..$ born       : chr "In 264 AC, at Riverrun"
##   ..$ died       : chr "In 299 AC, at the Twins"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Lady of Winterfell"
##   ..$ aliases    : chr [1:5] "Catelyn Tully" "Lady Stoneheart" "The Silent Sistet" "Mother Mercilesr" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/339"
##   ..$ allegiances: chr [1:2] "House Stark of Winterfell" "House Tully of Riverrun"
##   ..$ books      : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ povBooks   : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ tvSeries   : chr [1:3] "Season 1" "Season 2" "Season 3"
##   ..$ playedBy   : chr "Michelle Fairley"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/238"
##   ..$ id         : int 238
##   ..$ name       : chr "Cersei Lannister"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Westerman"
##   ..$ born       : chr "In 266 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:5] "Light of the West" "Queen Dowager" "Protector of the Realm" "Lady of Casterly Rock" ...
##   ..$ aliases    : list()
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/901"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Lena Headey"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/339"
##   ..$ id         : int 339
##   ..$ name       : chr "Eddard Stark"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 263 AC, at Winterfell"
##   ..$ died       : chr "In 299 AC, at Great Sept of Baelor in King's Landing"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr [1:5] "Lord of Winterfell" "Warden of the North" "Hand of the King" "Protector of the Realm" ...
##   ..$ aliases    : chr [1:3] "Ned" "The Ned" "The Quiet Wolf"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/232"
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr [1:5] "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" "A Dance with Dragons" ...
##   ..$ povBooks   : chr "A Game of Thrones"
##   ..$ tvSeries   : chr [1:2] "Season 1" "Season 6"
##   ..$ playedBy   : chr [1:3] "Sean Bean" "Sebastian Croft" "Robert Aramayo"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/529"
##   ..$ id         : int 529
##   ..$ name       : chr "Jaime Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westerlands"
##   ..$ born       : chr "In 266 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Ser" "Lord Commander of the Kingsguard" "Warden of the East (formerly)"
##   ..$ aliases    : chr [1:4] "The Kingslayer" "The Lion of Lannister" "The Young Lion" "Cripple"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr [1:3] "A Storm of Swords" "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Nikolaj Coster-Waldau"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/576"
##   ..$ id         : int 576
##   ..$ name       : chr "Jon Connington"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Stormlands"
##   ..$ born       : chr "In or between 263 AC and 265 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Lord of Griffin's Roost" "Hand of the King" "Hand of the True King"
##   ..$ aliases    : chr "Griffthe Mad King's Hand"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:2] "House Connington of Griffin's Roost" "House Targaryen of King's Landing"
##   ..$ books      : chr [1:3] "A Storm of Swords" "A Feast for Crows" "The World of Ice and Fire"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/583"
##   ..$ id         : int 583
##   ..$ name       : chr "Jon Snow"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 283 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Lord Commander of the Night's Watch"
##   ..$ aliases    : chr [1:8] "Lord Snow" "Ned Stark's Bastard" "The Snow of Winterfell" "The Crow-Come-Over" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Kit Harington"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/60"
##   ..$ id         : int 60
##   ..$ name       : chr "Aeron Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In or between 269 AC and 273 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Priest of the Drowned God" "Captain of the Golden Storm (formerly)"
##   ..$ aliases    : chr [1:2] "The Damphair" "Aeron Damphair"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr "Season 6"
##   ..$ playedBy   : chr "Michael Feast"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/605"
##   ..$ id         : int 605
##   ..$ name       : chr "Kevan Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 244 AC"
##   ..$ died       : chr "In 300 AC, at King's Landing"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr [1:4] "Ser" "Master of laws" "Lord Regent" "Protector of the Realm"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/327"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:4] "Season 1" "Season 2" "Season 5" "Season 6"
##   ..$ playedBy   : chr "Ian Gelder"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/743"
##   ..$ id         : int 743
##   ..$ name       : chr "Melisandre"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Asshai"
##   ..$ born       : chr "At Unknown"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:5] "The Red Priestess" "The Red Woman" "The King's Red Shadow" "Lady Red" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Carice van Houten"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/751"
##   ..$ id         : int 751
##   ..$ name       : chr "Merrett Frey"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Rivermen"
##   ..$ born       : chr "In 262 AC"
##   ..$ died       : chr "In 300 AC, at Near Oldstones"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr "Merrett Muttonhead"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/712"
##   ..$ allegiances: chr "House Frey of the Crossing"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Feast for Crows" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Storm of Swords"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/844"
##   ..$ id         : int 844
##   ..$ name       : chr "Quentyn Martell"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Dornish"
##   ..$ born       : chr "In 281 AC, at Sunspear, Dorne"
##   ..$ died       : chr "In 300 AC, at Meereen"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Prince"
##   ..$ aliases    : chr [1:4] "Frog" "Prince Frog" "The prince who came too late" "The Dragonrider"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/954"
##   ..$ id         : int 954
##   ..$ name       : chr "Samwell Tarly"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Andal"
##   ..$ born       : chr "In 283 AC, at Horn Hill"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:7] "Sam" "Ser Piggy" "Prince Pork-chop" "Lady Piggy" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Tarly of Horn Hill"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Dance with Dragons"
##   ..$ povBooks   : chr [1:2] "A Storm of Swords" "A Feast for Crows"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "John Bradley-West"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/957"
##   ..$ id         : int 957
##   ..$ name       : chr "Sansa Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 286 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess"
##   ..$ aliases    : chr [1:3] "Little bird" "Alayne Stone" "Jonquil"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ allegiances: chr [1:2] "House Baelish of Harrenhal" "House Stark of Winterfell"
##   ..$ books      : chr "A Dance with Dragons"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Sophie Turner"

View(got_chars)
## Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 1, 3, 4, 2, 6
# use the object viewer and it's code generation to get ...
got_chars[[9]][["name"]]
## [1] "Daenerys Targaryen"

# take more control of str()
str(got_chars[[9]])
## List of 18
##  $ url        : chr "https://www.anapioficeandfire.com/api/characters/1303"
##  $ id         : int 1303
##  $ name       : chr "Daenerys Targaryen"
##  $ gender     : chr "Female"
##  $ culture    : chr "Valyrian"
##  $ born       : chr "In 284 AC, at Dragonstone"
##  $ died       : chr ""
##  $ alive      : logi TRUE
##  $ titles     : chr [1:5] "Queen of the Andals and the Rhoynar and the First Men, Lord of the Seven Kingdoms" "Khaleesi of the Great Grass Sea" "Breaker of Shackles/Chains" "Queen of Meereen" ...
##  $ aliases    : chr [1:11] "Dany" "Daenerys Stormborn" "The Unburnt" "Mother of Dragons" ...
##  $ father     : chr ""
##  $ mother     : chr ""
##  $ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1346"
##  $ allegiances: chr "House Targaryen of King's Landing"
##  $ books      : chr "A Feast for Crows"
##  $ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##  $ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##  $ playedBy   : chr "Emilia Clarke"
str(got_chars, max.level = 1)
## List of 30
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
##  $ :List of 18
str(got_chars, list.len = 3)
## List of 30
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##   ..$ id         : int 1022
##   ..$ name       : chr "Theon Greyjoy"
##   .. [list output truncated]
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ id         : int 1052
##   ..$ name       : chr "Tyrion Lannister"
##   .. [list output truncated]
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1074"
##   ..$ id         : int 1074
##   ..$ name       : chr "Victarion Greyjoy"
##   .. [list output truncated]
##   [list output truncated]

## revisit slides to introduce map() and map_*() friends

## Shortcuts to get elements by name or position ----

## map(YOUR_LIST, YOUR_FUNCTION)
## map(YOUR_LIST, STRING)
## map(YOUR_LIST, INTEGER)

map(got_chars, "name")
## [[1]]
## [1] "Theon Greyjoy"
## 
## [[2]]
## [1] "Tyrion Lannister"
## 
## [[3]]
## [1] "Victarion Greyjoy"
## 
## [[4]]
## [1] "Will"
## 
## [[5]]
## [1] "Areo Hotah"
## 
## [[6]]
## [1] "Chett"
## 
## [[7]]
## [1] "Cressen"
## 
## [[8]]
## [1] "Arianne Martell"
## 
## [[9]]
## [1] "Daenerys Targaryen"
## 
## [[10]]
## [1] "Davos Seaworth"
## 
## [[11]]
## [1] "Arya Stark"
## 
## [[12]]
## [1] "Arys Oakheart"
## 
## [[13]]
## [1] "Asha Greyjoy"
## 
## [[14]]
## [1] "Barristan Selmy"
## 
## [[15]]
## [1] "Varamyr"
## 
## [[16]]
## [1] "Brandon Stark"
## 
## [[17]]
## [1] "Brienne of Tarth"
## 
## [[18]]
## [1] "Catelyn Stark"
## 
## [[19]]
## [1] "Cersei Lannister"
## 
## [[20]]
## [1] "Eddard Stark"
## 
## [[21]]
## [1] "Jaime Lannister"
## 
## [[22]]
## [1] "Jon Connington"
## 
## [[23]]
## [1] "Jon Snow"
## 
## [[24]]
## [1] "Aeron Greyjoy"
## 
## [[25]]
## [1] "Kevan Lannister"
## 
## [[26]]
## [1] "Melisandre"
## 
## [[27]]
## [1] "Merrett Frey"
## 
## [[28]]
## [1] "Quentyn Martell"
## 
## [[29]]
## [1] "Samwell Tarly"
## 
## [[30]]
## [1] "Sansa Stark"
map(got_chars, 3)
## [[1]]
## [1] "Theon Greyjoy"
## 
## [[2]]
## [1] "Tyrion Lannister"
## 
## [[3]]
## [1] "Victarion Greyjoy"
## 
## [[4]]
## [1] "Will"
## 
## [[5]]
## [1] "Areo Hotah"
## 
## [[6]]
## [1] "Chett"
## 
## [[7]]
## [1] "Cressen"
## 
## [[8]]
## [1] "Arianne Martell"
## 
## [[9]]
## [1] "Daenerys Targaryen"
## 
## [[10]]
## [1] "Davos Seaworth"
## 
## [[11]]
## [1] "Arya Stark"
## 
## [[12]]
## [1] "Arys Oakheart"
## 
## [[13]]
## [1] "Asha Greyjoy"
## 
## [[14]]
## [1] "Barristan Selmy"
## 
## [[15]]
## [1] "Varamyr"
## 
## [[16]]
## [1] "Brandon Stark"
## 
## [[17]]
## [1] "Brienne of Tarth"
## 
## [[18]]
## [1] "Catelyn Stark"
## 
## [[19]]
## [1] "Cersei Lannister"
## 
## [[20]]
## [1] "Eddard Stark"
## 
## [[21]]
## [1] "Jaime Lannister"
## 
## [[22]]
## [1] "Jon Connington"
## 
## [[23]]
## [1] "Jon Snow"
## 
## [[24]]
## [1] "Aeron Greyjoy"
## 
## [[25]]
## [1] "Kevan Lannister"
## 
## [[26]]
## [1] "Melisandre"
## 
## [[27]]
## [1] "Merrett Frey"
## 
## [[28]]
## [1] "Quentyn Martell"
## 
## [[29]]
## [1] "Samwell Tarly"
## 
## [[30]]
## [1] "Sansa Stark"

## this is how we would do in base (vs. purrr)
lapply(got_chars, function(x) x[["name"]])
## [[1]]
## [1] "Theon Greyjoy"
## 
## [[2]]
## [1] "Tyrion Lannister"
## 
## [[3]]
## [1] "Victarion Greyjoy"
## 
## [[4]]
## [1] "Will"
## 
## [[5]]
## [1] "Areo Hotah"
## 
## [[6]]
## [1] "Chett"
## 
## [[7]]
## [1] "Cressen"
## 
## [[8]]
## [1] "Arianne Martell"
## 
## [[9]]
## [1] "Daenerys Targaryen"
## 
## [[10]]
## [1] "Davos Seaworth"
## 
## [[11]]
## [1] "Arya Stark"
## 
## [[12]]
## [1] "Arys Oakheart"
## 
## [[13]]
## [1] "Asha Greyjoy"
## 
## [[14]]
## [1] "Barristan Selmy"
## 
## [[15]]
## [1] "Varamyr"
## 
## [[16]]
## [1] "Brandon Stark"
## 
## [[17]]
## [1] "Brienne of Tarth"
## 
## [[18]]
## [1] "Catelyn Stark"
## 
## [[19]]
## [1] "Cersei Lannister"
## 
## [[20]]
## [1] "Eddard Stark"
## 
## [[21]]
## [1] "Jaime Lannister"
## 
## [[22]]
## [1] "Jon Connington"
## 
## [[23]]
## [1] "Jon Snow"
## 
## [[24]]
## [1] "Aeron Greyjoy"
## 
## [[25]]
## [1] "Kevan Lannister"
## 
## [[26]]
## [1] "Melisandre"
## 
## [[27]]
## [1] "Merrett Frey"
## 
## [[28]]
## [1] "Quentyn Martell"
## 
## [[29]]
## [1] "Samwell Tarly"
## 
## [[30]]
## [1] "Sansa Stark"
lapply(got_chars, function(x) x[[3]])
## [[1]]
## [1] "Theon Greyjoy"
## 
## [[2]]
## [1] "Tyrion Lannister"
## 
## [[3]]
## [1] "Victarion Greyjoy"
## 
## [[4]]
## [1] "Will"
## 
## [[5]]
## [1] "Areo Hotah"
## 
## [[6]]
## [1] "Chett"
## 
## [[7]]
## [1] "Cressen"
## 
## [[8]]
## [1] "Arianne Martell"
## 
## [[9]]
## [1] "Daenerys Targaryen"
## 
## [[10]]
## [1] "Davos Seaworth"
## 
## [[11]]
## [1] "Arya Stark"
## 
## [[12]]
## [1] "Arys Oakheart"
## 
## [[13]]
## [1] "Asha Greyjoy"
## 
## [[14]]
## [1] "Barristan Selmy"
## 
## [[15]]
## [1] "Varamyr"
## 
## [[16]]
## [1] "Brandon Stark"
## 
## [[17]]
## [1] "Brienne of Tarth"
## 
## [[18]]
## [1] "Catelyn Stark"
## 
## [[19]]
## [1] "Cersei Lannister"
## 
## [[20]]
## [1] "Eddard Stark"
## 
## [[21]]
## [1] "Jaime Lannister"
## 
## [[22]]
## [1] "Jon Connington"
## 
## [[23]]
## [1] "Jon Snow"
## 
## [[24]]
## [1] "Aeron Greyjoy"
## 
## [[25]]
## [1] "Kevan Lannister"
## 
## [[26]]
## [1] "Melisandre"
## 
## [[27]]
## [1] "Merrett Frey"
## 
## [[28]]
## [1] "Quentyn Martell"
## 
## [[29]]
## [1] "Samwell Tarly"
## 
## [[30]]
## [1] "Sansa Stark"

## Exercises

## Use names() to get the names of the list elements associated with a single
## character.
## What's the position of the "playedBy" element?
## Use string and position shortcuts to extract playedBy for all characters.

## Type-specific map w/ string or position shortcuts ----
map_chr(got_chars, "name")
##  [1] "Theon Greyjoy"      "Tyrion Lannister"   "Victarion Greyjoy" 
##  [4] "Will"               "Areo Hotah"         "Chett"             
##  [7] "Cressen"            "Arianne Martell"    "Daenerys Targaryen"
## [10] "Davos Seaworth"     "Arya Stark"         "Arys Oakheart"     
## [13] "Asha Greyjoy"       "Barristan Selmy"    "Varamyr"           
## [16] "Brandon Stark"      "Brienne of Tarth"   "Catelyn Stark"     
## [19] "Cersei Lannister"   "Eddard Stark"       "Jaime Lannister"   
## [22] "Jon Connington"     "Jon Snow"           "Aeron Greyjoy"     
## [25] "Kevan Lannister"    "Melisandre"         "Merrett Frey"      
## [28] "Quentyn Martell"    "Samwell Tarly"      "Sansa Stark"
## there's also map_int(), map_lgl(), map_dbl()

## Exercises

## Get an integer vector of character "id"s, using the string shortcut.

## Get the same integer vector again, using the integer position shortcut.

## Get the same vector again, using map() and then flatten_int()

## Inspect the info for one specific character (just pick one).
## Which element is logical?
## What's its name?
## What's its position?
## Use map_lgl() to get a logical vector of these across all characters.

## Extract multiple things ----
got_chars[[3]][c("name", "culture", "gender", "born")]
## $name
## [1] "Victarion Greyjoy"
## 
## $culture
## [1] "Ironborn"
## 
## $gender
## [1] "Male"
## 
## $born
## [1] "In 268 AC or before, at Pyke"

x <- map(got_chars, `[`, c("name", "culture", "gender", "born"))
x
## [[1]]
## [[1]]$name
## [1] "Theon Greyjoy"
## 
## [[1]]$culture
## [1] "Ironborn"
## 
## [[1]]$gender
## [1] "Male"
## 
## [[1]]$born
## [1] "In 278 AC or 279 AC, at Pyke"
## 
## 
## [[2]]
## [[2]]$name
## [1] "Tyrion Lannister"
## 
## [[2]]$culture
## [1] ""
## 
## [[2]]$gender
## [1] "Male"
## 
## [[2]]$born
## [1] "In 273 AC, at Casterly Rock"
## 
## 
## [[3]]
## [[3]]$name
## [1] "Victarion Greyjoy"
## 
## [[3]]$culture
## [1] "Ironborn"
## 
## [[3]]$gender
## [1] "Male"
## 
## [[3]]$born
## [1] "In 268 AC or before, at Pyke"
## 
## 
## [[4]]
## [[4]]$name
## [1] "Will"
## 
## [[4]]$culture
## [1] ""
## 
## [[4]]$gender
## [1] "Male"
## 
## [[4]]$born
## [1] ""
## 
## 
## [[5]]
## [[5]]$name
## [1] "Areo Hotah"
## 
## [[5]]$culture
## [1] "Norvoshi"
## 
## [[5]]$gender
## [1] "Male"
## 
## [[5]]$born
## [1] "In 257 AC or before, at Norvos"
## 
## 
## [[6]]
## [[6]]$name
## [1] "Chett"
## 
## [[6]]$culture
## [1] ""
## 
## [[6]]$gender
## [1] "Male"
## 
## [[6]]$born
## [1] "At Hag's Mire"
## 
## 
## [[7]]
## [[7]]$name
## [1] "Cressen"
## 
## [[7]]$culture
## [1] ""
## 
## [[7]]$gender
## [1] "Male"
## 
## [[7]]$born
## [1] "In 219 AC or 220 AC"
## 
## 
## [[8]]
## [[8]]$name
## [1] "Arianne Martell"
## 
## [[8]]$culture
## [1] "Dornish"
## 
## [[8]]$gender
## [1] "Female"
## 
## [[8]]$born
## [1] "In 276 AC, at Sunspear"
## 
## 
## [[9]]
## [[9]]$name
## [1] "Daenerys Targaryen"
## 
## [[9]]$culture
## [1] "Valyrian"
## 
## [[9]]$gender
## [1] "Female"
## 
## [[9]]$born
## [1] "In 284 AC, at Dragonstone"
## 
## 
## [[10]]
## [[10]]$name
## [1] "Davos Seaworth"
## 
## [[10]]$culture
## [1] "Westeros"
## 
## [[10]]$gender
## [1] "Male"
## 
## [[10]]$born
## [1] "In 260 AC or before, at King's Landing"
## 
## 
## [[11]]
## [[11]]$name
## [1] "Arya Stark"
## 
## [[11]]$culture
## [1] "Northmen"
## 
## [[11]]$gender
## [1] "Female"
## 
## [[11]]$born
## [1] "In 289 AC, at Winterfell"
## 
## 
## [[12]]
## [[12]]$name
## [1] "Arys Oakheart"
## 
## [[12]]$culture
## [1] "Reach"
## 
## [[12]]$gender
## [1] "Male"
## 
## [[12]]$born
## [1] "At Old Oak"
## 
## 
## [[13]]
## [[13]]$name
## [1] "Asha Greyjoy"
## 
## [[13]]$culture
## [1] "Ironborn"
## 
## [[13]]$gender
## [1] "Female"
## 
## [[13]]$born
## [1] "In 275 AC or 276 AC, at Pyke"
## 
## 
## [[14]]
## [[14]]$name
## [1] "Barristan Selmy"
## 
## [[14]]$culture
## [1] "Westeros"
## 
## [[14]]$gender
## [1] "Male"
## 
## [[14]]$born
## [1] "In 237 AC"
## 
## 
## [[15]]
## [[15]]$name
## [1] "Varamyr"
## 
## [[15]]$culture
## [1] "Free Folk"
## 
## [[15]]$gender
## [1] "Male"
## 
## [[15]]$born
## [1] "At a village Beyond the Wall"
## 
## 
## [[16]]
## [[16]]$name
## [1] "Brandon Stark"
## 
## [[16]]$culture
## [1] "Northmen"
## 
## [[16]]$gender
## [1] "Male"
## 
## [[16]]$born
## [1] "In 290 AC, at Winterfell"
## 
## 
## [[17]]
## [[17]]$name
## [1] "Brienne of Tarth"
## 
## [[17]]$culture
## [1] ""
## 
## [[17]]$gender
## [1] "Female"
## 
## [[17]]$born
## [1] "In 280 AC"
## 
## 
## [[18]]
## [[18]]$name
## [1] "Catelyn Stark"
## 
## [[18]]$culture
## [1] "Rivermen"
## 
## [[18]]$gender
## [1] "Female"
## 
## [[18]]$born
## [1] "In 264 AC, at Riverrun"
## 
## 
## [[19]]
## [[19]]$name
## [1] "Cersei Lannister"
## 
## [[19]]$culture
## [1] "Westerman"
## 
## [[19]]$gender
## [1] "Female"
## 
## [[19]]$born
## [1] "In 266 AC, at Casterly Rock"
## 
## 
## [[20]]
## [[20]]$name
## [1] "Eddard Stark"
## 
## [[20]]$culture
## [1] "Northmen"
## 
## [[20]]$gender
## [1] "Male"
## 
## [[20]]$born
## [1] "In 263 AC, at Winterfell"
## 
## 
## [[21]]
## [[21]]$name
## [1] "Jaime Lannister"
## 
## [[21]]$culture
## [1] "Westerlands"
## 
## [[21]]$gender
## [1] "Male"
## 
## [[21]]$born
## [1] "In 266 AC, at Casterly Rock"
## 
## 
## [[22]]
## [[22]]$name
## [1] "Jon Connington"
## 
## [[22]]$culture
## [1] "Stormlands"
## 
## [[22]]$gender
## [1] "Male"
## 
## [[22]]$born
## [1] "In or between 263 AC and 265 AC"
## 
## 
## [[23]]
## [[23]]$name
## [1] "Jon Snow"
## 
## [[23]]$culture
## [1] "Northmen"
## 
## [[23]]$gender
## [1] "Male"
## 
## [[23]]$born
## [1] "In 283 AC"
## 
## 
## [[24]]
## [[24]]$name
## [1] "Aeron Greyjoy"
## 
## [[24]]$culture
## [1] "Ironborn"
## 
## [[24]]$gender
## [1] "Male"
## 
## [[24]]$born
## [1] "In or between 269 AC and 273 AC, at Pyke"
## 
## 
## [[25]]
## [[25]]$name
## [1] "Kevan Lannister"
## 
## [[25]]$culture
## [1] ""
## 
## [[25]]$gender
## [1] "Male"
## 
## [[25]]$born
## [1] "In 244 AC"
## 
## 
## [[26]]
## [[26]]$name
## [1] "Melisandre"
## 
## [[26]]$culture
## [1] "Asshai"
## 
## [[26]]$gender
## [1] "Female"
## 
## [[26]]$born
## [1] "At Unknown"
## 
## 
## [[27]]
## [[27]]$name
## [1] "Merrett Frey"
## 
## [[27]]$culture
## [1] "Rivermen"
## 
## [[27]]$gender
## [1] "Male"
## 
## [[27]]$born
## [1] "In 262 AC"
## 
## 
## [[28]]
## [[28]]$name
## [1] "Quentyn Martell"
## 
## [[28]]$culture
## [1] "Dornish"
## 
## [[28]]$gender
## [1] "Male"
## 
## [[28]]$born
## [1] "In 281 AC, at Sunspear, Dorne"
## 
## 
## [[29]]
## [[29]]$name
## [1] "Samwell Tarly"
## 
## [[29]]$culture
## [1] "Andal"
## 
## [[29]]$gender
## [1] "Male"
## 
## [[29]]$born
## [1] "In 283 AC, at Horn Hill"
## 
## 
## [[30]]
## [[30]]$name
## [1] "Sansa Stark"
## 
## [[30]]$culture
## [1] "Northmen"
## 
## [[30]]$gender
## [1] "Female"
## 
## [[30]]$born
## [1] "In 286 AC, at Winterfell"
View(x)

## Inspect the info for one specific character (just pick one).
## What's the integer position of these elements:
## "name", "gender", "culture", "born", and "died".
## Map `[` over characters by INTEGER POSITIONS instead of name.

## Extract multiple things into data frame rows ----
map_dfr(got_chars, `[`, c("name", "culture", "gender", "id", "born", "alive"))
## # A tibble: 30 x 6
##    name               culture  gender    id born                     alive
##    <chr>              <chr>    <chr>  <int> <chr>                    <lgl>
##  1 Theon Greyjoy      Ironborn Male    1022 In 278 AC or 279 AC, at… T    
##  2 Tyrion Lannister   ""       Male    1052 In 273 AC, at Casterly … T    
##  3 Victarion Greyjoy  Ironborn Male    1074 In 268 AC or before, at… T    
##  4 Will               ""       Male    1109 ""                       F    
##  5 Areo Hotah         Norvoshi Male    1166 In 257 AC or before, at… T    
##  6 Chett              ""       Male    1267 At Hag's Mire            F    
##  7 Cressen            ""       Male    1295 In 219 AC or 220 AC      F    
##  8 Arianne Martell    Dornish  Female   130 In 276 AC, at Sunspear   T    
##  9 Daenerys Targaryen Valyrian Female  1303 In 284 AC, at Dragonsto… T    
## 10 Davos Seaworth     Westeros Male    1319 In 260 AC or before, at… T    
## # ... with 20 more rows

## Try to do similar with "name" and "titles".
## What happens? Why? Can you think of another way to get that job done?

## go back to slides to remind ourselves .f can be more general

## Beyond the string and integer shortcut ----

## modelling a development workflow ----
library(glue)
## 
## Attaching package: 'glue'
## The following object is masked from 'package:dplyr':
## 
##     collapse

## practice with a fake, simple example you control
glue_data(
  list(name = "Jenny", born = "in Atlanta"),
  "{name} was born {born}."
)
## Jenny was born in Atlanta.

## practice with a real example in your data
glue_data(got_chars[[2]], "{name} was born {born}.")
## Tyrion Lannister was born In 273 AC, at Casterly Rock.

## practice with a real, different example in your data
glue_data(got_chars[[9]], "{name} was born {born}.")
## Daenerys Targaryen was born In 284 AC, at Dragonstone.

## drop this code into map()
map(got_chars, ~ glue_data(.x, "{name} was born {born}."))
## [[1]]
## Theon Greyjoy was born In 278 AC or 279 AC, at Pyke.
## 
## [[2]]
## Tyrion Lannister was born In 273 AC, at Casterly Rock.
## 
## [[3]]
## Victarion Greyjoy was born In 268 AC or before, at Pyke.
## 
## [[4]]
## Will was born .
## 
## [[5]]
## Areo Hotah was born In 257 AC or before, at Norvos.
## 
## [[6]]
## Chett was born At Hag's Mire.
## 
## [[7]]
## Cressen was born In 219 AC or 220 AC.
## 
## [[8]]
## Arianne Martell was born In 276 AC, at Sunspear.
## 
## [[9]]
## Daenerys Targaryen was born In 284 AC, at Dragonstone.
## 
## [[10]]
## Davos Seaworth was born In 260 AC or before, at King's Landing.
## 
## [[11]]
## Arya Stark was born In 289 AC, at Winterfell.
## 
## [[12]]
## Arys Oakheart was born At Old Oak.
## 
## [[13]]
## Asha Greyjoy was born In 275 AC or 276 AC, at Pyke.
## 
## [[14]]
## Barristan Selmy was born In 237 AC.
## 
## [[15]]
## Varamyr was born At a village Beyond the Wall.
## 
## [[16]]
## Brandon Stark was born In 290 AC, at Winterfell.
## 
## [[17]]
## Brienne of Tarth was born In 280 AC.
## 
## [[18]]
## Catelyn Stark was born In 264 AC, at Riverrun.
## 
## [[19]]
## Cersei Lannister was born In 266 AC, at Casterly Rock.
## 
## [[20]]
## Eddard Stark was born In 263 AC, at Winterfell.
## 
## [[21]]
## Jaime Lannister was born In 266 AC, at Casterly Rock.
## 
## [[22]]
## Jon Connington was born In or between 263 AC and 265 AC.
## 
## [[23]]
## Jon Snow was born In 283 AC.
## 
## [[24]]
## Aeron Greyjoy was born In or between 269 AC and 273 AC, at Pyke.
## 
## [[25]]
## Kevan Lannister was born In 244 AC.
## 
## [[26]]
## Melisandre was born At Unknown.
## 
## [[27]]
## Merrett Frey was born In 262 AC.
## 
## [[28]]
## Quentyn Martell was born In 281 AC, at Sunspear, Dorne.
## 
## [[29]]
## Samwell Tarly was born In 283 AC, at Horn Hill.
## 
## [[30]]
## Sansa Stark was born In 286 AC, at Winterfell.

## use the simplifying form map_chr()
map_chr(got_chars, ~ glue_data(.x, "{name} was born {born}."))
##  [1] "Theon Greyjoy was born In 278 AC or 279 AC, at Pyke."            
##  [2] "Tyrion Lannister was born In 273 AC, at Casterly Rock."          
##  [3] "Victarion Greyjoy was born In 268 AC or before, at Pyke."        
##  [4] "Will was born ."                                                 
##  [5] "Areo Hotah was born In 257 AC or before, at Norvos."             
##  [6] "Chett was born At Hag's Mire."                                   
##  [7] "Cressen was born In 219 AC or 220 AC."                           
##  [8] "Arianne Martell was born In 276 AC, at Sunspear."                
##  [9] "Daenerys Targaryen was born In 284 AC, at Dragonstone."          
## [10] "Davos Seaworth was born In 260 AC or before, at King's Landing." 
## [11] "Arya Stark was born In 289 AC, at Winterfell."                   
## [12] "Arys Oakheart was born At Old Oak."                              
## [13] "Asha Greyjoy was born In 275 AC or 276 AC, at Pyke."             
## [14] "Barristan Selmy was born In 237 AC."                             
## [15] "Varamyr was born At a village Beyond the Wall."                  
## [16] "Brandon Stark was born In 290 AC, at Winterfell."                
## [17] "Brienne of Tarth was born In 280 AC."                            
## [18] "Catelyn Stark was born In 264 AC, at Riverrun."                  
## [19] "Cersei Lannister was born In 266 AC, at Casterly Rock."          
## [20] "Eddard Stark was born In 263 AC, at Winterfell."                 
## [21] "Jaime Lannister was born In 266 AC, at Casterly Rock."           
## [22] "Jon Connington was born In or between 263 AC and 265 AC."        
## [23] "Jon Snow was born In 283 AC."                                    
## [24] "Aeron Greyjoy was born In or between 269 AC and 273 AC, at Pyke."
## [25] "Kevan Lannister was born In 244 AC."                             
## [26] "Melisandre was born At Unknown."                                 
## [27] "Merrett Frey was born In 262 AC."                                
## [28] "Quentyn Martell was born In 281 AC, at Sunspear, Dorne."         
## [29] "Samwell Tarly was born In 283 AC, at Horn Hill."                 
## [30] "Sansa Stark was born In 286 AC, at Winterfell."

## end workflow modelling

## All the ways to specify .f ----
aliases <- set_names(
  map(got_chars, "aliases"),
  map_chr(got_chars, "name")
)
(aliases <- aliases[c(1, 13, 17)])
## $`Theon Greyjoy`
## [1] "Prince of Fools" "Theon Turncloak" "Reek"            "Theon Kinslayer"
## 
## $`Asha Greyjoy`
## [1] "Esgred"                "The Kraken's Daughter"
## 
## $`Brienne of Tarth`
## [1] "The Maid of Tarth"  "Brienne the Beauty" "Brienne the Blue"

## map(YOUR_LIST, YOUR_FUNCTION)

## .f = a pre-existing function (custom, in this case)
my_fun <- function(x) paste(x, collapse = " | ")
map(aliases, my_fun)
## $`Theon Greyjoy`
## [1] "Prince of Fools | Theon Turncloak | Reek | Theon Kinslayer"
## 
## $`Asha Greyjoy`
## [1] "Esgred | The Kraken's Daughter"
## 
## $`Brienne of Tarth`
## [1] "The Maid of Tarth | Brienne the Beauty | Brienne the Blue"

## .f = anonymous function
map(aliases, function(x) paste(x, collapse = " | "))
## $`Theon Greyjoy`
## [1] "Prince of Fools | Theon Turncloak | Reek | Theon Kinslayer"
## 
## $`Asha Greyjoy`
## [1] "Esgred | The Kraken's Daughter"
## 
## $`Brienne of Tarth`
## [1] "The Maid of Tarth | Brienne the Beauty | Brienne the Blue"

## .f = pre-existing function, with extra args passed through `...`
map(aliases, paste, collapse = " | ")
## $`Theon Greyjoy`
## [1] "Prince of Fools | Theon Turncloak | Reek | Theon Kinslayer"
## 
## $`Asha Greyjoy`
## [1] "Esgred | The Kraken's Daughter"
## 
## $`Brienne of Tarth`
## [1] "The Maid of Tarth | Brienne the Beauty | Brienne the Blue"

## .f = anonymous function, via a ~ formula
map(aliases, ~ paste(.x, collapse = " | "))
## $`Theon Greyjoy`
## [1] "Prince of Fools | Theon Turncloak | Reek | Theon Kinslayer"
## 
## $`Asha Greyjoy`
## [1] "Esgred | The Kraken's Daughter"
## 
## $`Brienne of Tarth`
## [1] "The Maid of Tarth | Brienne the Beauty | Brienne the Blue"

## Exercises

## Each character can be allied with one of the houses (or with several or with
## zero). These allegiances are held as a vector in each character’s component.

## Create a list of allegiances that holds the characters’ house affiliations.
allegiances <- map(got_chars, "allegiances")
## Create a character vector nms that holds the characters’ names.
nms <- map_chr(got_chars, "name")
## Apply the names in nms to the allegiances list via set_names.
names(allegiances) <- nms
##
## how many allegiances does each character have?
map_int(allegiances, length)
##      Theon Greyjoy   Tyrion Lannister  Victarion Greyjoy 
##                  1                  1                  1 
##               Will         Areo Hotah              Chett 
##                  0                  1                  0 
##            Cressen    Arianne Martell Daenerys Targaryen 
##                  0                  1                  1 
##     Davos Seaworth         Arya Stark      Arys Oakheart 
##                  2                  1                  1 
##       Asha Greyjoy    Barristan Selmy            Varamyr 
##                  2                  2                  0 
##      Brandon Stark   Brienne of Tarth      Catelyn Stark 
##                  1                  3                  2 
##   Cersei Lannister       Eddard Stark    Jaime Lannister 
##                  1                  1                  1 
##     Jon Connington           Jon Snow      Aeron Greyjoy 
##                  2                  1                  1 
##    Kevan Lannister         Melisandre       Merrett Frey 
##                  1                  0                  1 
##    Quentyn Martell      Samwell Tarly        Sansa Stark 
##                  1                  1                  2
##
## Form a logical vector that reports if this character is allied with House Targaryen.
map_lgl(allegiances, ~ any(grepl("Targaryen", .x)))
##      Theon Greyjoy   Tyrion Lannister  Victarion Greyjoy 
##              FALSE              FALSE              FALSE 
##               Will         Areo Hotah              Chett 
##              FALSE              FALSE              FALSE 
##            Cressen    Arianne Martell Daenerys Targaryen 
##              FALSE              FALSE               TRUE 
##     Davos Seaworth         Arya Stark      Arys Oakheart 
##              FALSE              FALSE              FALSE 
##       Asha Greyjoy    Barristan Selmy            Varamyr 
##              FALSE               TRUE              FALSE 
##      Brandon Stark   Brienne of Tarth      Catelyn Stark 
##              FALSE              FALSE              FALSE 
##   Cersei Lannister       Eddard Stark    Jaime Lannister 
##              FALSE              FALSE              FALSE 
##     Jon Connington           Jon Snow      Aeron Greyjoy 
##               TRUE              FALSE              FALSE 
##    Kevan Lannister         Melisandre       Merrett Frey 
##              FALSE              FALSE              FALSE 
##    Quentyn Martell      Samwell Tarly        Sansa Stark 
##              FALSE              FALSE              FALSE

## go back to slides for some visual inspiration about map2() and pmap()
## (no code examples here, but they do come up in real life)
## also intro to putting lists in a data frame

## list-columns = lists in a data frame ----
gt <- tibble(
  name = map_chr(got_chars, "name"),
  houses = map(got_chars, "allegiances")
)
View(gt)

## KEY IDEA: use map() inside tibble(), mutate(), filter(), etc.

## sidebar: revel in enframe <--> deframe
## named list <--> two column tibble
gt
## # A tibble: 30 x 2
##    name               houses   
##    <chr>              <list>   
##  1 Theon Greyjoy      <chr [1]>
##  2 Tyrion Lannister   <chr [1]>
##  3 Victarion Greyjoy  <chr [1]>
##  4 Will               <NULL>   
##  5 Areo Hotah         <chr [1]>
##  6 Chett              <NULL>   
##  7 Cressen            <NULL>   
##  8 Arianne Martell    <chr [1]>
##  9 Daenerys Targaryen <chr [1]>
## 10 Davos Seaworth     <chr [2]>
## # ... with 20 more rows
deframe(gt)
## $`Theon Greyjoy`
## [1] "House Greyjoy of Pyke"
## 
## $`Tyrion Lannister`
## [1] "House Lannister of Casterly Rock"
## 
## $`Victarion Greyjoy`
## [1] "House Greyjoy of Pyke"
## 
## $Will
## NULL
## 
## $`Areo Hotah`
## [1] "House Nymeros Martell of Sunspear"
## 
## $Chett
## NULL
## 
## $Cressen
## NULL
## 
## $`Arianne Martell`
## [1] "House Nymeros Martell of Sunspear"
## 
## $`Daenerys Targaryen`
## [1] "House Targaryen of King's Landing"
## 
## $`Davos Seaworth`
## [1] "House Baratheon of Dragonstone" "House Seaworth of Cape Wrath"  
## 
## $`Arya Stark`
## [1] "House Stark of Winterfell"
## 
## $`Arys Oakheart`
## [1] "House Oakheart of Old Oak"
## 
## $`Asha Greyjoy`
## [1] "House Greyjoy of Pyke" "House Ironmaker"      
## 
## $`Barristan Selmy`
## [1] "House Selmy of Harvest Hall"       "House Targaryen of King's Landing"
## 
## $Varamyr
## NULL
## 
## $`Brandon Stark`
## [1] "House Stark of Winterfell"
## 
## $`Brienne of Tarth`
## [1] "House Baratheon of Storm's End" "House Stark of Winterfell"     
## [3] "House Tarth of Evenfall Hall"  
## 
## $`Catelyn Stark`
## [1] "House Stark of Winterfell" "House Tully of Riverrun"  
## 
## $`Cersei Lannister`
## [1] "House Lannister of Casterly Rock"
## 
## $`Eddard Stark`
## [1] "House Stark of Winterfell"
## 
## $`Jaime Lannister`
## [1] "House Lannister of Casterly Rock"
## 
## $`Jon Connington`
## [1] "House Connington of Griffin's Roost"
## [2] "House Targaryen of King's Landing"  
## 
## $`Jon Snow`
## [1] "House Stark of Winterfell"
## 
## $`Aeron Greyjoy`
## [1] "House Greyjoy of Pyke"
## 
## $`Kevan Lannister`
## [1] "House Lannister of Casterly Rock"
## 
## $Melisandre
## NULL
## 
## $`Merrett Frey`
## [1] "House Frey of the Crossing"
## 
## $`Quentyn Martell`
## [1] "House Nymeros Martell of Sunspear"
## 
## $`Samwell Tarly`
## [1] "House Tarly of Horn Hill"
## 
## $`Sansa Stark`
## [1] "House Baelish of Harrenhal" "House Stark of Winterfell"
enframe(deframe(gt))
## # A tibble: 30 x 2
##    name               value    
##    <chr>              <list>   
##  1 Theon Greyjoy      <chr [1]>
##  2 Tyrion Lannister   <chr [1]>
##  3 Victarion Greyjoy  <chr [1]>
##  4 Will               <NULL>   
##  5 Areo Hotah         <chr [1]>
##  6 Chett              <NULL>   
##  7 Cressen            <NULL>   
##  8 Arianne Martell    <chr [1]>
##  9 Daenerys Targaryen <chr [1]>
## 10 Davos Seaworth     <chr [2]>
## # ... with 20 more rows

gt %>%
  mutate(n_houses = map_int(houses,length)) %>%
  filter(n_houses > 1) %>%
  unnest()
## # A tibble: 15 x 3
##    name             n_houses houses                             
##    <chr>               <int> <chr>                              
##  1 Davos Seaworth          2 House Baratheon of Dragonstone     
##  2 Davos Seaworth          2 House Seaworth of Cape Wrath       
##  3 Asha Greyjoy            2 House Greyjoy of Pyke              
##  4 Asha Greyjoy            2 House Ironmaker                    
##  5 Barristan Selmy         2 House Selmy of Harvest Hall        
##  6 Barristan Selmy         2 House Targaryen of King's Landing  
##  7 Brienne of Tarth        3 House Baratheon of Storm's End     
##  8 Brienne of Tarth        3 House Stark of Winterfell          
##  9 Brienne of Tarth        3 House Tarth of Evenfall Hall       
## 10 Catelyn Stark           2 House Stark of Winterfell          
## 11 Catelyn Stark           2 House Tully of Riverrun            
## 12 Jon Connington          2 House Connington of Griffin's Roost
## 13 Jon Connington          2 House Targaryen of King's Landing  
## 14 Sansa Stark             2 House Baelish of Harrenhal         
## 15 Sansa Stark             2 House Stark of Winterfell

## Exercises

## Make a tibble that has 1 variable, stuff, that is got_chars:
df <- tibble(
  stuff = got_chars
)

## Create 3 new, regular variables in this data frame that are
## simple atomic vectors by extracting and/or computing on the
## stuff in the list. Ideas:
##   * name is a great variable to have!
##   * Other good simple character variables: culture, playedBy
##   * id is a simple integer candidate, but boring/meaningless
##   * A character list-column could be made from titles, aliases,
##     allegiances, povBooks.
##   * An integer vector can be made by taking length of ^^ above.
##   * Get rid of the list-column(s) and admire your new data frame
```
