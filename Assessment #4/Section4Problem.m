% Load image
A = get_rgb('palm.png');
[m, n] = size(A);

% Task 1
ranks = [5,10,15,20,25,50,100,200,min(3*m,n)];
% Use different values for i.
i = 1;
k = ranks(i); 
A_k = low_rank_appr(A,k); 

% Task 2
ranks = [5,10,15,20,25,50];
q = [1,5,10];
% use differenet values for i.
i = 1; k = ranks(i);
% use different values for j.
j = 1; q = q(j);
A_k = low_rank_prob(A, k, q); 

% Task 3
singular = svd(A);
k = 1;
v = 1 - sum(singular(1:k).^2)/sum(singular(1:min(3*m,n)).^2);

% Task 4
max_k = 50;
q = 1;
[U,S,V] = low_rank_prob(A,max_k,q);
singular = diag(S);
k = 1;
v = 1 - sum(singular(1:k).^2)/sum(singular(1:max_k).^2);
