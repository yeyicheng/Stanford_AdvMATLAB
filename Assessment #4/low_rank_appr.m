function [A_k] = low_rank_appr(A, k)
    [U,S,V] = svd(A);
    A_k = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
end