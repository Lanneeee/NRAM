function [S]= prox_weighted_l1(Y1,X,W,E,lambda,mu)

[m,n] = size(X);

% update weight
C = sqrt(min(m,n))/2.5;
tempT = X - W - E -(1 / mu) * Y1;
Wt = (C)./(abs(tempT)+0.04);

S = max(tempT - lambda*Wt / mu, 0);
S = S + min((tempT + lambda*Wt), 0);
