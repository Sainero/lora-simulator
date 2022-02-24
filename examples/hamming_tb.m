clear; close all;

%%%%%%%%%%%%%%% CR = 3 %%%%%%%%%%%%%%%%%%%%%%%%

% %precompute syndrome decoding table
% CR=3;
% n=4+CR;
% k=4;
% Q=[1 1 1;1 1 0; 1 0 1;0 1 1];
% G=[eye(k) Q];
% 
% H=[Q.' eye(n-k)];
% 
% % generate lookup table
% 
% E=[zeros(1,n-k+4); eye(n-k+4)];
% S=E*H.';
% 
% % test
% m=[0 1 0 0];
% c=m*G
% 
% err=[0 0 0 0 0 0 1];
% 
% rc=xor(c,err)
% synd=mod(rc*H.',2);
% for i=1:size(S,1)
%     if S(i,:)==synd
%         l=i;
%         c_hat=xor(rc,E(l,:))
%     end
% end

%%%%%%%%%%%%%%% CR = 4 %%%%%%%%%%%%%%%%%%%%%%%%

% CR=4;
% n=4+CR;
% k=4;
% Q=[0 1 1 1;1 1 0 1;1 1 1 0;1 0 1 1];
% G=[eye(k) Q];
% 
% H=[Q.' eye(n-k)];
% 
% % generate lookup table
% 
% E=[zeros(1,n-k+4); eye(n-k+4)];
% S=E*H.';
% 
% % test
% m=[0 1 0 0];
% c=m*G
% 
% err=[0 0 0 0 0 0 0 0];
% 
% rc=xor(c,err)
% 
% synd=mod(rc*H.',2)
% 
% 
% if synd==[0 0 0 0]
%     disp(["no errors"]);
% else
%     parity=xor(xor(xor(xor(xor(xor(xor(rc(1),rc(2)),rc(3)),rc(4)),rc(5)),rc(6)),rc(7)),rc(8));
%     if parity==1
%         disp(["1 erreur corrigeable -> envoi de rc(:,1:7) vers decodeur 7,3"]);
%     else
%         disp(["2 erreurs !"]);
%     end
% end

%%%%%%%%%%%%%%% CR = 2 %%%%%%%%%%%%%%%%%%%%%%%%

CR=4;
n=4+CR;
k=4;
Q=[0 1 1 1;1 1 0 1;1 1 1 0;1 0 1 1];
G=[eye(k) Q];

H=[Q.' eye(n-k)];
H=[0 1;1 1;1 1;1 0;0 1;1 0].'
%generate lookup table
n=6;
k=4;
E=[zeros(1,n-k+4); eye(n-k+4)];
S=E*H.';

% test
m=[0 1 0 0];
prod=m*G;
c=prod(:,1:6)

err=[0 0 0 0 0 0];

rc=xor(c,err)

synd=mod(rc*H.',2)
% sum(synd)
