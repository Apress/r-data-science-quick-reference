## ---- echo=FALSE---------------------------------------------------------
suppressPackageStartupMessages(library(lubridate, quietly = TRUE))


## ------------------------------------------------------------------------
ymd("1975 Feb 15")
ymd("19750215")
ymd("1975/2/15")
ymd("1975-02-15")


## ------------------------------------------------------------------------
dmy("150275")
mdy("February 15th 1975")


## ------------------------------------------------------------------------
dmy_h("15/2/1975 2pm")
dmy_hm("15/2/1975 14:30")
dmy_hms("15/2/1975 14:30:10")


## ------------------------------------------------------------------------
x <- dmy_hms("15/2/1975 14:30:10")


## ------------------------------------------------------------------------
c(day(x), month(x), year(x))
c(hour(x), minute(x), second(x))
c(week(x), # The week in the year
  wday(x), # The day in the week
  yday(x)) # The day in the year


## ------------------------------------------------------------------------
minute(x) <- 15
wday(x) <- 42
x


## ------------------------------------------------------------------------
x <- dmy_hm(
  "15/2/1975 14:00", 
  tz = "Europe/Copenhagen"
)
x


## ------------------------------------------------------------------------
force_tz(
  dmy_hm("15/2/1975 14:00",
         tz = "Europe/Copenhagen"),
  tz = "Europe/London"
) 


## ------------------------------------------------------------------------
with_tz(x, tz = "Europe/London")


## ------------------------------------------------------------------------
start <- dmy("02 11 1949")
end <- dmy("15 02 1975")
interval(start, end)


## ------------------------------------------------------------------------
start %--% end


## ------------------------------------------------------------------------
int <- interval(start, end)
int
int_start(int)
int_end(int)


## ------------------------------------------------------------------------
end %--% start
int_start(start %--% end)
int_start(end %--% start)


## ------------------------------------------------------------------------
int_flip(end %--% start)


## ------------------------------------------------------------------------
int_standardize(start %--% end)
int_standardize(end %--% start)


## ------------------------------------------------------------------------
x <- now()
int <- interval(x, x + minutes(1))
int
int_length(int)

int <- interval(x, x + minutes(20))
int
int_length(int) / 60


## ------------------------------------------------------------------------
ymd("1867 05 02") %within% int
ymd("1959 04 23") %within% int


## ------------------------------------------------------------------------
int_start(int) <- dmy("19 Aug 1950")
int
int_end(int) <- dmy("19 Sep 1950")
int


## ------------------------------------------------------------------------
int_shift(int, months(1))


## ------------------------------------------------------------------------
int1 <- interval(dmy("19 oct 1950"), dmy("25 nov 1951"))
int2 <- interval(dmy("19 oct 1948"), dmy("25 aug 1951"))
int3 <- interval(dmy("19 oct 1981"), dmy("25 aug 2051"))
c(int, int1)
# int1 is contained in int
int_overlaps(int, int1)
# int2 starts before int but they overlap
int_overlaps(int, int2)
# no overlap
int_overlaps(int, int3)


## ------------------------------------------------------------------------
c(
  int_aligns(int, int1),
  int_aligns(int, int2),
  int_aligns(int, int3)
)


## ------------------------------------------------------------------------
int4 <- interval(int_start(int), int_end(int) + years(3))
int5 <- int_shift(int4, -years(3))
int6 <- int_shift(int5, -years(3))

c(
  int_aligns(int, int4), # share start
  int_aligns(int, int5), # share end
  int_aligns(int, int6)  # overlaps but does not share endpoints
)

