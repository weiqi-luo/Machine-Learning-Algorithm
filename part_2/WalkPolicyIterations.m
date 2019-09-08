function iter_num = WalkPolicyIterations(gamma,s)
load('trans.mat');
load('rew.mat');
% gamma = 0.5;
policy = ceil(rand(16,1)*4);
policy_old = zeros(16,1);
Mat_reward= Mat_reward';
Mat_trans = Mat_trans';
iter_num = 0;


%% Policy iteration
while norm(policy-policy_old)
    iter_num = iter_num +1;
    policy_old = policy;
    value_func = policy_evaluation(gamma,policy,Mat_trans,Mat_reward);  
    policy = policy_improvement(gamma,value_func,Mat_trans,Mat_reward);
end
 
%% generate trajectory
state = s*ones(1,16);
for i = 2:16   
    state(i) = Mat_trans(policy(state(i-1)),state(i-1));
end
state
figure
walkshow(state)

end

%% policy evaluation
function value_func = policy_evaluation(gamma,policy,Mat_trans,Mat_reward)
ind = (0:4:(4*15))' + policy;
reward = Mat_reward(ind);
state_next = Mat_trans(ind);
transformation = zeros(16);
transformation((0:16:(16*15))' + state_next)=1;
value_func = (diag(ones([1,16]))-gamma*transformation') \ reward;
end

%% policy improvement
function policy = policy_improvement(gamma,value_func,Mat_trans,Mat_reward)
value_action_func = gamma*value_func(Mat_trans)+Mat_reward;
[~,policy] = max(value_action_func);
policy=policy';
end