library(dplyr)
library(ggplot2)

# ============================================================
# Load results
# ============================================================

x <- readRDS("inst/os_experiment/monte_carlo_scaling_n_full.rds")

results_mc <- if (is.data.frame(x)) x else x$results_mc


# ============================================================
# Summary by n
# ============================================================

summary_n <- results_mc %>%
  group_by(n) %>%
  summarise(
    M = n(),

    svd_rmse = sqrt(mean(svd_mse, na.rm = TRUE)),
    os_rmse  = sqrt(mean(os_mse,  na.rm = TRUE)),
    rml_rmse = sqrt(mean(rml_mse, na.rm = TRUE)),

    D_os_mean = mean(scaled_os_rml_distance, na.rm = TRUE),
    D_os_sd   = sd(scaled_os_rml_distance, na.rm = TRUE),

    D_svd_mean = mean(scaled_svd_rml_distance, na.rm = TRUE),
    D_svd_sd   = sd(scaled_svd_rml_distance, na.rm = TRUE),

    os_likelihood_gap =
      mean(likelihood_gap, na.rm = TRUE),

    os_constraint =
      max(os_constraint, na.rm = TRUE),

    rml_constraint =
      max(rml_constraint, na.rm = TRUE),

    svd_failures = sum(!svd_success),
    os_failures  = sum(!os_success),
    rml_failures = sum(!rml_success),

    .groups = "drop"
  ) %>%

  mutate(
    D_os_se = D_os_sd / sqrt(M),
    D_os_lower = D_os_mean - 1.96 * D_os_se,
    D_os_upper = D_os_mean + 1.96 * D_os_se,

    D_svd_se = D_svd_sd / sqrt(M),
    D_svd_lower = D_svd_mean - 1.96 * D_svd_se,
    D_svd_upper = D_svd_mean + 1.96 * D_svd_se
  )




# ============================================================
# Main-paper table
# ============================================================

table_n <- summary_n %>%
  select(
    n,
    svd_rmse,
    os_rmse,
    rml_rmse,
    D_os_mean,
    D_svd_mean
  )

print(table_n)





# ============================================================
# Figure data
# ============================================================

plot_n <- bind_rows(
  summary_n %>%
    transmute(
      n,
      estimator = "One-Step",
      mean = D_os_mean,
      lower = D_os_lower,
      upper = D_os_upper
    ),

  summary_n %>%
    transmute(
      n,
      estimator = "SVD",
      mean = D_svd_mean,
      lower = D_svd_lower,
      upper = D_svd_upper
    )
)

plot_n$estimator <- factor(
  plot_n$estimator,
  levels = c("One-Step", "SVD")
)


# ============================================================
#  figure
# ============================================================

p <- ggplot(
  plot_n,
  aes(
    x = n,
    y = mean,
    linetype = estimator,
    group = estimator
  )
) +
  geom_line(linewidth = 0.75) +
  geom_errorbar(
    aes(ymin = lower, ymax = upper),
    width = 70,
    linewidth = 0.45
  ) +
  scale_linetype_manual(
    values = c(
      "One-Step" = "solid",
      "SVD" = "dashed"
    )
  ) +
  scale_x_continuous(
    breaks = sort(unique(plot_n$n))
  ) +
  scale_y_continuous(
    breaks = seq(0, 3, 0.25),
    limits = c(0, 3)
  ) +
  labs(
    x = "Sample size n",
    y = expression(D[n]),
    linetype = NULL
  ) +
  theme_bw(base_size = 9) +
  theme(
    legend.position = "top",
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )

print(p)

ggsave(
  "inst/os_experiment/figure_scaling_n_Dn.pdf",
  p,
  device = cairo_pdf,
  width = 4.6,
  height = 3.0,
  units = "in"
)


