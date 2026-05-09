# =========================
# シナリオ3 : DGP
# =========================
# サンプルサイズ
N <- 100
# 再現性
set.seed(0)

# -------------------------
# 誤差項
# -------------------------
e1 <- rnorm(N, sd = 0.5)
e2 <- rnorm(N, sd = 0.5)
e3 <- rnorm(N, sd = 0.5)
e4 <- rnorm(N, sd = 0.5)

# -------------------------
# 係数
# -------------------------
coef_L1X1 <- 1
coef_L2X2 <- 1

coef_X1T <- 1
coef_X2T <- 1

coef_L1Y <- 1
coef_L2Y <- 1

# 真の処置効果
effect <- 1

# -------------------------
# 潜在変数
# -------------------------
L1 <- rnorm(N)
L2 <- rnorm(N)

# -------------------------
# 観測変数（非線形変換前）
# -------------------------
X1_proxy <- coef_L1X1 * L1 + e1
X2_proxy <- coef_L2X2 * L2 + e2

# -------------------------
# 観測変数（シグモイド変換）
# -------------------------
paramX1_max   <- max(X1_proxy)
paramX1_min   <- min(X1_proxy)

paramX2_max   <- max(X2_proxy)
paramX2_min   <- min(X2_proxy)

paramX1_slope <- 0.8   # 【急さ】 正の値。大きいほど急カーブ、小さいほど緩やか
paramX2_slope <- 0.8

paramX1_mid   <- 0  # 【中心】 S字が反転するXの位置
paramX2_mid   <- 0

X1 <- paramX1_min +
  (paramX1_max - paramX1_min) /
  (1 + exp(-paramX1_slope * (X1_proxy - paramX1_mid)))

X2 <- paramX2_min +
  (paramX2_max - paramX2_min) /
  (1 + exp(-paramX2_slope * (X2_proxy - paramX2_mid)))

# -------------------------
# 処置変数
# -------------------------
linpred_T <- coef_X1T * X1 + coef_X2T * X2 + e3
p_T <- plogis(linpred_T)
T <- rbinom(N, 1, p_T)

# -------------------------
# 潜在アウトカム（非線形変換前）
# -------------------------
Y0_proxy <- coef_L1Y * L1 + coef_L2Y * L2 + e4
Y1_proxy <- coef_L1Y * L1 + coef_L2Y * L2 + e4

# -------------------------
# アウトカム（シグモイド変換）
# -------------------------
paramY_max   <- max(Y0_proxy, Y1_proxy)
paramY_min   <- min(Y0_proxy, Y1_proxy)

paramY_slope <- 0.8
paramY_mid   <- 0

Y0 <- paramY_min +
  (paramY_max - paramY_min) /
  (1 + exp(-paramY_slope * (Y0_proxy - paramY_mid)))

Y1 <- paramY_min +
  (paramY_max - paramY_min) /
  (1 + exp(-paramY_slope * (Y1_proxy - paramY_mid))) +
  effect

# -------------------------
# 実現アウトカム
# -------------------------
Y <- ifelse(T == 1, Y1, Y0)

# データフレーム
df3 <- data.frame(L1, L2, X1, X2, T, Y0, Y1, Y)
