load ('gesture_dataset.mat');
size_temp = [size(gesture_l,1)*size(gesture_l,2), size(gesture_l,3)];
dataset_all = zeros([size_temp, 3]);
dataset_all(:,:,1) = reshape(gesture_l,size_temp);
dataset_all(:,:,2) = reshape(gesture_o,size_temp);
dataset_all(:,:,3) = reshape(gesture_x,size_temp);
cluster_init_all = zeros([size(init_cluster_l),3]);
cluster_init_all(:,:,1) = init_cluster_l;
cluster_init_all(:,:,2) = init_cluster_o;
cluster_init_all(:,:,3) = init_cluster_x;
for i = 1:3
clusters = cluster_init_all(:,:,i);
dataset = dataset_all(:,:,i);
Exercise3_kmeans(dataset, clusters, k);
end