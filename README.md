# JSAI2026

各シナリオのデータ生成過程

## Doubly Robust Estimator

The augmented inverse probability weighted (AIPW) estimator is defined as

$$
\hat{\tau}_{\mathrm{AIPW}}
=
\frac{1}{n}
\sum_{i=1}^{n}
\left[
\left(
\frac{T_i Y_i}{\hat e(X_i)}
-
\frac{(1-T_i)Y_i}{1-\hat e(X_i)}
\right)
-
\left(
\frac{T_i-\hat e(X_i)}{\hat e(X_i)(1-\hat e(X_i))}
\right)
\left\{
(1-\hat e(X_i))\hat\mu_1(X_i)
+
\hat e(X_i)\hat\mu_0(X_i)
\right\}
\right]
$$
