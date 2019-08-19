## ------------------------------------------------------------------------
strings <- c(
    "Give me an ice cream",
    "Get yourself an ice cream",
    "We are all out of ice creams",
    "I scream, you scream, everybody loves ice cream.",
    "one ice cream,
    two ice creams,
    three ice creams",
    "I want an ice cream. Do you want an ice cream?"
)
str_count(strings)


## ------------------------------------------------------------------------
str_count(strings, boundary("character"))


## ------------------------------------------------------------------------
str_count(strings, boundary("word"))


## ------------------------------------------------------------------------
str_count(strings, boundary("line_break"))
str_count(strings, boundary("sentence"))


## ------------------------------------------------------------------------
str_count(strings, "ice cream")
str_count(strings, "cream") # gets the screams as well


## ------------------------------------------------------------------------
str_count(strings, ".")


## ------------------------------------------------------------------------
str_count(strings, fixed("."))


## ------------------------------------------------------------------------
str_count(strings, "[:punct:]")


## ------------------------------------------------------------------------
str_count(strings, "ice creams?$")


## ------------------------------------------------------------------------
str_count(strings, "ice creams?[:punct:]?$")


## ------------------------------------------------------------------------
strings <- c(
    "one",
    "two",
    "one two",
    "one   two",
    "one. two."
)
str_split(strings, " ")


## ------------------------------------------------------------------------
str_split(strings, boundary("word"))


## ------------------------------------------------------------------------
macdonald <- "Old MACDONALD had a farm."
str_to_lower(macdonald)


## ------------------------------------------------------------------------
str_to_upper(macdonald)


## ------------------------------------------------------------------------
str_to_sentence(macdonald)


## ------------------------------------------------------------------------
str_to_title(macdonald)


## ------------------------------------------------------------------------
strings <- c(
    "Give me an ice cream",
    "Get yourself an ice cream",
    "We are all out of ice creams",
    "I scream, you scream, everybody loves ice cream.",
    "one ice cream,
    two ice creams,
    three ice creams",
    "I want an ice cream. Do you want an ice cream?"
)
str_wrap(strings)


## ------------------------------------------------------------------------
str_wrap(strings, width = 10)


## ------------------------------------------------------------------------
str_wrap(strings, width = 10, indent = 2)


## ------------------------------------------------------------------------
str_pad(strings, width = 50)


## ------------------------------------------------------------------------
str_pad(strings, width = 50, side = "right")


## ------------------------------------------------------------------------
str_pad(strings, width = 50, side = "both")


## ------------------------------------------------------------------------
strings %>% str_trunc(25) %>% str_pad(width = 25, side = "left")


## ------------------------------------------------------------------------
str_trim(c(
    " one small coke",
    "two large cokes  ",
    " three medium cokes "
))


## ------------------------------------------------------------------------
str_trim(c(
    " one small  coke",
    "two   large cokes  ",
    " three  medium cokes "
))


## ------------------------------------------------------------------------
str_squish(c(
    " one small  coke",
    "two   large cokes  ",
    " three  medium cokes "
))


## ------------------------------------------------------------------------
str_detect(strings, "me")
str_detect(strings, "I")
str_detect(strings, "cream")


## ------------------------------------------------------------------------
str_detect(strings, "ice cream.")


## ------------------------------------------------------------------------
str_detect(strings, fixed("ice cream."))


## ------------------------------------------------------------------------
str_detect(strings, "ice cream\\.")


## ------------------------------------------------------------------------
str_detect(strings, fixed("ice cream."), negate = TRUE)


## ------------------------------------------------------------------------
str_starts(strings, "I")
str_ends(strings, fixed("."))


## ------------------------------------------------------------------------
str_locate(strings, "ice cream")


## ------------------------------------------------------------------------
strings[6]


## ------------------------------------------------------------------------
str_locate(strings[6], "ice cream")


## ------------------------------------------------------------------------
str_locate_all(strings[6], "ice cream")


## ------------------------------------------------------------------------
ice_cream_locations <- str_locate_all(strings[6], "ice cream")
ice_cream_locations
invert_match(ice_cream_locations[[1]])


## ------------------------------------------------------------------------
str_extract(strings, "(s|ice )cream\\w*")


## ------------------------------------------------------------------------
strings[4]
str_extract(strings[4], "(s|ice )cream\\w*")
str_extract_all(strings[4], "(s|ice )cream\\w*")


## ------------------------------------------------------------------------
lego_str <- str_replace(strings, "ice cream[s]?", "LEGO")
lego_str
lego_str <- str_replace(lego_str, "an LEGO", "a LEGO")
lego_str


## ------------------------------------------------------------------------
strings %>%
    str_replace("ice cream[s]?", "LEGO") %>%
    str_replace("an LEGO", "a LEGO")


## ------------------------------------------------------------------------
strings %>%
    str_replace_all("ice cream[s]?", "LEGO") %>%
    str_replace_all("an LEGO", "a LEGO")


## ------------------------------------------------------------------------
us_dates <- c(
    valentines = "2/14",
    my_birthday = "2/15",
    # no one knows but let's just go 
    # with this
    jesus_birthday = "12/24"
)
# US date format to a more sane format
str_replace(us_dates, "(.*)/(.*)", "\\2/\\1")


## ------------------------------------------------------------------------
str_c(
    "NA",
    str_dup("-NA", times = 7),
    " BATMAN!"
)


## ------------------------------------------------------------------------
# -- concatenation -------------------------------------------
c("foo", "bar", "baz")
str_c("foo", "bar", "baz")


## ------------------------------------------------------------------------
my_string <- "this is my string"
my_location <- str_locate(my_string, "my")
my_location
s <- my_location[,"start"]
e <- my_location[,"end"]
str_sub(my_string, s, e)

my_string_location <- str_locate(my_string, "string")
s <- my_string_location[,"start"]
e <- my_string_location[,"end"]
str_sub(my_string, s, e)

your_string <- my_string
s <- my_location[,"start"]
e <- my_location[,"end"]
str_sub(your_string, s, e) <- "your"
your_string

your_banana <- your_string
your_string_location <- str_locate(your_string, "string")
s <- your_string_location[,"start"]
e <- your_string_location[,"end"]
str_sub(your_banana, s, e) <- "banana"
your_banana


## ------------------------------------------------------------------------
my_string
your_string
your_banana


## ------------------------------------------------------------------------
macdonald <- "Old MacDonald"
eieio <- "E-I-E-I-O"
str_glue("{macdonald} had a farm. {eieio}")


## ------------------------------------------------------------------------
str_glue(
    "{macdonald} had a farm. {eieio}",
    macdonald = "Thomas",
    eieio = "He certainly did not!"
)


## ------------------------------------------------------------------------
str_glue(
    "{str_dup(\"NA-\", times = 7)}NA BATMAN!"
)


## ------------------------------------------------------------------------
x <- seq(1:10)
str_glue(
  "Holy {mean(x)} BATMAN!"
  )

