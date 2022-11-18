clc;
clear all;
% define state
R=ones(60,60)*-inf;  
for i=1:30
   if i-10>0
       R(i,i-10)=0;
   end 
   if i+10<31
       R(i,i+10)=0;
   end
   if mod(i,10)~=1
       R(i,i-1)=0;
   end
   if mod(i,10)~=0;
       R(i,i+1)=0;
   end
end
R(24,34)=0;R(25,35)=0;R(26,36)=0;
R(34,24)=0;R(35,25)=0;R(36,26)=0;
R(34,35)=0;R(35,36)=0;R(35,34)=0;R(36,35)=0;
R(35,45)=0;R(45,35)=0;
R(45,55)=100;R(55,45)=0;
 
% reinforcement learning parameters
gamma=0.9;
q=zeros(size(R));     % q matrix
q1=ones(size(R))*inf; % previous q matrix
count=0;
 
% visualize obstacle 
axis([0,10,0,6]);
hold on;
plot([0,3],[3,3],'g','linewidth',2);
plot([6,10],[3,3],'g','linewidth',2);
plot([3,3],[2,3],'g','linewidth',2);
plot([6,6],[2,3],'g','linewidth',2);
plot([4,4],[0,2],'g','linewidth',2);
plot([5,5],[0,2],'g','linewidth',2);
plot([3,4],[2,2],'g','linewidth',2);
plot([5,6],[2,2],'g','linewidth',2);
 
% intial state
y=randperm(30);
state=y(1);
 
% q learning
tic
for episode=0:50000
 
    qma=max(q(state,:));
    if qma~=0
       x=find(q(state,:)==qma);
    else
       x=find(R(state,:)>=0);
    end
    % choose action
    if size(x,1)>0
        x1=RandomPermutation(x);
        x1=x1(1);
    end
    % update q matrix
    qMax=max(q,[],2);
    q(state,x1)=R(state,x1)+gamma*qMax(x1);
    
    Y(i)=5.5-floor((x1-1)/10);
    X(i)=0.5+rem(x1-1,10);
    % visualization
    A=plot([X(i)-0.5,X(i)+0.5],[Y(i)-0.5,Y(i)-0.5],'r-','linewidth',2);
    B=plot([X(i)-0.5,X(i)+0.5],[Y(i)+0.5,Y(i)+0.5],'r-','linewidth',2);
    C=plot([X(i)-0.5,X(i)-0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
    D=plot([X(i)+0.5,X(i)+0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
    pause(0.05);
    
     % break if converged: small deviation on q for 1000 consecutive
     if sum(sum(abs(q1-q)))<0.0001 && sum(sum(q))>190
         if count>500,
             episode        % report last episode
             break          % for
         else
             count=count+1; % set counter if deviation of q is small
         end
     else
          q1=q;
          count=0;
     end
     
     if(R(state,x1)==100)
         y=randperm(30);
         state=y(1);
         pause(0.4);
     else
         state=x1;
     end
        delete(A);
        delete(B);
        delete(C);
        delete(D);
 
end
toc
%normalization
g=max(max(q));
if g>0, 
    q=100*q/g;
end