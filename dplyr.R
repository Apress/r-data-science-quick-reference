## ------------------------------------------------------------------------
iris_df <- as_tibble(iris)
print(iris_df, n = 3)
head(iris_df$Species)


## ------------------------------------------------------------------------
iris_df %>%
    select(Sepal.Length, Species) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(-Species) %>%
    print(n = 3)

iris_df %>%
    select(-Species, -Sepal.Length) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(1) %>%
    print(n = 3)

iris_df %>%
    select(1:3) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(Petal.Length:Species) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(starts_with("Petal")) %>%
    print(n = 3)

iris_df %>%
    select(-starts_with("Petal")) %>%
    print(n = 3)

iris_df %>%
    select(starts_with("Petal"), Species) %>%
    print(n = 3)

iris_df %>%
    select(starts_with("PETAL", ignore.case = TRUE)) %>%
    print(n = 3)

iris_df %>%
    select(starts_with("S")) %>%
    print(n = 3)

iris_df %>%
    select(ends_with("Length")) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(contains("ng")) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df <- tribble(
    ~a1x, ~ax, ~a2x, ~b2, ~b2y, ~by,
    1, 2, 3, 4, 5, 6
)


## ------------------------------------------------------------------------
df %>%
    select(matches(".*\\d.*")) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df %>%
    select(matches(".+\\d.+")) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(sepal_length = Sepal.Length,
           sepal_width = Sepal.Width) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    rename(sepal_length = Sepal.Length,
           sepal_width = Sepal.Width) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    distinct(Species)


## ------------------------------------------------------------------------
iris_df %>%
    filter(Species == "setosa") %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter(Species == "setosa") %>%
    select(ends_with("Length"), Species) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter(Species != "setosa") %>%
    distinct(Species) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter(Sepal.Length > 5, Petal.Width < 0.4) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter(between(Sepal.Width, 2, 2.5)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter(str_starts(Species, "v")) %>%
    print(n = 3)

iris_df %>%
    filter(str_ends(Species, "r")) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    select(-Species) %>%
    filter_all(any_vars(. > 5)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter_at(vars(-Species), any_vars(. > 5)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter_at(c("Petal.Length", "Sepal.Length"),
              any_vars(. > 0)) %>%
    print(n = 3)

iris_df %>%
    filter_at(vars(Petal.Length, Sepal.Length),
              any_vars(. > 0)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
iris_df %>%
    filter_if(is.numeric, all_vars(. < 5)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df <- tribble(
    ~A, ~B, ~C,
     1,  2,  3,
     4,  5, NA,
    11, 12, 13,
    22, 22,  1
)
df %>% filter_all(all_vars(. > 3))


## ------------------------------------------------------------------------
df %>%
    filter_if(~ all(!is.na(.)), all_vars(. > 3))


## ------------------------------------------------------------------------
df %>% filter_all(all_vars(is.na(.) | . > 3))


## ------------------------------------------------------------------------
iris_df %>%
    arrange(Petal.Length) %>%
    print(n = 5)

iris_df %>%
    arrange(Sepal.Length, Petal.Length) %>%
    print(n = 5)


## ------------------------------------------------------------------------
iris_df %>%
    arrange(desc(Petal.Length)) %>%
    print(n = 5)


## ------------------------------------------------------------------------
df <- tribble(
    ~height, ~width,
         10,     12,
         42,     24,
         14,     12
)


## ------------------------------------------------------------------------
df %>% mutate(area = height * width)


## ------------------------------------------------------------------------
cm_per_inch = 2.54
df %>% mutate(
    height_cm = cm_per_inch * height,
    width_cm  = cm_per_inch * width,
    area_cm   = height_cm * width_cm
)


## ------------------------------------------------------------------------
df %>% mutate(cm_per_inch * height)


## ---- echo=FALSE, warning=FALSE------------------------------------------
suppressPackageStartupMessages(library(units, quietly = TRUE))


## ------------------------------------------------------------------------
df %>% mutate(
    height_in = units::as_units(height, "in"),
    width_in  = units::as_units(width, "in"),
    area_in   = height_in * width_in,
    height_cm = units::set_units(height_in, "cm"),
    width_cm  = units::set_units(width_in, "cm"),
    area_cm   = units::set_units(area_in, "cm^2")
)


## ------------------------------------------------------------------------
df %>% transmute(
    height_in = units::as_units(height, "in"),
    width_in  = units::as_units(width, "in"),
    area_in   = height_in * width_in,
    height_cm = units::set_units(height_in, "cm"),
    width_cm  = units::set_units(width_in, "cm"),
    area_cm   = units::set_units(area_in, "cm^2")
)


## ---- error=TRUE---------------------------------------------------------
df <- tibble(
    x = rnorm(3, mean = 12, sd = 5),
)
my_abs <- function(x) if (x < 0) -x else x
df %>% mutate(my_abs(x))


## ------------------------------------------------------------------------
df %>% mutate(abs(x))


## ------------------------------------------------------------------------
ifelse_abs <- function(x) ifelse(x < 0, -x, x)
df %>% mutate(ifelse_abs(x))


## ------------------------------------------------------------------------
my_abs <- Vectorize(my_abs)
df %>% mutate(my_abs(x))


## ------------------------------------------------------------------------
df <- tibble(x = rnorm(100))
df %>% 
    mutate(
        x_category = case_when(
            x - mean(x) < -2 * sd(x) ~ "small",
            x - mean(x) >  2 * sd(x) ~ "large",
            TRUE           ~ "medium"
        )
    ) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df <- tibble(x = rnorm(100), y = rnorm(100))
df %>% summarise(mean_x = mean(x), mean_y = mean(y))


## ------------------------------------------------------------------------
classify <- function(x) {
    case_when(
        x - mean(x) < -2 * sd(x) ~ "small",
        x - mean(x) >  2 * sd(x) ~ "large",
        TRUE           ~ "medium"
    )
}
df %>%
    mutate(x_category = classify(x)) %>%
    group_by(x_category) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df %>%
    mutate(x_category = classify(x)) %>%
    print(n = 3)


## ------------------------------------------------------------------------
df %>%
    mutate(x_category = classify(x)) %>%
    group_by(x_category) %>%
    summarise(mean_x = mean(x), no_x = n())


## ------------------------------------------------------------------------
df %>%
    mutate(x_category = classify(x)) %>%
    group_by(x_category) %>%
    group_vars()


## ------------------------------------------------------------------------
df <- tibble(x = rnorm(100), y = rnorm(100))
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category, y_category) %>%
    group_vars()


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category, y_category) %>%
    summarise(mean_x = mean(x), mean_y = mean(y))


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category) %>%
    summarise(mean_x = mean(x), mean_y = mean(y))


## ------------------------------------------------------------------------
df2 <- tribble(
    ~A,      ~B,    ~C, ~D,
    "left",  "up",   2, "yes",
    "right", "up",   5, "no",
    "left",  "down", 2, "yes",
    "left",  "down", 7, "no",
    "left",  "down", 3, "no",
    "right", "up",   8, "yes",
    "right", "up",   2, "yes",
    "right", "up",   8, "no"
)
df2 %>% group_by(A, B) %>%
    summarise(min_c = min(C), max_c = max(C))
df2 %>% group_by(A, B) %>%
    summarise(min_c = min(C), max_c = max(C)) %>%
    summarise(max_diff = max(max_c - min_c))
df2 %>% group_by(A, B, D) %>%
    summarise(min_c = min(C), max_c = max(C))
df2 %>% group_by(A, B, D) %>%
    summarise(min_c = min(C), max_c = max(C)) %>%
    summarise(max_diff = max(max_c - min_c))


## ------------------------------------------------------------------------
df2 %>% group_by(A, B) %>%
    summarise(min_c = min(C), max_c = max(C))


## ------------------------------------------------------------------------
df2 %>% group_by(A, B, D) %>%
    summarise(min_c = min(C), max_c = max(C)) %>%


## ------------------------------------------------------------------------
df2 %>% group_by(A, B, D) %>%
    summarise(min_c = min(C), max_c = max(C)) %>%
    summarise(min_diff = min(max_c - min_c))


## ------------------------------------------------------------------------
df2 %>% group_by(A, B, D) %>%
    summarise(min_c = min(C), max_c = max(C)) %>%
    ungroup() %>%
    summarise(min_diff = min(max_c - min_c))


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category) %>%
    mutate(mean_x = mean(x), mean_y = mean(y)) %>%
    print(n = 5)


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    mutate(mean_x = mean(x), mean_y = mean(y))


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category) %>%
    mutate(mean_x = mean(x), mean_y = mean(y))


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    mutate(mean_y = mean(y)) %>%
    group_by(x_category) %>%
    mutate(mean_x = mean(x)) %>%
    distinct(mean_x, mean_y)


## ------------------------------------------------------------------------
df %>%
    mutate(
        x_category = classify(x),
        y_category = classify(y)
    ) %>%
    group_by(x_category) %>%
    mutate(mean_x = mean(x)) %>%
    group_by(y_category) %>%
    mutate(mean_y = mean(y)) %>%
    distinct(
        x_category, mean_x,
        y_category, mean_y
    )


## ------------------------------------------------------------------------
df1 <- tibble(
    A = paste0("a", 1:2),
    B = paste0("b", 1:2)
)
df2 <- tibble(
    A = paste0("a", 3:4),
    B = paste0("b", 3:4)
)
df3 <- tibble(
    C = paste0("c", 1:2),
    D = paste0("d", 1:2)
)
bind_rows(df1, df2)
bind_cols(df1, df3)


## ------------------------------------------------------------------------
grades_maths <- tribble(
    ~name,            ~grade,
    "Marko Polo",     "D",
    "Isaac Newton",   "A+",
    "Charles Darwin", "B"
)
grades_biology <- tribble(
    ~name,            ~grade,
    "Marko Polo",     "F",
    "Isaac Newton",   "D",
    "Charles Darwin", "A+"
)

inner_join(grades_maths, grades_biology, by = "name")


## ------------------------------------------------------------------------
grades_maths2 <- tribble(
    ~name,            ~grade,
    "Marko Polo",     "D",
    "Isaac Newton",   "A+", # so good at physics
    "Isaac Newton",   "A+", # that he got an A+ twice
    "Charles Darwin", "B"
)
grades_biology2 <- tribble(
    ~name,            ~grade,
    "Marko Polo",     "F",
    "Isaac Newton",   "D",
    "Charles Darwin", "A+", # so good at biology that we
    "Charles Darwin", "A+"  # listed him twice
)
inner_join(grades_maths2, grades_biology2, by = "name")
inner_join(grades_maths2, grades_biology2, by = "grade")


## ------------------------------------------------------------------------
inner_join(grades_maths2, grades_biology2, by = "grade") %>%
    distinct()


## ------------------------------------------------------------------------
inner_join(
    grades_maths, grades_biology,
    by = "name", suffix = c(".maths", ".biology")
)


## ------------------------------------------------------------------------
grades_geography <- tribble(
    ~name,            ~grade,
    "Marko Polo",     "A",
    "Charles Darwin", "A",
    "Immanuel Kant",  "A+"
)
grades_physics <- tribble(
    ~name,            ~grade,
    "Isaac Newton",    "A+",
    "Albert Einstein", "A+",
    "Charles Darwin",  "C"
)

inner_join(
    grades_geography, grades_physics,
    by = "name", suffix = c(".geography", ".physics")
)


## ------------------------------------------------------------------------
full_join(
    grades_geography, grades_physics,
    by = "name", suffix = c(".geography", ".physics")
)


## ------------------------------------------------------------------------
left_join(
    grades_geography, grades_physics,
    by = "name", suffix = c(".geography", ".physics")
)
right_join(
    grades_maths, grades_physics,
    by = "name", suffix = c(".maths", ".physics")
)


## ------------------------------------------------------------------------
semi_join(
    grades_maths2, grades_biology2,
    by = "name", suffix = c(".geography", ".physics")
)


## ------------------------------------------------------------------------
inner_join(
    grades_maths2, grades_biology2,
    by = "name", suffix = c(".geography", ".physics")
) %>% select(1:2)


## ------------------------------------------------------------------------
anti_join(
    grades_maths2, grades_physics,
    by = "name", suffix = c(".geography", ".physics")
)


## ------------------------------------------------------------------------
grades <- list(
    grades_maths, grades_biology,
    grades_geography, grades_physics
)
grades %>%
    reduce(full_join, by = "name") %>%
    rename_at(2:5, ~ c("maths", "biology", "geography", "physics"))


## ------------------------------------------------------------------------
mean_income <- tribble(
    ~country,  ~`2002`, ~`2003`, ~`2004`, ~`2005`,
    "Numenor",  123456,  132654,      NA,  324156,
    "Westeros", 314256,  NA,          NA,  465321,
    "Narnia",   432156,  NA,          NA,      NA,
    "Gondor",   531426,  321465,  235461,  463521,
    "Laputa",    14235,   34125,   45123,   51234,
)


## ------------------------------------------------------------------------
mean_income %>%
    gather(
        key = "year",
        value = "mean_income",
        -country
    ) %>% group_by(
        country
    ) %>% mutate(
        mean_per_country = mean(mean_income, na.rm = TRUE),
        mean_income = ifelse(
            is.na(mean_income),
            mean_per_country,
            mean_income
        )
    ) %>% spread(key = "year", value = "mean_income")


## ------------------------------------------------------------------------
mean_income %>%
    gather(
        key = "year",
        value = "mean_income",
        -country
    )


## ------------------------------------------------------------------------
mean_income %>%
    gather(
        key = "year",
        value = "mean_income",
        -country
    ) %>% group_by(
        country
    ) %>% summarise(
        per_country_mean = mean(mean_income, na.rm = TRUE)
    )


## ------------------------------------------------------------------------
mean_income %>%
    gather(
        key = "year",
        value = "mean_income",
        -country
    ) %>% group_by(
        country
    ) %>% mutate(
        mean_per_country = mean(mean_income, na.rm = TRUE)
    ) 


## ------------------------------------------------------------------------
mean_income %>%
    gather(
        key = "year",
        value = "mean_income",
        -country
    ) %>% group_by(
        country
    ) %>% mutate(
        mean_per_country = mean(mean_income, na.rm = TRUE)
    ) %>% ungroup(
    ) %>% mutate(
        mean_income = ifelse(
            is.na(mean_income),
            mean_per_country,
            mean_income
        )
    ) %>% spread(key = "year", value = "mean_income")

