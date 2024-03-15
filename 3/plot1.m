clc
syms x1 x2
X=[x1 , x2 , 1 ];

A=x(1,:).*V(:,1)';
Y=A.*X;
X1=-2:0.01:2;
X2=-2:0.01:2;
F=sum(Y);
E=subs(Y,{x1,x2},{X1,X2});
[U,H]=meshgrid(X1,X2);
surf(X1,X2,E)