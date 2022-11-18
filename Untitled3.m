axis([0,10,0,6]);
%grid on;
%axis equal;
hold on;
    plot([0,3],[3,3],'g','linewidth',2);
    plot([6,10],[3,3],'g','linewidth',2);
    plot([3,3],[2,3],'g','linewidth',2);
    plot([6,6],[2,3],'g','linewidth',2);
    plot([4,4],[0,2],'g','linewidth',2);
    plot([5,5],[0,2],'g','linewidth',2);
    plot([3,4],[2,2],'g','linewidth',2);
    plot([5,6],[2,2],'g','linewidth',2);
 
st=randperm(30);
s=st(1);
%s=28;
 
i=1;
while s~=55
 
    %商
    Y(i)=5.5-floor((s-1)/10);
    %余数
    X(i)=0.5+rem(s-1,10);
    %plot(X,Y,'*');
    
    A=plot([X(i)-0.5,X(i)+0.5],[Y(i)-0.5,Y(i)-0.5],'r-','linewidth',2);
    B=plot([X(i)-0.5,X(i)+0.5],[Y(i)+0.5,Y(i)+0.5],'r-','linewidth',2);
    C=plot([X(i)-0.5,X(i)-0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
    D=plot([X(i)+0.5,X(i)+0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
    pause(0.2);
    if i>1;
    plot([X(i-1),X(i)],[Y(i-1),Y(i)],'b-','linewidth',2);
    end
 
    qm=max(q(s,:));
    if qm~=0
       ac=find(q(s,:)==qm);
    else
       ac=find(R(s,:)>=0);
    end
    
    if size(ac,2)>1
        act=RandomPermutation(ac);
        act=act(1);
    else
        act=ac;
    end
 
        delete(A);
        delete(B);
        delete(C);
        delete(D);
 
    s=act;
    i=i+1;
end
 
%商
Y(i)=5.5-floor((s-1)/10);
%余数
X(i)=0.5+rem(s-1,10);
A=plot([X(i)-0.5,X(i)+0.5],[Y(i)-0.5,Y(i)-0.5],'r-','linewidth',2);
B=plot([X(i)-0.5,X(i)+0.5],[Y(i)+0.5,Y(i)+0.5],'r-','linewidth',2);
C=plot([X(i)-0.5,X(i)-0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
D=plot([X(i)+0.5,X(i)+0.5],[Y(i)-0.5,Y(i)+0.5],'r-','linewidth',2);
 
if i>1;
    plot([X(i-1),X(i)],[Y(i-1),Y(i)],'b-','linewidth',2);
end