library(dplyr)

# ============================================================
# Load results
# ============================================================

x <- readRDS("inst/os_experiment/monte_carlo_scaling_q_full.rds")
results_mc <- if (is.data.frame(x)) x else x$results_mc


# ============================================================
# Summary by q
# ============================================================

summary_q <- results_mc %>%
  group_by(q) %>%
  summarise(
    d = unique(d),

    svd_rmse = sqrt(mean(svd_mse, na.rm = TRUE)),
    os_rmse  = sqrt(mean(os_mse,  na.rm = TRUE)),
    rml_rmse = sqrt(mean(rml_mse, na.rm = TRUE)),

    os_time     = median(os_time, na.rm = TRUE),
    rml_time    = median(rml_time, na.rm = TRUE),
    lavaan_time = median(lavaan_time, na.rm = TRUE),

    rml_speedup = median(
      rml_time / os_time,
      na.rm = TRUE
    ),

    lavaan_speedup = median(
      lavaan_time / os_time,
      na.rm = TRUE
    ),

    svd_failures = sum(!svd_success),
    os_failures  = sum(!os_success),
    rml_failures = sum(!rml_success),

    os_constraint =
      max(os_constraint, na.rm = TRUE),

    rml_constraint =
      max(rml_constraint, na.rm = TRUE),

    .groups = "drop"
  )




# ============================================================
# Appendix table
# ============================================================

table_q <- summary_q %>%
  select(
    q,
    d,
    svd_rmse,
    os_rmse,
    rml_rmse,
    os_time,
    rml_time,
    lavaan_time,
    rml_speedup,
    lavaan_speedup
  )

print(table_q)




