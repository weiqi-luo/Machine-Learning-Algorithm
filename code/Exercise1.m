function [par] = Exercise1(k)
%EXCERCISE1 Summary of this function goes here
%   Detailed explanation goes here
load('Data.mat')
for j = 1:6
    for i = 1:k
        %% Split the dataset
        n = size(Input,2)
        index = boolean(zeros(1,n))
        index( (1+(i-1)*n/k) : (i*n/k) ) = 1
        input_test = Input(:,index)
        output_test = Output(:,index)
        index = ~index
        input_train = Input(:,index)
        output_train = Output(:,index)
        %% Linear regression
        %% Compute the error
    end
    %% compute the average error
end
%% select p1 and p2 which minimize the position error and orientation error respectively
%% Linear regression 
end


