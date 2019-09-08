function [d_opt, err, confusion_mat] = Exercise2(d_max)
%EXERCISE2 Summary of this function goes here
%   Detailed explanation goes here
%% %% Training %% %%
%% load data
trainImg = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');
testImg = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
likelihood = zeros([size(test_labels,1),10]);
err = zeros(1,d_max);
prediction_all = zeros(size(test_labels,1),d_max);

%% substract mean of the images from training images
trainImg_mean = mean(trainImg,2);
trainImg_centered = trainImg - trainImg_mean;
testImg_centered = testImg - trainImg_mean;

%% apply pca
eig_vectors = train_pca(trainImg_centered);
for d=1:d_max
    basis = eig_vectors(:,1:d);
    trainImg_projected = basis.' * trainImg_centered;
    testImg_projected = basis.' * testImg_centered;
    for i = 0:9
        [mu,sigma] = compute_class_moment(trainImg_projected,train_labels,i);
        likelihood(:,i+1) = mvnpdf(testImg_projected.', mu, sigma);
    end
    
    %% Maximum likelihood classifier
    [~,prediction] = max(likelihood.');
    prediction = (prediction-1).';
    prediction_all(:,d) = prediction;
    err(d) = mean(prediction~=test_labels)*100;
end
%% 
[err_min,d_opt] = min(err);
prediction = prediction_all(:,d_opt);
confusion_mat = confusionmat(test_labels,prediction);

figure;
confusionchart(confusion_mat);

figure;
plot(1:d_max,err);
title('Classification Error Plot');
xlabel('number of principle components d');
ylabel('classification error (%)');

%fprintf('The classification error of 15 principal components is %.3f %%.\n', err(15));
fprintf('The optimized number of principal components is %d with classification error %.3f %%.\n', ...
        d_opt, err_min);
disp("The confusion matrix is:")
disp(confusion_mat)
helperDisplayConfusionMatrix(confusion_mat);
end



%% Function to compute eigen vectors
function eig_vectors = train_pca(img)
covariance = cov(img.');
[V, D] = eig(covariance);
[~,ind] = sort(diag(D),'descend');
eig_vectors = V(:,ind);
end

%% Function to compute mean and covariance for each class
function [mu,sigma] = compute_class_moment(img,label,i)
    index = find(label==i);
    img_class = img(:,index);
    mu = (mean(img_class,2))';
    sigma = cov(img_class.');
end