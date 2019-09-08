function Exercise1()
% close all
data = load('dataGMM.mat');
data = data.Data';
threshold = 1e-30;
num_GMM = 4;
num_data = size(data,1);
prior = ones(num_GMM,1)/num_GMM;
Responsibility = zeros(num_data,num_GMM);
Sigma = zeros(2*num_GMM,2);
likelihood_old = 0;
count = 0;
%% K-mean
[idx,Mu] = kmeans(data,num_GMM);
figure;
hold on
for i = 1:num_GMM
    plot(data(idx==i,1),data(idx==i,2),'.','MarkerSize',12)
end
plot(Mu(:,1),Mu(:,2),'kx','MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','NW')
hold off

%% initialize GMM 
for i = 1:num_GMM
    Sigma( (i-1)*2+1:i*2 , : ) = cov(data(idx==i,:));
end
figure
error_ellipse(Mu,Sigma,num_GMM,data)

while true
    count = 1+count;
    %% E-step and evaluation
    for i = 1:num_GMM
        mu = Mu(i,:);
        sigma = Sigma((i-1)*2+1:i*2,:);     
        Responsibility(:,i) = prior(i) * mvnpdf(data,mu,sigma);
    end

    likelihood = sum(log(sum(Responsibility,2)));
    delta = abs(likelihood-likelihood_old);
    if  delta < threshold
        break
    end
    likelihood_old = likelihood;
    
    Responsibility = Responsibility ./ sum(Responsibility,2);

    %% M-step
    normalization = (sum(Responsibility,1))';
    Mu = Responsibility'*data./normalization;
    for i = 1:num_GMM
        data_centered = data-Mu(i,:);
        Sigma((i-1)*2+1:i*2,:) = (data_centered.*Responsibility(:,i))' * data_centered / normalization(i);
    end
    prior = normalization/sum(normalization);    
end

%% visualization
error_ellipse(Mu,Sigma,num_GMM,data)
[X,Y] = meshgrid(-0.1:0.2/100:0.1,-0.1:0.2/100:0.1);
A=[X(:),Y(:)];
Z = zeros(size(X,1)*size(X,2),1);
for i = 1:num_GMM
    Z = Z + prior(i) * mvnpdf(A,Mu(i,:),Sigma((i-1)*2+1:i*2,:));
end
% sum(Z)*((0.2/100)^2)
Z = reshape(Z,size(X));
figure
surf(X,Y,Z)
colorbar

count
Mu
Sigma
prior
end

