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
    
    %Calculamos la respuesta para potenciales de -30 a 30 en intervalos de
    %10 en 10
    V(j)=-30+10.1*(j-1);
    I(j)=K_v(t, V(j));
    
end


%Representamos  s
plot(V,I)
    ylabel('mA')
    xlabel('mV')

function i =  K_v(t,V)
    
    gK_max = 36; 
    t=90;
    pasos=100;

    
    k1 = 0.01 * ( (10-V) / (exp((10-V)/10)-1) );
    km1 = 0.125*exp(-V/80);
    f=@(t,n) k1 -(k1 + km1)*n;
    t0=0;
    n0=0; 
    n=eulerPuntual(f,t0,t,n0,pasos);
    
    %Calculamos la intesidad con la n calculada y el voltaje de inyección;
    i=gK_max * n * V;

end
    
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