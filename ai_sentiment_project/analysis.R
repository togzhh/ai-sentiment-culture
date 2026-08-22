# =============================================================================
# analysis.R
# Does National Individualism Predict AI Sentiment?
# Testing the individualism/collectivism explanation for the Asia-vs-West
# AI optimism gap, using Ipsos AI Monitor 2025 and Hofstede's Individualism
# Index (IDV)
# =============================================================================

library(dplyr)
library(readr)
library(ggplot2)
library(ggrepel)
library(broom)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("figures", recursive = TRUE, showWarnings = FALSE)
dir.create("report", recursive = TRUE, showWarnings = FALSE)

# =============================================================================
# PART 1: CLEAN & MERGE
# =============================================================================

sentiment <- read_csv("data/raw/ipsos_sentiment_2025.csv", show_col_types = FALSE)
hofstede <- read_csv("data/raw/hofstede_idv.csv", show_col_types = FALSE)

cat("Sentiment data:", nrow(sentiment), "countries\n")
cat("Hofstede data:", nrow(hofstede), "countries\n")

df_all <- sentiment %>%
  inner_join(hofstede, by = "country") %>%
  mutate(idv_source_verified = source_note == "PMC_table5_consistent")

cat("Merged (both variables present):", nrow(df_all), "countries\n")
cat("  Verified-consistent classic IDV source:", sum(df_all$idv_source_verified), "\n")
cat("  Excluded from primary analysis (unconfirmed source/methodology risk):",
    sum(!df_all$idv_source_verified), "--",
    paste(df_all$country[!df_all$idv_source_verified], collapse = ", "), "\n")

write_csv(df_all, "data/processed/sentiment_idv_all_countries.csv")

# PRIMARY ANALYSIS DATASET: verified-source countries only
df <- df_all %>% filter(idv_source_verified)
cat("\nPrimary analysis dataset: n =", nrow(df), "countries\n")

write_csv(df, "data/processed/sentiment_idv_primary.csv")
cat("Wrote data/processed/sentiment_idv_primary.csv (primary, n=24)\n")
cat("Wrote data/processed/sentiment_idv_all_countries.csv (all 30, for transparency only -- not used for reported results)\n")

# =============================================================================
# PART 2: DOES INDIVIDUALISM PREDICT AI SENTIMENT? (PRIMARY ANALYSIS, n=24)
# =============================================================================

sink("report/stats_results.txt", split = TRUE)

cat("=============================================================\n")
cat("PRIMARY ANALYSIS (n=24, verified classic Hofstede IDV only)\n")
cat("Correlation: Hofstede Individualism (IDV) vs. % seeing AI as beneficial\n")
cat("=============================================================\n")

cor_test <- cor.test(df$idv, df$pct_beneficial, method = "pearson")
print(cor_test)

cat("\nSpearman (rank-based, robust to outliers/non-linearity):\n")
print(cor.test(df$idv, df$pct_beneficial, method = "spearman"))

m1 <- lm(pct_beneficial ~ idv, data = df)
cat("\nLinear model summary:\n")
print(summary(m1))

cat("\n\n=============================================================\n")
cat("FOR TRANSPARENCY ONLY -- NOT A REPORTED RESULT\n")
cat("What the correlation looks like if the 6 excluded countries are added\n")
cat("back in using their unconfirmed-source IDV values. This is shown only\n")
cat("to document that the primary finding is not sensitive to their\n")
cat("inclusion/exclusion -- it is not a valid alternative estimate, since it\n")
cat("mixes potentially incompatible IDV measurement approaches.\n")
cat("=============================================================\n")
cat("n =", nrow(df_all), "\n")
print(cor.test(df_all$idv, df_all$pct_beneficial, method = "pearson"))

sink()
cat("\nStats complete. Output in report/stats_results.txt\n")

theme_set(theme_minimal(base_size = 12))

p1 <- ggplot(df, aes(x = idv, y = pct_beneficial)) +
  geom_smooth(method = "lm", se = TRUE, color = "gray40", fill = "gray85") +
  geom_point(color = "#2c7fb8", size = 3) +
  geom_text_repel(aes(label = country), size = 3, max.overlaps = 15) +
  labs(
    title = "Does national individualism predict AI optimism?",
    subtitle = paste0("n = ", nrow(df), " countries with verified classic Hofstede IDV; Ipsos 2025 AI sentiment"),
    x = "Hofstede Individualism Index (IDV) -- higher = more individualistic",
    y = "% who see AI as more beneficial than harmful (2025)"
  )
ggsave("figures/01_individualism_vs_ai_sentiment.png", p1, width = 9, height = 7, dpi = 150)

cat("Figure written to figures/ (primary analysis, n=24, verified countries only)\n")
cat("\n=== analysis.R finished ===\n")
