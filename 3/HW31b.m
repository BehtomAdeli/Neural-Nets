
% Neural Network I Course, Prof. Seyed-Salehi
% Biomedical Engineering Departmant, Amir-Kabir University of Technology
% Homework 3, Problem 1, Part b
% Writen by: ||Behtom Adeli|| MSc Student of Bioelectical Eng.
% R.A. @ Biomedical Singla Prossecing Lab.
%__________________________________________________________________________
%                  2-2-1 Back Propagation Neural Network
%__________________________________________________________________________

BPNN(m,n,l,x,d,Etta,Alfa,Emax,Kmax)

clear all
close all
clc

s=size(x);
P=s(1);                                 % Number of Inputs
m=2;                                    % Input Layer
n=2;                                    % Hidden Layer
l=1;                                    % Output Layer
x=[ 1 1 +1; 1 0 +1; 0 1 +1; 0 0 +1];    % Inputs
d=[1 ; 0 ; 0; 1];                       % Desired Output
f=inline('1./(1+exp(-y))');
Etta=0.7;                               % Learning Coefficient be delkhah
Emax=0.01;                              % Max of Final Acceptable Error
V=(2*randn(m+1,n)-1);                   % Weights Between Input and Hidden Layer
W=(2*randn(n+1,l)-1);                   %  ,,      ,,     Hidden and Output Layer
k=1;
Alfa=0.5;                               % Acceleration Coefficient for Error Correction
E=1;
DW=zeros(3,1);
DV=zeros(m+1,n);
y=zeros(1,3);
%__________________________________________________________________________

while (sqrt(E/P/l)>=Emax && k<Kmax)
    E=0;
    for p=1:P
        y=f(x(p,:)*V);
        y(n+1)=1;
        z=f(y*W);
        E=sum((d(p,:)-z)^2)+E;
        Dz=(d(p,:)-z)*z*(1-z);
        Dy=y.*(1-y).*(Dz*W');
        DW=etta*y'*Dz+Alfa*DW;
        W=W+DW;
        DV=etta*x(p,:)'*Dy(1:2)+Alfa*DV;
        V=V+DV;
    end
    T=sqrt(E/P/l);
    plot(k,T)
    grid on
    hold on
    xlabel('Iteration')
    ylabel('sqrt(E/(PL))')
    k=k+1;
end
    