clear all
close all
clc

P=4;
m=2;                                    % laye vorudi
n=2;                                    % laye penhan
l=1;                                    % laye khoruji

x=[ 1 1 +1; 1 0 +1; 0 1 +1; 0 0 +1];
d=[1 ; 0 ; 0; 1];                       %Desired Output

etta=0.7;                              % zaribe yadgiri be delkhah
Emax=0.01;
V=rand(m+1,n);
W=rand(n+1,l);
k=1;
Alfa=0.7;
E=1;
DW=zeros(3,1);
DV=zeros(m+1,n);

while (sqrt(E/P/l)>=Emax && k<20000)
    E=0;
    for p=1:P
        for j=1:n
            y(j)=1/(1+exp(-x(p,:)*V(:,j)));
        end
        y(3)=+1;
        for q=1:l
            z(q)=1/(1+exp(-y*W));
        end
        E=sum((d(p,:)-z)^2)+E;
        Dz=(d(p,:)-z)*z*(1-z);
        for j=1:n+1
            Dy(j)=y(j)*(1-y(j))*sum(Dz*W);
            DW(j)=etta*y(j)*Dz+Alfa*DW(j);
            W(j,l)=W(j,l)+DW(j);
            for i=1:m
                DV(j,i)=etta*x(p,i)*Dy(j)+Alfa*DV(j,i);
                V(j,i)=V(j,i)+DV(j,i);
            end
        end
    end
    T=sqrt(E/P/l);
    plot(k,T)
    grid on
    hold on
    xlabel('Iteration')
    ylabel('sqrt(E/(PL))')
    k=k+1;
end
    