C = 1;
gK_max = 36; 
gNa_max = 120; 
g_L = 0.3;
E_K = -12; 
E_Na = 115; 
E_L = 10.6;
t=90;
pasos=100;

for j=1:7
    
    V(j)=-30+10.1*(j-1);
    k1 = 0.01 * ( (10-V(j)) / (exp((10-V(j))/10)-1) );
    km1 = 0.125*exp(-V(j)/80); 
    
    %Calcular n por euler para cada iteracion
    
    f=@(t,n) k1 -(k1 + km1)*n;
    t0=0;
    n0=0; 
    n=eulerPuntual(f,t0,t,n0,pasos);
    
    %Calculamos la intesidad con la n calculada y el voltaje de inyección;
    I(j)=gK_max * n * V(j);
    
end


%Representamos  s
plot(V,I)
    ylabel('mA')
    xlabel('mV')
    
    
    
    
    
function n = eulerPuntual(f,t0,tf,n0,pasos)

    [t,x] = euler( f,t0,tf,n0,pasos);
    n = x(end);
    
end

function [ t,x ] = euler( f,t0,tf,n0,pasos) 
    h=(tf-t0)/pasos;
    t=t0:h:tf;
    x=zeros(pasos+1,1); %reserva memoria para n+1 elementos del vector x
    x(1)=n0; 
    for i=1:pasos
            x(i+1)=x(i)+f(t(i),x(i))*h;
    end
end