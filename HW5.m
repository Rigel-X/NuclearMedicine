C=[ 0,0,0,0,0,0,1,1,1
    0,0,0,1,1,1,0,0,0
    1,1,1,0,0,0,0,0,0
    1,0,0,1,0,0,1,0,0
    0,1,0,0,1,0,0,1,0
    0,0,1,0,0,1,0,0,1
    0,1,0,0,0,1,0,0,0
    1,0,0,0,1,0,0,0,1
    0,0,0,1,0,0,0,1,0];
C=C';
C1=C(:,1:3);
C2=C(:,4:6);
C3=C(:,7:9);
f_t=[1,2,1,2,4,2,1,2,1];
f0=[1,1,1,1,1,1,1,1,1];
f0=f0';
f=f0;
f_t=f_t';
P=[4,8,4,4,8,4,4,6,4];
P=P';
MSE1=zeros(1,100);
MSE2=zeros(1,100);
phi=zeros(1,100);
for n=1:100

%% Updata
    for k=1:9
        t1=0;
        for j=1:3
            t1=t1+C(k,j);
        end
        t3=0;
        for j=1:3
            t2=0;
            for i=1:9
                t2=t2+f0(i)*C(i,j);
            end
            t3=t3+C(k,j)*P(j)/t2;
        end
        f(k)=f0(k)*t3/t1;
        %P'=C*f;
    end
    f0=f;
    
    for k=1:9
        t1=0;
        for j=4:9
            t1=t1+C(k,j);
        end
        t3=0;
        for j=4:9
            t2=0;
            for i=1:9
                t2=t2+f0(i)*C(i,j);
            end
            t3=t3+C(k,j)*P(j)/t2;
        end
        f(k)=f0(k)*t3/t1;
        %P'=C*f;
    end

%% Calculate
    t=(f-f_t).*(f-f_t);
    for m=1:9
        MSE1(n)=MSE1(n)+t(m);
    end
    tt=(C'*f-P).*(C'*f-P);
    for m=1:9
        MSE2(n)=MSE2(n)+tt(m);
    end
    for jj=1:9
        temp2=0;
        for ii=1:9
            temp2=temp2+C(ii,jj)*f(ii);
        end
        phi(n)=phi(n)+P(jj)*log(temp2)-temp2;
    end
    f0=f;
end

subplot(1,2,1)
plot(MSE1)
hold on
plot(MSE2)
hold on
legend('重建图像与真实图像的MSE值','投影估计值与给出的实测投影数据间的MSE值')

subplot(1,2,2)
plot(phi)
legend('似然函数值')
