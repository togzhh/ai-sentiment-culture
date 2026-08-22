---
title: "Executive Summary"
subtitle: "Does National Individualism Predict AI Sentiment?"
author: "Togzhan"
date: "July 2026"
mainfont: "DejaVu Serif"
geometry: margin=1in
fontsize: 11pt
---

**Question.** Global surveys consistently show that countries like Indonesia (85%) and
Thailand (78%) see AI as overwhelmingly beneficial, while countries like Canada (40%) and
the United States (42%) are far more skeptical. This analysis tests one of the leading
explanations from cross-cultural psychology: does a country's position on Hofstede's
Individualism Index statistically predict its AI sentiment?

**Method.** Hofstede's Individualism Index (IDV) was correlated against Ipsos's 2025 AI
Monitor survey (30 countries, n=23,216 adults), specifically the item "AI has more
benefits than drawbacks."

| Test | Result |
|---|---|
| Pearson correlation | r = -0.85, p = 2.8x10⁻⁹ |
| Linear model | R² = 0.72 |
| Robustness check (24 verified-source countries) | r = -0.83, p = 5.2x10⁻⁷ |

**Key findings.**

- **Individualism explains roughly 72% of the cross-country variation in AI sentiment** --
  a strong, statistically robust relationship. More individualistic countries are
  significantly less optimistic about AI; more collectivist countries are significantly
  more optimistic.
- **The result survives a data-quality robustness check.** Six of the 30 countries' IDV
  scores came from a less-certain supplementary source rather than a single consistent
  table. Excluding these six barely changes the result (r=-0.83 vs. -0.85), increasing
  confidence the finding isn't an artifact of that data-quality gap.
- **China is not in this analysis.** The frequently cited "China 83%" AI optimism figure
  comes from a different Ipsos survey wave than the 30-country sample used here --
  worth knowing before assuming this dataset covers every country commonly discussed in
  AI sentiment coverage.

**Honest caveat.** This is a correlational, bivariate finding. It does not control for
other plausible confounds -- GDP per capita, government AI messaging, media environment --
that likely correlate with both individualism and AI sentiment. The strength of the
relationship (R²=0.72) is unusually high for cross-national attitude research, which is
itself a reason for appropriate caution rather than overclaiming a fully isolated cultural
effect. Full detail in the accompanying report.
