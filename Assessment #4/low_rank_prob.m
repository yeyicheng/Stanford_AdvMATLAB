function [U, S, V] = low_rank_prob(A, p, q)
    [m, n] = size(A);
    omega = randn(n,p);
    Y = (A*A')^q*A*omega;
    [Q, R] = qr(Y,0);
    B = Q'*A;
    [U_tilde, S, V] = svd(B);
    U = Q * U_tilde;
end