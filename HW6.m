% The sixth hw
% calculate PSF 

clear

delta=0.1;
for i=1:1000
    syms x y;
    [x1,y1]=solve(y==(280/(delta*(i-0.5)))*x,y==x+28.3,x,y);
    [x2,y2]=solve(y==(280/(delta*(i-0.5)))*x,y==-x+28.7,x,y);

    if x1<0.2
        theta1=atan(delta*i/280);
        theta2=atan(delta*(i-1)/280);
        PSF(i)=vpa((theta1-theta2)/(2*pi));

    elseif x1>=0.2 && x1<2.7
        p1=[x1,y1];
        p2=[x2,y2];
        Len=norm(p1-p2);
        theta1=atan(delta*i/280);
        theta2=atan(delta*(i-1)/280);
        PSF(i)=vpa((theta1-theta2)/(2*pi)*exp(-3.628*Len));

    elseif x1>=2.7 && x2<2.7
        [x1,y1]=solve(y==(delta*(i-0.5)/280)*x,y==31,x,y);
        [x2,y2]=solve(y==(delta*(i-0.5)/280)*x,y==-x+28.7,x,y);
        p1=[x1,y1];
        p2=[x2,y2];
        Len=norm(p1-p2);
        theta1=atan(delta*i/280);
        theta2=atan(delta*(i-1)/280);
        PSF(i)=vpa((theta1-theta2)/(2*pi)*exp(-3.628*Len));
    
    elseif x2>=2.7
        [x1,y1]=solve(y==(delta*(i-0.5)/280)*x,y==31,x,y);
        [x2,y2]=solve(y==(delta*(i-0.5)/280)*x,y==26,x,y);
        p1=[x1,y1];
        p2=[x2,y2];
        Len=norm(p1-p2);
        theta1=atan(delta*i/280);
        theta2=atan(delta*(i-1)/280);
        PSF(i)=vpa((theta1-theta2)/(2*pi)*exp(-3.628*Len));
    end
end

plot(PSF)
