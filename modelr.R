## ------------------------------------------------------------------------
model <- lm(disp ~ hp + wt, data = mtcars)
summary(model)


## ------------------------------------------------------------------------
tidy(model) # transform to tidy tibble
glance(model) # model summaries
augment(model) # add model info to data


## ------------------------------------------------------------------------
x <- tibble(
  x = runif(5),
  y = 15 *12 * x + 42 + rnorm(5)
)
model <- lm(y ~ x, data = x)
tidy(model)


## ------------------------------------------------------------------------
add_predictions(x, model)
add_residuals(x, model)


## ------------------------------------------------------------------------
xs <- tibble(x = seq(0, 1, length.out = 5))
add_predictions(xs, model)


## ------------------------------------------------------------------------
seq(0, 1, length.out = 5)
seq_range(x$x, n = 5) # over the range of observations


## ------------------------------------------------------------------------
# comparing models
model2 <- lm(y ~ I(x^2) + x, data = x)
gather_predictions(xs, model, model2)
spread_predictions(xs, model, model2)


## ------------------------------------------------------------------------
gather_predictions(x, model, model2)
spread_predictions(x, model, model2)


## ------------------------------------------------------------------------
gather_residuals(x, model, model2)
spread_residuals(x, model, model2)


## ------------------------------------------------------------------------
bootstrap(x, n = 3)


## ------------------------------------------------------------------------
crossv_mc(x, n = 3)


## ------------------------------------------------------------------------
crossv_kfold(x, k = 3)
crossv_loo(x)


## ------------------------------------------------------------------------
samples <- bootstrap(x, 3)
fitted_models <- samples$strap %>%
  map(~ lm(y ~ x, data = .))


## ------------------------------------------------------------------------
fitted_models %>%
  map(glance) %>%
  bind_rows()


## ------------------------------------------------------------------------
get_x <- function(m) {
  tidy(m) %>% filter(term == "x") %>%
    select(estimate) %>% as.double()
}
fitted_models %>% map_dbl(get_x)


## ------------------------------------------------------------------------
models <- formulae(~y, linear = ~x, quadratic = ~I(x^2) + x)


## ------------------------------------------------------------------------
fits <- fit_with(x, lm, models)
fits %>% map(glance) %>% bind_rows()


## ------------------------------------------------------------------------
fits %>% map_dbl(rmse, data = x)


## ------------------------------------------------------------------------
fits %>% map_dbl(mae, data = x)


## ------------------------------------------------------------------------
fits %>% map_dbl(~ glance(.x)$AIC)


## ------------------------------------------------------------------------
samples <- crossv_loo(x)
training_fits <-
  samples$train %>% map(~lm(y ~ x, data = .))

test_measurement <- training_fits %>%
  map2_dbl(samples$test, rmse)

test_measurement

