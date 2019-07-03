function Exercise3_kmeans(gesture_l, gesture_o, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x, k)
%EXERCISE3_KMEANS Summary of this function goes here
%   Detailed explanation goes here
% [dataset_all,cluster_init_all] = load_data();
dateset_cell = {gesture_l, gesture_o, gesture_x};
cluster_cell = {init_cluster_l, init_cluster_o, init_cluster_x};
for i = 1:length(dateset_cell)
clusters = cluster_cell{i};
dataset = dateset_cell{i};
threshold = 1e-6;
kmeans_clustering(dataset, clusters, k, threshold);
end
end


%% 
function kmeans_clustering(dataset, clusters, k, threshold)
dataset = reshape(dataset,[size(dataset,1)*size(dataset,2), size(dataset,3)]);
distortion = inf;
delta_distortion = inf;
[~,prediction] = E_step(k,clusters,dataset);
while delta_distortion >= threshold
    clusters = M_step(k,prediction,dataset);
    [square_err, prediction] = E_step(k,clusters,dataset);
    distortion_old = distortion;
    distortion = sum(square_err); 
    delta_distortion = abs(distortion_old - distortion);
end
plot_clusters(k, prediction, dataset);
end


%%
function [square_err, prediction] = E_step(k,clusters,dataset)
distance = zeros(size(dataset,1),k);
for j=1:k
    cluster = clusters(j,:);
    clusters_replica = repmat(cluster,size(dataset,1),1);
    distance(:,j) = sum((clusters_replica-dataset).^2,2).^0.5;
end
[square_err, prediction] = min(distance,[],2);
square_err = square_err.^2;
end


%% 
function clusters = M_step(k,prediction,dataset)
clusters = zeros(size(prediction,1),size(dataset,2));
for j=1:k
    index_cluster = find(prediction==j);
    dataset_cluster = dataset(index_cluster,:);
    clusters(j,:) = mean(dataset_cluster);
end
end


%%
function plot_clusters(k, prediction, dataset)
color = ['b','k','r','g','m','y','c'];
figure
hold on
for j=1:k
    index_cluster = find(prediction==j);
    dataset_cluster = dataset(index_cluster,:);
    scatter(dataset_cluster(:,1),dataset_cluster(:,2),strcat(color(j),'*'));
end
title('kmeans clustering');
hold off
end

