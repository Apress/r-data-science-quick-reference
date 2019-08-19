## ------------------------------------------------------------------------
my_data <- read_csv(file = "data/data.csv")


## ------------------------------------------------------------------------
read_csv(
    file = "data/data-no-header.csv",
    col_names = FALSE
)


## ------------------------------------------------------------------------
read_csv(
    'D, T, t
    "2018-08-23", "2018-08-23T14:30", 14:30',
    col_types = "DTt"
)


## ------------------------------------------------------------------------
read_csv(
    'A, B, C,    D
    1, a, a,  1.2
    0, b, b,  2.1
    1, c, c, 13',
    col_types = "lcfn")


## ------------------------------------------------------------------------
read_csv(
    file = "data/data.csv",
    col_type = "_cc-"
)


## ------------------------------------------------------------------------
read_csv(
    file = "data/data.csv",
    col_types = cols(A = col_integer())
)
read_csv(
    file = "data/data.csv",
    col_types = cols(D = col_character())
)


## ------------------------------------------------------------------------
my_data <- read_csv(
    file = "data/data.csv",
    col_types = cols(C = col_factor())
)
my_data$C


## ------------------------------------------------------------------------
my_data <- read_csv(
    file = "data/data.csv",
    col_types = cols(
        C = col_factor(levels = c("c", "b", "a"))
    )
)
my_data$C


## ------------------------------------------------------------------------
my_data <- read_csv(
    file = "data/data.csv",
    col_types = cols(
        B = col_factor(ordered = TRUE),
        C = col_factor(levels = c("c", "b", "a"))
    )
)
my_data$B
my_data$C


## ------------------------------------------------------------------------
x <- parse_datetime(c("Aug 15 1975 18:00"),
                    format = "%b %d %Y %R",
                    locale = locale(tz = "US/Pacific"))
x
y <- parse_datetime(c("Aug 15 1975 18:00 US/Pacific"),
                    format = "%b %d %Y %R %Z")
y
x == y


## ------------------------------------------------------------------------
read_table2(
    "A  B  C  D
     1  2  3  4
    15 16 17 18"
)


## ------------------------------------------------------------------------
read_table(
"
    A     B    C D
    121  xyz  14 15
    22   abc  24 25
"
)


## ------------------------------------------------------------------------
read_table(
"
    A     B     C D
    121  xyz  14 15
    22   abc  24 25
"
)

