# =============================================================================
# analysis.R
# Does National Individualism Predict AI Sentiment?
# Testing the individualism/collectivism explanation for the Asia-vs-West
# AI optimism gap, using Ipsos AI Monitor 2025 (30 countries) and Hofstede's
# Individualism Index (IDV)

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

df <- sentiment %>%
  inner_join(hofstede, by = "country")

cat("Merged (both variables present):", nrow(df), "countries\n")

missing_hofstede <- setdiff(sentiment$country, hofstede$country)
if (length(missing_hofstede) > 0) {
  cat("Countries in sentiment data with NO Hofstede match:", paste(missing_hofstede, collapse = ", "), "\n")
}

# Flag which rows rely on the less-certain supplementary Hofstede values
# (see data/raw/hofstede_idv.csv source_note column -- these 6 countries'
# IDV scores could not be confirmed against the same single consistent
# source as the other 24, and should be spot-checked against the official
# Hofstede Insights country comparison tool before treating results
# involving them as final)
df <- df %>%
  mutate(idv_source_verified = source_note == "PMC_table5_consistent")

cat("\nRows using verified-consistent IDV source:", sum(df$idv_source_verified), "\n")
cat("Rows using supplementary (less certain) IDV source:", sum(!df$idv_source_verified), "\n")

write_csv(df, "data/processed/sentiment_idv_merged.csv")
cat("\nWrote data/processed/sentiment_idv_merged.csv\n")

# =============================================================================
# PART 2: DOES INDIVIDUALISM PREDICT AI SENTIMENT?
# =============================================================================

sink("report/stats_results.txt", split = TRUE)

cat("=============================================================\n")
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
cat("Robustness check: does excluding the 6 less-certain IDV values change it?\n")
cat("=============================================================\n")
df_verified_only <- df %>% filter(idv_source_verified)
cat("n =", nrow(df_verified_only), "(verified-source countries only)\n")
print(cor.test(df_verified_only$idv, df_verified_only$pct_beneficial, method = "pearson"))

sink()
cat("\nStats complete. Output in report/stats_results.txt\n")

theme_set(theme_minimal(base_size = 12))

p1 <- ggplot(df, aes(x = idv, y = pct_beneficial)) +
  geom_smooth(method = "lm", se = TRUE, color = "gray40", fill = "gray85") +
  geom_point(aes(color = idv_source_verified), size = 3) +
  geom_text_repel(aes(label = country), size = 3, max.overlaps = 15) +
  scale_color_manual(values = c(`TRUE` = "#2c7fb8", `FALSE` = "#d95f0e"),
                      labels = c(`TRUE` = "Verified single-source IDV", `FALSE` = "Supplementary IDV (spot-check recommended)"),
                      name = NULL) +
  labs(
    title = "Does national individualism predict AI optimism?",
    subtitle = paste0("n = ", nrow(df), " countries; Hofstede Individualism Index vs. Ipsos 2025 AI sentiment"),
    x = "Hofstede Individualism Index (IDV) -- higher = more individualistic",
    y = "% who see AI as more beneficial than harmful (2025)"
  ) +
  theme(legend.position = "bottom")
ggsave("figures/01_individualism_vs_ai_sentiment.png", p1, width = 9, height = 7, dpi = 150)

cat("Figure written to figures/\n")
cat("\n=== analysis.R finished ===\n")

