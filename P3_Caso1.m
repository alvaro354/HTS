
H=1/52;

t=0:H:10;

%valores iniciales
x=1;
vX=0;
y=0;
vY=2*pi;
a=39.5;
B=-1.5;


for i=1:numel(t)-1
    
    Qx=(-a*x(i)*(x(i)^2+y(i)^2)^B);
    Qy=(-a*y(i)*(x(i)^2+y(i)^2)^B);
    
    vX(i+1)= vX(i) + H*Qx/2;
    vY(i+1)= vY(i) + H*Qy/2;
    
    x(i+1) = x(i) + vX(i+1)*H;
    y(i+1) = y(i) + vY(i+1)*H;
    
    

end

plot(x,y,1,2);
    ylabel('y')
    xlabel('x')
    legend('orbita')