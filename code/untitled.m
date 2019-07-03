function Exercise3_kmeans(gesture_l, gesture_o, gesture_x, k)
%EXERCISE3_KMEANS Summary of this function goes here
%   Detailed explanation goes here
% [dataset_all,cluster_init_all] = load_data();
dateset_cell = {gesture_l, gesture_o, gesture_x};
split_vector = [0.08, 0.05, 0.02];
for i = 1:length(dateset_cell)
dataset = dateset_cell{i};
nubs_clustering(dataset, k, split_vector);
end
end


%%
function nubs_clustering(dataset, k, split_vector)
dataset = reshape(dataset, [size(dataset,1)*size(dataset,2), size(dataset,3)]);
prediction = ones(size(dataset,1),1);
clusters = zeros(k,size(dataset,2));
distortions = zeros(k,1);

clusters(1,:) = mean(dataset);
distortions(1) = compute_distortion(clusters,1);
for i=2:k
[~, index_bad] = max(distortions);
[clusters(index_bad,:),clusters(i,:)] = split_bad_cluster...
    (clusters(index_bad,:), dataset(prediction==index_bad), split_vector);


[cluster_bad, data_bad, index_bad, prediction] = compute_distortion(clusters,dataset,i);
clusters_new = compute_new_clusters(cluster_bad, data_bad, split_vector, index_bad, prediction);
clusters = [clusters_good; clusters_new];
distortions = compute_distortion(clusters,i);
end
plot_clusters(k, prediction, dataset)
end


%% 
function distortion = compute_distortion(clusters,i)
distortion = zeros(size(clusters,1),1);
for j=1:i
    cluster = clusters(j,:);
    clusters_replica = repmat(cluster,size(dataset,1),1);
    distortion(:,j) = sum((clusters_replica-dataset).^2,2);
end
end


%% 
function [clusters_new1,clusters_new2] = split_bad_cluster(cluster_bad, data_bad, split_vector)
clusters_temp = [cluster_bad + split_vector; cluster_bad - split_vector];
[~,~,~, prediction] = compute_distortion(clusters_temp,data_bad,2);
clusters_new1 = mean(data_bad(prediction==1,:)); 
clusters_new2 = mean(data_bad(prediction==2,:));
end



%%
function nubs_clustering_(dataset, k, split_vector)
dataset = reshape(dataset, [size(dataset,1)*size(dataset,2), size(dataset,3)]);
clusters = mean(dataset);
prediction = zeros(1,size(dataset,1));
for i=1:k
[cluster_bad, data_bad, index_bad, prediction] = compute_distortion(clusters,dataset,i);
clusters_new = compute_new_clusters(cluster_bad, data_bad, split_vector, index_bad, prediction);
clusters = [clusters_good; clusters_new];
end
plot_clusters(k, prediction, dataset)
end


%%
function [cluster_bad, data_bad, index_bad, prediction] = compute_distortion_(clusters,dataset,i)
square_err = zeros(size(dataset,1),i);
distortions = zeros(1,i);
for j=1:i
    cluster = clusters(j,:);
    clusters_replica = repmat(cluster,size(dataset,1),1);
    square_err(:,j) = sum((clusters_replica-dataset).^2,2);
end
[square_err_min, prediction] = min(square_err,[],2);

for j=1:i
    distortions(j) = sum(square_err_min(prediction==j));
end

[~, index_bad] = max(distortions);
cluster_bad = clusters(index_bad,:);
data_bad = dataset(prediction==index_bad,:);
end


%% 
function clusters_new_ = compute_new_clusters(cluster_bad, data_bad, split_vector)
clusters_temp = [cluster_bad + split_vector; cluster_bad - split_vector];
[~,~,~, prediction] = compute_distortion(clusters_temp,data_bad,2);
clusters_new1 = mean(data_bad(prediction==1,:)); 
clusters_new2 = mean(data_bad(prediction==2,:));

clusters_new = [clusters_new1;clusters_new2];
end


%%
function plot_clusters(k, prediction, dataset)
color = ['b','k','r','g','m','y','c'];
figure
hold on
for j=1:k
    dataset_cluster = dataset(prediction==j,:);
    scatter(dataset_cluster(:,1),dataset_cluster(:,2),strcat(color(j),'*'));
end
title('nubs clustering');
hold off
end