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
- **Hofstede IDV source consistency**: 24 of the 30 countries' IDV scores come from a
  single, internally consistent peer-reviewed table. The remaining 6 (Thailand, Singapore,
  Ireland, Sweden, Hungary, Spain) are drawn from supplementary sources and could not be
  confirmed against that same single source -- Hofstede's scores have been revised over
  time (the official site's IDV/LTO dimensions were last updated October 2023), so mixing
  vintages across countries is a real, disclosed risk. `analysis.R` flags these 6 rows
  explicitly and re-runs the correlation excluding them as a robustness check.
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
   flag which rows rely on the less-certain supplementary Hofstede source.
2. **Test** (Part 2): Pearson and Spearman correlation between IDV and AI sentiment,
   a simple linear model, and a robustness check re-running the correlation using only
   the 24 countries with verified-consistent IDV data.

## Results

**n = 30 countries.**

| Test | Result |
|---|---|
| Pearson correlation | r = -0.85, p = 2.8x10⁻⁹ |
| Spearman correlation | rho = -0.85, p = 1.8x10⁻⁹ |
| Linear model R² | 0.72 |
| Robustness check (24 verified-source countries only) | r = -0.83, p = 5.2x10⁻⁷ |

**Individualism explains roughly 72% of the cross-country variation in AI sentiment** --
a strong, statistically robust relationship that holds even after excluding the 6
countries with less-certain cultural-dimension data. More individualistic countries are
significantly less likely to see AI as beneficial; more collectivist countries are
significantly more optimistic. This is consistent with the explanation from cross-cultural
psychology that individualistic cultures tend to frame new technology as a potential threat
to personal autonomy, while collectivist cultures more often frame it as a tool that helps
people function within their social environment.

## Report

- **[`report/AI_Sentiment_Culture_Report.pdf`](report/AI_Sentiment_Culture_Report.pdf)**
- **[`report/Executive_Summary.pdf`](report/Executive_Summary.pdf)**

## Repository Structure

```
├── data/
│   ├── raw/                              # Ipsos sentiment + Hofstede IDV source files
│   └── processed/                        # merged analysis dataset
├── figures/                              # scatter plot with country labels
├── report/
│   ├── stats_results.txt
│   ├── full_report.md
│   ├── AI_Sentiment_Culture_Report.pdf
│   ├── executive_summary.md
│   └── Executive_Summary.pdf
├── analysis.R
├── ai-sentiment-culture.Rproj
├── README.md
└── LICENSE
```


