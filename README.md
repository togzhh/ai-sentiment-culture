# Does National Individualism Predict AI Sentiment?

## Motivation

Global surveys consistently show a striking pattern: countries like Indonesia (85%) and
Thailand (78%) see AI as overwhelmingly more beneficial than harmful, while countries like
Canada (40%) and the United States (42%) are far more skeptical. This project tests one of
the leading explanations for this divide from cross-cultural psychology: **does a country's
position on individualism vs. collectivism (Hofstede's Individualism Index) statistically
predict its AI optimism?**

## Research Question

Does Hofstede's Individualism Index (IDV) correlate with the percentage of a country's
population who see AI as more beneficial than harmful, across a broad, real, current
sample of countries?

## Data

- **AI sentiment**: Ipsos AI Monitor 2025, a 30-country Global Advisor survey (n=23,216
  adults, fielded March 21 - April 4, 2025), specifically the "AI products and services
  have more benefits than drawbacks" item.
- **Cultural dimension**: Hofstede's Individualism Index (IDV), 0-100 scale, higher =
  more individualistic.
- **Merged sample**: 30 countries (all Ipsos countries had an available IDV score).

### Known limitations

- **This wave of Ipsos AI Monitor does not include China.** The often-cited "China 83%"
  figure comes from a different Ipsos wave (the one cited in Stanford's AI Index 2025),
  not this one -- country coverage shifts between Ipsos survey waves, so a single-wave
  panel spanning multiple years isn't available from this source alone.
- **Several countries in the Ipsos survey have samples skewed toward urban, educated, or
  affluent populations** relative to their general population (disclosed in Ipsos's own
  methodology) -- their results should be read as reflecting a more "connected" segment
  of the population, not the full country.
- **Correlational, not causal.** This tests whether individualism predicts sentiment; it
  cannot establish that cultural values *cause* the sentiment gap, as opposed to both being
  driven by some other shared factor (e.g., economic outlook, media environment,
  government AI strategy).

## Methodology

1. **Clean & merge** (`analysis.R`, Part 1): join the two datasets on country name,
   flag which rows rely on a classic IDV score confirmed against a single consistent
   source. Restrict the primary analysis dataset to those 24 countries.
2. **Test** (Part 2): Pearson and Spearman correlation between IDV and AI sentiment on the
   primary (n=24) dataset, and a simple linear model. The result of including the 6
   excluded countries is also printed to `stats_results.txt`, labeled explicitly as
   not a reported finding, to document that it does not change the qualitative
   conclusion.

## Results

**Primary analysis: n = 24 countries** (classic Hofstede IDV confirmed against a single
consistent source).

| Test | Result |
|---|---|
| Pearson correlation | r = -0.83, p = 5.2x10⁻⁷ |
| Spearman correlation | rho = -0.82, p = 9.3x10⁻⁷ |
| Linear model R² | 0.69 |

**Individualism explains roughly 69% of the cross-country variation in AI sentiment**
among the 24 countries with a verified classic IDV score -- a strong, statistically
robust relationship. More individualistic countries are significantly less likely to see
AI as beneficial; more collectivist countries are significantly more optimistic. This is
consistent with the explanation from cross-cultural psychology that individualistic
cultures tend to frame new technology as a potential threat to personal autonomy, while
collectivist cultures more often frame it as a tool that helps people function within
their social environment.
