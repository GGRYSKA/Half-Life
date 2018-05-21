# Half-Life

This script is designed to provide the time it will take for the named markets to close half the distance to their mean as defined by the date range in the script.

The simple Ornstein-Uhlenbeck mean reverting process given by the stochastic differential equation (SDE). You can read more about it on Wikipedia if you would like.

dx(t)=θ(μ−x(t))dt+σdB(t),

x(0)=x0

for constants μ, θ, σ and x and where B(t) is standard Brownian motion. In this model the process x(t) fluctuates randomly, but tends to revert to some fundamental level μ. The behavior of this 'reversion' depends on both the short term standard deviation σand the speed of reversion parameter θ.

In the script, you can find date fields which you can adjust for your own preferences.
