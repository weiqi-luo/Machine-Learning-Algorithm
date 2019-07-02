function [outputArg1,outputArg2] = Exercise3_kmeans(inputArg1,k)
%EXERCISE3_KMEANS Summary of this function goes here
%   Detailed explanation goes here
clc
clear
load ('gesture_dataset.mat')
 

end


function plot_clusters(k)
color = ['b','k','r','g','m','y','c'];
figure
hold on
for i = 1:k
    plot(gesture_l(:,i,1),gesture_l(:,i,2),'*',color(k));
end
hold off
end