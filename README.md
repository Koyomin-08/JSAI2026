# JSAI2026
臨床研究領域の観察データ解析における二重にロバストな推定法の効用
観察データに基づく因果効果推定では、処置割付の偏りを補正するために、傾向スコアモデルと結果変数モデルの双方を組み合わせた二重にロバストな推定法（Doubly Robust Estimation）がしばしば用いられる。本研究では、バックドア基準を満たす交絡変数の一部が観察できない状況、ならびに生理学的・生化学的機序に由来する非線形反応が存在する状況に着目し、これらの条件下で因果推定手法を適用する際の特性をシミュレーションにより検討した。因果構造として、線形または非線形の反応関数を仮定し、観測変数が結果変数および処置変数に直接影響するシナリオと、潜在変数が結果変数に直接影響し、観測変数を介して処置変数に影響するシナリオを設定した。解析では、潜在変数は観測不可能であると仮定しモデルを構築した。その結果、変数同士が非線形関係にある場合、結果変数モデルおよび傾向スコアモデルの双方にバイアスが生じる一方、二重にロバストな推定ではバイアスが抑制されることが示唆された。

Utility of Doubly Robust Estimation in Observational Data Analysis for Clinical Research

In observational causal inference, doubly robust estimation combines propensity score and outcome regression models to mitigate treatment assignment bias. This study examines settings in which confounders satisfying the backdoor criterion are not fully observable and in which nonlinear physiological or biochemical responses are present. Through simulation studies, we evaluated the performance of causal inference methods under these conditions. The data-generating process assumed linear or nonlinear response functions and incorporated two causal scenarios: one in which observed variables directly affect both the outcome and treatment, and another in which latent variables directly affect the outcome and influence treatment through observed variables. In the analysis, latent variables were assumed to be unobservable, and models were constructed using only observed variables. The results show that under nonlinear relationships, outcome regression and propensity score models can be biased, whereas doubly robust estimation may attenuate such bias under certain conditions.

Simulation study for causal inference estimators under multiple data generating processes (DGPs).

This repository contains:

- Data generating processes (DGPs)
- Doubly robust estimation procedures
- TMLE / IPTW / outcome regression comparisons

---

# Data Generating Processes (DGP)

Each scenario defines:

- covariates
- treatment assignment mechanism
- outcome generation mechanism
- latent confounding structure

The following notation is used throughout the simulations.

| Symbol | Description |
|---|---|
| $X$ | Observed covariates |
| $L$ | Latent variables |
| $T$ | Treatment indicator |
| $Y$ | Outcome |
| $e(X)$ | Propensity score |
| $ \mu_t(X)$ | Outcome regression model |

---

# Doubly Robust Estimator

The doubly robust (DR) estimator combines:

- outcome regression
- inverse probability weighting (IPW)

The estimator remains consistent if either:

- the propensity score model is correctly specified, or
- the outcome regression model is correctly specified.

---

## DR Estimating Equation

```math
\hat\tau_{\mathrm{DR}}
=
\frac1n \sum_{i=1}^n
\left[
\hat\mu_1(X_i)-\hat\mu_0(X_i)
+
\frac{T_i(Y_i-\hat\mu_1(X_i))}{\hat e(X_i)}
-
\frac{(1-T_i)(Y_i-\hat\mu_0(X_i))}{1-\hat e(X_i)}
\right]
```

where:

| Term | Meaning |
|---|---|
| $\hat e(X_i)$ | Estimated propensity score |
| $\hat\mu_1(X_i)$ | Predicted outcome under treatment |
| $\hat\mu_0(X_i)$ | Predicted outcome under control |

---

# Interpretation

The DR estimator consists of:

1. Outcome regression component
2. Bias correction component using IPW

The augmentation term corrects residual bias from the outcome model using propensity weighting.

This estimator is called "doubly robust" because consistency is preserved when either nuisance model is correctly specified.

---

# Methods Compared

The simulations compare:

- Outcome regression
- IPTW
- Augmented IPTW (AIPW)
- TMLE
- Nonlinear least squares approaches

---

# Objective

The purpose of this study is to evaluate:

- bias
- variance
- robustness to model misspecification
- behavior under latent confounding

across multiple causal inference estimators.
