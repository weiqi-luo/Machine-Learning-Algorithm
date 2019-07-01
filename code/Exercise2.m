function [err_classification, mat_confusion] = Exercise2(d_max)
%EXERCISE2 Summary of this function goes here
%   Detailed explanation goes here
%% %% Training %% %%
%% load data
trainImg = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');
%% substract mean of the images from all images
trainImg_centered = center_image(trainImg);
%% apply pca
eig_vectors = train_pca(trainImg_centered);
for d=1:d_max
    trainImg_projected = project_image(trainImg_centered, eig_vectors(:,1:d));
    
%%  

%% %% Testing %% %%
%% load data
testImg = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
%% substract mean of the images from all images
testImg_centered = center_image(test_images);
%% 
end
end


%%
function img_centered = center_image(img)
img_centered = img-mean(img,2);
end

%%
function eig_vectors = train_pca(img)
mat_covariance = cov(img.');
[V, D] = eig(mat_covariance);
[~,ind] = sort(diag(D),'descend');
eig_vectors = V(:,ind);
end

%% 
function img_projected = project_image(img,basis)
img_projected = basis.' * img;
end