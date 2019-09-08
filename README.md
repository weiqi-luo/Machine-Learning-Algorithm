# Machine Learning Basics

This repository covers basic machine learning algorithms from the lecture Machine Learning in Robotics implemented in MATLAB. 

## Part 1
### 1.1 Estimating the velocity motion model of a mobile robot through linear regression

The task is to estimate the pose of a mobile robot from control inputs (velocity and angular velocity) through a black box model, that is represented as a polynomial of order $P$. 

The estimation problem is solved in following steps:

- Apply a $k$-fold cross validation for different model dimension $P$ and select  the best model
- Re-estimate the model parameters using the entire dataset

<p align="center">
    <img src="pics/1c.jpg", width="350">
    <br>
    <sup>An example of  robot trajectory simulation using the learned model parameters</sup>
</p>

### 1.2 Handwritten digits classification using Bayesian classifier with MNIST database

- Project the data into low dimensional space via PCA

- Model the distribution of each digit by a multivariate Gaussian distribution 
- Assign the input to the class which yields the highest likelihood

### 1.3 Human motion clustering

The cluster algorithms K-means and Non-Uniform Binary Split are compared in the following on a dataset of sample trajectories.

- K-means

  <p align="center">
      <img src="pics/kmean1.jpg", width="350">
      <br>
      <sup>An example of clustering result using K-means Algorithm</sup>
  </p>

- Non-Uniform Binary Split Algorithm. The initial split direction was given by a vector $v$. 

  <p align="center">
      <img src="pics/nubs1.jpg", width="350">
      <br>
      <sup>An example of clustering result using Non-Uniform Binary Split Algorithm. </sup>
  </p>

## Part 2
### 2.1 Learning dataset using Gaussian mixture model

In Learning from Demonstration (LfD), Gaussian Mixture Models (GMM) are widely used to encode demonstrated trajectories. Therefore, the parameters of the GMM are estimated by the Expectation Maximization (EM) algorithm.  

<p align="center">
    <img src="pics/1_2D.jpg", width="350">
    <br>
    <sup>Visualization of GMM components. </sup>
</p>

<p align="center">
    <img src="pics/1_3D.jpg", width="500">
    <br>
    <sup>Visualization of GMM density function. </sup>
</p>



### 2.2 Learning a gait pattern for a walking robot using Reinforcement Learning

The aim of the task is to control a robot so that it moves forward with a reasonable walking pattern. The problem was solved with two approaches

- Policy Iteration: By modeling the MDP, the optimal policy $\pi^*$ was obtained by the standard policy iteration. 

- Q-Learning: The policy is determined from the learned Q-function $Q(s,a)$, for all states $s$ and actions $a$  

  <p align="center">
      <img src="pics/policy_3.jpg", width="500">
      <br>
      <sup>An example of the learned walking pattern. </sup>
  </p>

