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
index_bad = 1;
for i=2:k
[clusters_new, prediction_new, distortions_new] = ...
    split_bad_cluster(clusters(index_bad,:), dataset(prediction==index_bad), split_vector);

clusters([index_bad,i],:) = clusters_new;
prediction(index_bad) = prediction_new;
distortions([index_bad,i]) = distortions_new;

[~,index_bad] = max(distortions);
end
end


%% 
function [clusters_new, prediction_new, distortions_new] = split_bad_cluster(cluster_bad, data_bad, split_vector)
clusters_temp = [cluster_bad + split_vector; cluster_bad - split_vector];
[distortions_new,prediction_new] = compute_distortion(clusters_temp,data_bad);
clusters_new1 = mean(data_bad(prediction_new==1,:)); 
clusters_new2 = mean(data_bad(prediction_new==2,:));
clusters_new = [clusters_new1;clusters_new2];
end


%% 
function [distortions,prediction] = compute_distortion(clusters, dataset)
square_err = zeros(size(dataset,1),2);
distortions = zeros(2,1);
for j=1:2
    cluster = clusters(j,:);
    clusters_replica = repmat(cluster,size(dataset,1),1);
    square_err(:,j) = sum((clusters_replica-dataset).^2,2);
end
[square_err_min, prediction] = min(square_err,[],2);

for j=1:2
    distortions(j) = sum(square_err_min(prediction==j));
end
end


