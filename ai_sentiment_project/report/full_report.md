---
title: "Does National Individualism Predict AI Sentiment?"
subtitle: "Testing the Cultural-Dimensions Explanation for the Asia-West AI Optimism Gap"
author: "Togzhan"
date: "July 2026"
mainfont: "DejaVu Serif"
geometry: margin=1in
fontsize: 11pt
toc: true
toc-depth: 2
numbersections: true
---

# Abstract {-}

Global surveys of public attitudes toward AI consistently find a striking regional pattern:
countries such as Indonesia and Thailand report overwhelming optimism about AI, while
countries such as Canada and the United States are far more skeptical. Cross-cultural
psychology offers a candidate explanation: individualistic cultures tend to frame new
technology as a potential threat to personal autonomy, while collectivist cultures more
often frame it as a tool that helps people function within their social environment. This
analysis tests that explanation directly and quantitatively, correlating Hofstede's
Individualism Index against Ipsos's 2025 AI Monitor survey (30 countries, n=23,216 adults).
The result is a strong, statistically robust negative correlation (r=-0.85, p=2.8x10⁻⁹):
individualism alone explains approximately 72% of the cross-country variation in AI
sentiment. The relationship survives a robustness check excluding six countries whose
cultural-dimension data could not be confirmed against a single consistent source.

# Introduction and Motivation

Public commentary on the global divide in AI sentiment tends to reach for economic
explanations (wealthier countries have more to lose; poorer countries see AI as a path to
catching up) or narrower cultural anecdotes (Japan's friendly-robot pop culture versus
Hollywood's dystopian AI narratives). This analysis tests a more specific, established
psychological construct directly: Hofstede's Individualism Index, a widely used measure of
whether a society emphasizes individual autonomy or group interdependence. The hypothesis,
drawn from published cross-cultural psychology research, is that individualistic societies
frame AI primarily as a threat to personal autonomy and privacy, while collectivist
societies more often frame it as an extension of the self that helps one function within a
group -- a positive frame in a collectivist value system.

# Research Question

**Does Hofstede's Individualism Index (IDV) correlate with the percentage of a country's
population who see AI as more beneficial than harmful?**

# Data and Limitations

**AI sentiment.** Ipsos AI Monitor 2025, a 30-country Global Advisor survey of 23,216
adults, fielded March 21 - April 4, 2025. The specific item used is "Products and services
using artificial intelligence have more benefits than drawbacks."

**Cultural dimension.** Hofstede's Individualism Index (IDV), a 0-100 scale where higher
values indicate greater individualism.

**Known limitations.**

- **This Ipsos wave does not include China.** The widely cited "China 83%" AI-optimism
  figure comes from a different Ipsos wave (cited in Stanford's AI Index 2025), not the
  2025 30-country wave used here. Ipsos's country coverage changes between waves, so a
  single-source, multi-year, China-inclusive panel is not available from this survey
  series alone.
- **Hofstede IDV source consistency.** Twenty-four of the 30 countries' IDV scores come
  from a single, internally consistent peer-reviewed table. The remaining six (Thailand,
  Singapore, Ireland, Sweden, Hungary, Spain) are drawn from supplementary sources and
  could not be confirmed against that same table. This matters because Hofstede's
  published scores have been revised over time -- the official source notes that the
  individualism and long-term-orientation dimensions were last updated in October 2023 --
  so mixing values from different vintages across countries is a genuine, disclosed risk.
  This is addressed directly with a robustness check (Section 5) that re-runs the analysis
  excluding these six countries.
- **Sample representativeness.** Ipsos's own methodology discloses that several countries
  in the survey (including Brazil, Indonesia, Malaysia, Thailand, and Turkiye) have samples
  skewed toward more urban, educated, or affluent respondents than their general
  population. Results for these countries should be read as reflecting a more "connected"
  segment of the population.
- **Correlational, not causal.** A strong correlation between individualism and AI
  sentiment does not establish that cultural values cause the sentiment gap. Both could be
  driven by a shared third factor -- for example, economic growth expectations, government
  AI strategy and messaging, or media environment -- that this analysis does not measure
  directly.

# Methodology

1. **Clean and merge** (`analysis.R`, Part 1): the two datasets were joined on country
   name. All 30 Ipsos countries had an available Hofstede IDV score. Each row was flagged
   according to whether its IDV score came from the single consistent source or a
   supplementary source.
2. **Test** (Part 2): Pearson and Spearman correlations were computed between IDV and AI
   sentiment, followed by a simple linear regression. A robustness check re-ran the
   correlation using only the 24 countries with verified-consistent IDV data, to confirm
   the result was not being driven by the six less-certain data points.

# Results

Following the merge, the analysis dataset contains all 30 Ipsos-surveyed countries with a
matched Hofstede IDV score.

| Test | Result |
|---|---|
| Pearson correlation | r = -0.85, p = 2.8x10⁻⁹ |
| Spearman correlation | rho = -0.85, p = 1.8x10⁻⁹ |
| Linear model | R² = 0.72, slope = -0.42 |
| Robustness check (n=24, verified-source only) | r = -0.83, p = 5.2x10⁻⁷ |

Table: Summary of statistical tests.

The relationship is visualized in Figure 1: a strong, clearly linear, negative
relationship, with the most collectivist countries in the sample (Indonesia, Thailand,
Singapore) clustered at the high-sentiment end, and the most individualistic countries
(the United States, Australia, the United Kingdom, Canada) clustered at the low-sentiment
end.

![Hofstede Individualism Index vs. Ipsos 2025 AI sentiment, 30 countries. Blue points use IDV scores confirmed against a single consistent source; orange points use supplementary sources.](../figures/01_individualism_vs_ai_sentiment.png){width=95%}

Individualism alone explains approximately 72% of the variance in AI sentiment across
these 30 countries (R²=0.72) -- a substantially larger effect than is typical in
cross-national social-attitude research, where a single predictor explaining most of the
variance in a complex attitude is unusual. The robustness check confirms this is not an
artifact of the six less-certain data points: restricting the sample to the 24 countries
with fully verified IDV scores still yields r=-0.83, p=5.2x10⁻⁷ -- a negligible change
from the full-sample result.

# Discussion

The strength of this correlation (R²=0.72) is worth treating with appropriate caution
precisely because it is so strong. Cross-national social-attitude research rarely finds a
single cultural variable explaining nearly three-quarters of the variance in a complex,
multiply-determined attitude like technology sentiment. Three considerations are worth
holding alongside the headline number.

First, individualism is very likely correlated with other national characteristics that
plausibly also shape AI sentiment -- GDP per capita, media environment, government AI
strategy and public messaging, and existing familiarity with AI tools through daily life.
This analysis tests a bivariate relationship; it does not control for these other factors,
and a genuinely rigorous causal claim would require doing so. The strength of the
correlation found here is consistent with individualism being a real contributing factor,
a proxy for several correlated factors, or some combination of both -- this analysis alone
cannot distinguish between these possibilities.

Second, the exclusion of China from this particular Ipsos wave is a meaningful gap. China
is frequently cited as the country with the single highest AI optimism (83% in a separate
Ipsos wave) and one of the most collectivist cultures in Hofstede's original framework
(IDV=20 in the source table used here). Its absence from this specific 30-country sample
does not undermine the finding, since the pattern holds clearly across the 30 countries
that are included, but a fully verified China data point would have strengthened the
sample's coverage at exactly the extreme end of both variables.

Third, as discussed in the Data and Limitations section, six of the thirty IDV scores
carry a disclosed data-quality caveat. The robustness check addressing this (Section 5)
found a negligible change when these six countries were excluded, which increases
confidence that the result is not being driven by potentially inconsistent data -- but it
does not eliminate the underlying uncertainty about those six countries' exact scores.

# Limitations and Future Work

1. **Multivariate modeling.** A regression including GDP per capita, government AI
   strategy indicators, and media environment measures alongside individualism would test
   whether the cultural-dimension effect survives controlling for these plausible
   confounds, rather than relying on a bivariate correlation alone.
2. **A fully single-sourced Hofstede dataset.** Obtaining all 30 countries' IDV scores
   directly from a single official source (rather than the current mix of one consistent
   table plus six supplementary lookups) would remove the remaining data-quality caveat
   entirely.
3. **Including China.** Locating a wave of the Ipsos AI Monitor (or a comparable survey)
   that includes both China and the other 30 countries in a single consistent
   administration would allow the extreme end of both variables to be tested directly
   within one dataset.
4. **Longitudinal tracking.** Since Ipsos fields this survey annually, tracking whether
   the individualism-sentiment relationship strengthens, weakens, or holds steady as AI
   becomes more familiar globally would be a natural extension.

# Conclusion

Hofstede's Individualism Index is a strong, statistically robust predictor of national AI
sentiment across the 30 countries surveyed by Ipsos in 2025, explaining approximately 72%
of the cross-country variance and surviving a robustness check against a known data-quality
limitation. This is consistent with -- though not sufficient on its own to prove -- the
cross-cultural psychology explanation that individualistic societies frame AI primarily as
a threat to personal autonomy, while collectivist societies more often frame it as a tool
that helps people function within their social environment. A genuinely causal claim would
require controlling for the economic and media-environment factors that plausibly
correlate with both individualism and AI sentiment.

# References {-}

Ipsos. (2025). *The Ipsos AI Monitor 2025: A 30-country Ipsos Global Advisor Survey*.
Retrieved from ipsos.com

Hofstede, G. (1997). *Cultures and Organizations: Software of the Mind*. McGraw-Hill.

Kelley, K. J., et al. (2021). Cross-cultural comparison of AI attitudes across 8 countries.
Referenced via secondary academic sources on individualism and AI sentiment.
