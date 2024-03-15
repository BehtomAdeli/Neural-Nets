%__________________________________________________________________________
% Neural Network I Course, Prof. Seyed-Salehi
% Biomedical Engineering Departmant, Amir-Kabir University of Technology
% Homework 3, Problem 1, Part b
% Writen by: ||Behtom Adeli|| MSc Student of Bioelectical Eng.
% R.A. @ Biomedical Singla Prossecing Lab.
%__________________________________________________________________________
%
%                  2-2-1 Back Propagation Neural Network
%__________________________________________________________________________
% Help:
%% m: Input  Layer Neuran Nubmer
%  n: Hidden Layer Neuran Nubmer
%  l: Output Layer Neuran Nubmer
%  x: Inputs Matrix
%  d: Desired Output Matrix
%  Etta: Learning Coefficient be delkhah
%  Emax: Max of Final Acceptable Error
%  Alfa: Acceleration Coefficient for Error Correction
%%_________________________________________________________________________

function [k,E,V,W]=BPNN(m,n,l,x,d,Etta,Alfa,Emax,Kmax)

s=size(x);
P=s(1);                          % Number of Inputs
Q=s(2);
q=Q+1;
xd=x;
xd(:,q)=1;
f=inline('1./(1+exp(-y))');
V=(2*randn(m+1,n)-1);            % Weights Between Input and Hidden Layer
W=(2*randn(n+1,l)-1);            %  ,,      ,,     Hidden and Output Layer
k=1;
E=1;
DW=zeros(n+1,l);
DV=zeros(m+1,n);

while (sqrt(E/P/l)>=Emax && k<Kmax)
    E=0;
    for p=1:P
        y=f(xd(p,:)*V);
        y(n+1)=1;
        z=f(y*W);
        E=sum((d(p,:)-z).^2)+E;
        Dz=(d(p,:)-z).*z.*(1-z);
        Dy=y(1,1:n).*(1-y(1,1:n)).*(Dz*W(1:2,:));
        DW=Etta.*y'*Dz+Alfa.*DW;
        W=W+DW;
        DV=Etta*xd(p,:)'*Dy+Alfa*DV;
        V=V+DV;
    end
    T=sqrt(E/P/l);
    plot(k,T,'x','MarkerSize',12)
    grid on
    hold on
    xlabel('Iteration')
    ylabel('sqrt(E/(PL))')
    k=k+1;
end
syms a b
Rasm=[a b 1];
ezplot(Rasm*V(:,1))
grid on
hold on
ezplot(Rasm*V(:,2))
plot(x(:,1),x(:,2),'o')
end
