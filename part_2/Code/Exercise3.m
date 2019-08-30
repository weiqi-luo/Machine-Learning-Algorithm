function Exercise3()
clc
close all

%% walk policy iterations
gamma = 0.5;
s =10;
WalkPolicyIterations(gamma,s);
s =3;
WalkPolicyIterations(gamma,s);

%% plot the iteration number with different gamma
% max_num = 100;
% iter_num = zeros(1,0.99*max_num+1);
% for i = 0:0.99*max_num
%     sum = 0;
%     for j = 1:20
%         sum = sum + WalkPolicyIterations(i/max_num,s);
%     end
%     iter_num(i+1) = sum/20;
% end
% plot(0:1/max_num:0.99,iter_num,'-*')
% title('number of iterations till convergence')
% xlabel('gamma')
% ylabel('iteration')


%%
gamma = 0.5;
alpha = 1;
epsilon = 0.5;
step = 10000;
s=5;
WalkQLearning(gamma,alpha,epsilon,step,s);
s=12;
WalkQLearning(gamma,alpha,epsilon,step,s);
%% Plot diffent result with different parameter
% [Q1,policy1] = WalkQLearning(gamma,0.2,0,step,s);
% [Q2,policy2] = WalkQLearning(gamma,0.2,0.2,step,s);
% [Q3,policy3] = WalkQLearning(gamma,0.2,0.4,step,s);
% [Q4,policy4] = WalkQLearning(gamma,1,0.6,step,s);
% [Q5,policy5] = WalkQLearning(gamma,alpha,0.8,step,s);
% [Q6,policy6] = WalkQLearning(gamma,alpha,1,step,s);
% [norm(policy1-policy6,'fro'),norm(policy2-policy6,'fro'),norm(policy3-policy6,'fro'),norm(policy4-policy6,'fro'),norm(policy5-policy6,'fro');
% norm(Q1-Q6,'fro'),norm(Q2-Q6,'fro'),norm(Q3-Q6,'fro'),norm(Q4-Q6,'fro'),norm(Q5-Q6,'fro')]
end

