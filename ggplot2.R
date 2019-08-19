## ------------------------------------------------------------------------
p <- ggplot()


## ------------------------------------------------------------------------
summary(p)


## ------------------------------------------------------------------------
dat <- tibble(
  foo = runif(100),
  bar = 20 * foo + 5 + rnorm(100, sd = 10),
  baz = rep(1:2, each = 50)
)
p <- ggplot(data = dat)


## ------------------------------------------------------------------------
p <- ggplot(data = dat, aes(x = foo, y = bar, color = baz))


## ------------------------------------------------------------------------
p <- ggplot(data = dat, aes(x = foo, y = bar, color = baz)) +
       geom_point()


## ----simplest_geom_point, fig.cap="Point geometry plot"------------------
print(p)


## ----discrete-colour, fig.cap="Discrete colour aesthetics"---------------
ggplot(data = dat, aes(x = foo, y = bar, color = factor(baz))) +
  geom_point()


## ----line-plot, fig.cap="A line plot"------------------------------------
ggplot(data = arrange(dat, foo), 
       aes(x = foo, y = bar, color = factor(baz))) + 
  geom_line()


## ---- warnings=FALSE-----------------------------------------------------
p <- ggplot(data = dat, 
            aes(x = foo, y = bar, color = baz)) + 
  geom_point() + 
  geom_smooth(method = "loess")


## ----combined-point-smooth, fig.cap="Plot with two geometries"-----------
print(p)


## ---- combined-point-smooth-discrete, fig.cap="Plot with two geometries and a discrete colour"----
ggplot(data = dat, aes(x = foo, y = bar, color = factor(baz))) + 
  geom_point() + geom_smooth(method = "loess")


## ----hist-plot, fig.cap="Histogram plot"---------------------------------
ggplot(data = dat, aes(x = foo)) + 
  geom_histogram(binwidth = 0.05)


## ---- facet-grid, fig.cap="Faceting the plot"----------------------------
ggplot(data = dat, aes(x = foo, y = bar)) + 
  geom_point() + facet_grid(~ factor(baz))


## ----two-dim-facet, fig.cap="Facet grid for two variables."--------------
dat2 <- tibble(
  foo = rep(1:5, each = 20),
  bar = rep(1:2, each = 50),
  x = foo * bar + rnorm(100),
  y = -foo
)
ggplot(data = dat2, aes(x = x, y = y)) + 
  geom_point() + facet_grid(factor(foo) ~ factor(bar))


## ----multi-variables-facets, fig.cap="Facet with four variables"---------
dat3 <- tibble(
  foo = factor(rep(1:5, each = 20)),
  bar = factor(rep(1:2, each = 50)),
  baz = factor(rep(1:5, times = 20)),
  qux = factor(rep(1:2, times = 50)),
  x = rnorm(100),
  y = rnorm(100)
)
ggplot(data = dat3, aes(x = x, y = y)) + 
  geom_point() + facet_grid(foo + bar ~ baz + qux)


## ----coord-flip, fig.cap="Plot with the x-coordinate flipped."-----------
ggplot(data = dat, aes(x = foo, y = bar)) + 
  geom_point() + coord_flip()


## ----polar, fig.cap="Plot in polar coordinates."-------------------------
ggplot(data = dat, aes(x = foo, y = bar)) + 
  geom_point() + coord_polar()

