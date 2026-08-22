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
Malaysia (70%) see AI as overwhelmingly beneficial, while countries like Canada (40%) and
the United States (42%) are far more skeptical. This analysis tests one of the leading
explanations from cross-cultural psychology: does a country's position on Hofstede's
Individualism Index statistically predict its AI sentiment?

**Method.** Hofstede's classic Individualism Index (IDV) was correlated against Ipsos's
2025 AI Monitor survey. The primary analysis uses 24 countries whose IDV score could be
confirmed against a single, internally consistent source.

| Test | Result |
|---|---|
| Pearson correlation (n=24) | r = -0.83, p = 5.2x10⁻⁷ |
| Linear model | R² = 0.69 |

**Key findings.**

- **Individualism explains roughly 69% of the cross-country variation in AI sentiment**
  among the 24 verified countries -- a strong, statistically robust relationship. More
  individualistic countries are significantly less optimistic about AI; more collectivist
  countries are significantly more optimistic.
- **A real methodological problem was found and corrected, not hidden.** While sourcing
  data for all 30 Ipsos countries, six could not be confirmed against the same source as
  the other 24. Checking the current official Hofstede source revealed it now uses a
  different, non-comparable methodology for this dimension (Minkov & Kaasa, 2022) --
  Hofstede's own successor organisation explicitly warns this produces "counter-intuitive
  results" and is "a different concept... with different data behind it." Rather than
  patching the six missing countries with this incompatible measure, they were excluded
  from the primary analysis entirely.
- **China is not in this analysis.** The frequently cited "China 83%" AI optimism figure
  comes from a different Ipsos survey wave than the one used here.

**Honest caveat.** This is a correlational, bivariate finding. It does not control for
other plausible confounds -- GDP per capita, government AI messaging, media environment --
that likely correlate with both individualism and AI sentiment. Full detail, including the
full methodological discussion of the Hofstede data-quality issue, is in the accompanying
report.
