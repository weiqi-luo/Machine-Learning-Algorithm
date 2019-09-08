function Exercise2()
close all
clc
%EXERCISE2 Summary of this function goes here
%   Detailed explanation goes here
len_TestSeq = 60;
num_Test = 10;
num_observ = 8;
num_state = 12;

fileID = fopen('Test.txt','r');
fileA = fopen('A.txt','r');
fileB = fopen('B.txt','r');
filePi = fopen('pi.txt','r');

Mat_test = reshape(fscanf(fileID,'%f'),[num_Test,len_TestSeq]);
Mat_trans = reshape(fscanf(fileA,'%f'),[num_state,num_state])';
Mat_observ = reshape(fscanf(fileB,'%f'),[num_state,num_observ]);
Vec_init = fscanf(filePi,'%f');

fclose('all');

%% compute log-likelihood with forward procedure
log_likelihood = zeros(1,num_Test);
for iter_Test = 1:num_Test
    test = Mat_test(iter_Test,:);
    % initialization
    vec_forward = Vec_init.*Mat_observ(:,test(1));
    % forward process
    for iter_TestSeq = 2:len_TestSeq
        vec_forward = Mat_trans'*vec_forward .* Mat_observ(:,test(iter_TestSeq));
    end
    log_likelihood(iter_Test) = log(sum(vec_forward));
end
log_likelihood
% classification
label = ones(1,num_Test);
label(log_likelihood<-120)=2


%% visualization
plot(1:1:num_Test,log_likelihood,'-*b',1:1:num_Test,-115*ones(num_Test,1),'-r')
axis([1,10,-600,0])
xlabel('gesture')
ylabel('log-likelihood')
legend('log-likelihood','decision boundary')
end

