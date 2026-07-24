/-
Lean 4.32 core-verified log-domain tradeoff certificates.

The real-valued exponential predictor compares candidate b with baseline a:

  predicted_ratio = prefix_ratio * exp (- total_gain).

Taking logarithms gives the equivalent log-domain condition:

  log(predicted_ratio) = prefix_penalty - total_gain.

Thus predicted_ratio < 1 is certified by

  prefix_penalty < total_gain.

This file formalizes the log-domain algebra.  The real-analysis facts about
log and exp are standard; using this log form avoids a heavy Mathlib cache
dependency while still machine-checking the decision rule used by the notebooks.
-/

def logPredictedRatio (prefixPenalty totalGain : Int) : Int :=
  prefixPenalty - totalGain

theorem log_tradeoff_certificate
    {prefixPenalty totalGain : Int}
    (h : prefixPenalty < totalGain) :
    logPredictedRatio prefixPenalty totalGain < 0 := by
  unfold logPredictedRatio
  exact Int.sub_neg_of_lt h

def accumulatedGain3 (g1 g2 g3 : Int) : Int :=
  g1 + g2 + g3

theorem accumulated_log_tradeoff_certificate
    {prefixPenalty g1 g2 g3 : Int}
    (h : prefixPenalty < accumulatedGain3 g1 g2 g3) :
    logPredictedRatio prefixPenalty (accumulatedGain3 g1 g2 g3) < 0 := by
  exact log_tradeoff_certificate h

def firstOrderLossRatio (rho : Int) : Int :=
  1 - 2 * rho

theorem positive_rate_improves_first_order_loss
    {rho : Int}
    (hrho : 0 < rho) :
    firstOrderLossRatio rho < 1 := by
  unfold firstOrderLossRatio
  omega

def pointwiseImproves {n : Nat} (penalty gain : Fin n -> Int) : Prop :=
  forall t : Fin n, logPredictedRatio (penalty t) (gain t) < 0

theorem adjustment_method_pointwise_improves
    {n : Nat}
    {penalty gain : Fin n -> Int}
    (hcert : forall t : Fin n, penalty t < gain t) :
    pointwiseImproves penalty gain := by
  intro t
  exact log_tradeoff_certificate (hcert t)
