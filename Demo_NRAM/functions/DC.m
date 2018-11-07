function [ X,T ] = DC(D,rho,T0,epislon)
% This Matlab code implements the DC programming
[U,S,V] = svd(D,'econ');
maxIter = 100;
for t = 1:maxIter   
    lambda = 1/rho;
    S0 = diag(S);
    grad = (1 + epislon)*epislon./(epislon + T0).^2;
    T1 = max(S0-lambda*grad,0);
    X = U*diag(T1)*V';
    error = sum((T1-T0).^2);
    if error < 1e-6
       break
    end
    T0 = T1;
end
T = T1;
end