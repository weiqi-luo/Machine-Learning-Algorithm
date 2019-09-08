function [par] = Exercise1(k)
%EXCERCISE1 Summary of this function goes here
%   Detailed explanation goes here
%% load data and initialization
max_order = 6;
load('Data.mat')
Input = Input.';
Output = Output.';
err_position_order = zeros(1,max_order);
err_orientation_order = zeros(1,max_order);
%% loop over order
for j = 1:max_order
err_position_fold = zeros(1,k);
err_orientation_fold = zeros(1,k);
%% loop over folds
    for i = 1:k
        %% Split the dataset
        [input_test,output_test,input_train,output_train] = split_dataset(Input,Output,k,i);
        %% Linear regression with training set
        W = linear_regression(input_train,output_train,j,j);
        %% Compute the error with test set 
        [err_position_fold(i), err_orientation_fold(i)] = compute_error(input_test,output_test,W,j);
    end
    %% compute the average error
    err_position_order(j) = mean(err_position_fold);
    err_orientation_order(j) = mean(err_orientation_fold);
end
%% select p1 and p2 which minimize the position error and orientation error respectively
[~,p1] = min(err_position_order);
[~,p2] = min(err_orientation_order);
%% Linear regression with whole dataset
par = linear_regression(Input,Output,p1,p2);
save('params','par')

Simulate_robot(0,0.05)
Simulate_robot(1,0)
Simulate_robot(1,0.05)
Simulate_robot(-1,-0.05)

fprintf('For k= %d the optimal values p1 = %d and p2 = %d.\n', ...
        k, p1, p2);
disp("The learned parameter is:")
disp(par{1})
disp(par{2})
disp(par{3})
end

%% function split_dataset
function [input_test,output_test,input_train,output_train] = split_dataset(Input,Output,k,i)
n_total = size(Input,1);
index = boolean(zeros(1,n_total));
index( (1+(i-1)*n_total/k) : (i*n_total/k) ) = 1;
input_test = Input(index,:);
output_test = Output(index,:);
index = ~index;
input_train = Input(index,:);
output_train = Output(index,:);
end

%% function transform_input
function [Z] = transform_input(X,j)
n = size(X,1);
X = [X, X(:,1).*X(:,2)];
Z = ones(n,1+3*j);
for k = 1:j
    Z(:,(k-1)*3+2:k*3+1) = X.^k;
end
end 

%% function linear_regression
function [W] = linear_regression(X,Y,p1,p2)
if p1==p2
    Z = transform_input(X,p1);
    W = inv(Z.'*Z)*(Z.')*Y;
else
    Z1 = transform_input(X,p1);
    Z2 = transform_input(X,p2);
    W1 = inv(Z1.'*Z1)*(Z1.')*Y(:,1);
    W2 = inv(Z1.'*Z1)*(Z1.')*Y(:,2);
    W3 = inv(Z2.'*Z2)*(Z2.')*Y(:,3);
    W = {W1,W2,W3};
end
end

%% function compute_error
function [r1,r2] = compute_error(X,Y,W,j)
Z = transform_input(X,j);
Y_ = Z*W - Y;
r1 = mean((Y_(:,1).^2 + Y_(:,2).^2).^0.5);
r2 = mean(Y_(:,3).^2.^0.5);
end

