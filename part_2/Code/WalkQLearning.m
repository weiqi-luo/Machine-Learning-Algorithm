function [Q,policy] = WalkQLearning(gamma,alpha,epsilon,step,s)
%% Q learning
load('trans.mat');
load('rew.mat');
Q = zeros(16,4);
Q_old = Q;
policy = zeros(16,1);
policy_old = policy;
state = ceil(rand*16);
delta_Q = zeros(1,step);
delta_policy = zeros(1,step);
for t = 1:step
    epsilon = 1-t/step;
    action = epsilon_greedy(epsilon,state,Q);
    [newstate,reward] = SimulateRobot(state,action,Mat_trans,Mat_reward);
    Q(state,action) = Q(state,action) + alpha * (reward + gamma*max(Q(newstate,:)) - Q(state,action));
    state = newstate;
    
    [~,policy] = max(Q,[],2);
    delta_policy(t) = norm(policy-policy_old);
    policy_old = policy;
    delta_Q(t) = norm(Q-Q_old,'fro');
    Q_old = Q;    
end

%% generate trajectory
state = s*ones(1,16);
for i = 2:16   
    action = epsilon_greedy(0,state(i-1),Q);
    state(i) = SimulateRobot(state(i-1),action,Mat_trans,Mat_reward);
end
state
figure('Name', sprintf('cartoon epsilon=%g alpha=%g gamma=%g',epsilon,alpha,gamma))
walkshow(state)

% figure('Name', sprintf('delta-Q epsilon=%g alpha=%g gamma=%g',epsilon,alpha,gamma))
% plot(1:step,delta_Q,'-')
% figure('Name',sprintf('delta-policy epsilon=%g alpha=%g gamma=%g',epsilon,alpha,gamma))
% plot(1:step,delta_policy,'-')
end

function a = epsilon_greedy(epsilon,s,Q)
if rand < epsilon
    a = ceil(rand*4);
else
    [q,~] = max(Q(s,:));
    [~,a] = find(Q(s,:) == q);            % if more than one action has the same Q value
    if length(a) > 1                            % select one random form them. 
        a = a(ceil(rand*length(a)));   % otherwise max() would allways only pick the first one!
    end
end
end

function [newstate,reward] = SimulateRobot(state,action,Mat_trans,Mat_reward)
newstate = Mat_trans(state,action);
reward = Mat_reward(state,action);
end

