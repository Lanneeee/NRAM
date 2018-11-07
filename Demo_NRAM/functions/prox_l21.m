function [E] = prox_l21(X,beta)
 A = sqrt(sum(X.^2,1));
 A(A==0) = beta;
 B = (A-beta)./A;
 E = X*diag((A>beta).*B); 