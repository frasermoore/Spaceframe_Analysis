clear all
clc
addpath('..');

size = 1044;

% A = [1000	-1 0  3  0;
%      -1	1100 -1 3  5;
%      2	-1 0  1  0;
%      0	3  -1 800  2;
%      2  3  6  50 2400]
% 
% B = [6;
%     25;
%     -11;
%     15;
%     1]


%A = [9 2 1; 1 -2 -3; -1 1 2]
A = zeros(size);
 for i= 1:size
     for j = 1:size
         A(i,j) = rand;
     end
     
 end
 
 for l = 1:size
     A(l,l) = A(l,l)*100000000000;
 end
 
 B = zeros(size,1);
 for k = 1:size
     B(k,1)= rand;
 end
A
%B
%A= magic(50);
%B = [-8; 0; 3]
%B = transpose([1:50])

C = zeros(size,1);

Sven = GaussSeidel(A,B, 0.00000001, C)