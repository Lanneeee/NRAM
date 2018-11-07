function [L, S] = nram(X,lambda)
[m,n] = size(X);

muzero = 3*sqrt(max(m,n));   % initial mu
rate = 1.1;                  % update rate of mu
gamma = 2*1e-3;              % gamma parameter in the rank approximation 
tol = 1e-7;                  % stopping criterion
beta = 3/sqrt(min(m,n));
maxIter = 1000;


%% Initialization
[m,n] = size(X);
S = zeros(m,n);
Y = zeros(m,n);
E = zeros(m,n);
L = zeros(m,n);
sig = zeros(min(m,n),1); % for DC 
mu = muzero;

%% Solving the proposed NRAM model
for ii=1:maxIter   
    
    % update low-rank component L
    [ L,sig] = DC(X-S-E-Y/mu,mu,sig,gamma);
    
    % update sparse component S
    S = prox_weighted_l1(Y,X,L,E,lambda,mu);
    
    % update strong edge component E
    E = prox_l21(X-S-L-Y/mu,beta/mu);
    
    % update multiplier Y
    Y=Y+mu*(L+E-X+S);
    
    % update mu
    mu=mu*rate;   
    
    % calculate relative error
    sigma = norm(X-S-L-E,'fro');
    RE = sigma/norm(X,'fro');
    if mod( ii, 10) == 0
                disp(['#svd ' num2str(ii) ' r(A) ' num2str(rank(L))...
            ' |E|_0 ' num2str(length(find(abs(S)>0)))...
            ' stopC ' num2str(RE)]);
    end

    if RE<tol 
        break
    end
    
end
% L and E both belong to the background.
L = L + E;
end