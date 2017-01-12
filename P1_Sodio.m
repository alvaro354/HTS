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
    I(j)=NA_v(t, V(j));
    
end


%Representamos  s
plot(V,I)
    ylabel('mA')
    xlabel('mV')

function i =  NA_v(t,V)
    
    gNa_max = 120; 
    t=90;
    pasos=100;

    
    k1_m = 0.1*( (25-V) / (exp((25-V)/10)-1) ); 
    k2_m = 4*exp(-V/18);
    k1_h = 0.07*exp(-V/20); 
    k2_h = 1/(exp((30-V)/10)+1); 

    
    f=@(t,m) k1_m -(k1_m + k2_m)*m;
    t0=0;
    m0=0; 
    m=eulerPuntual(f,t0,t,m0,pasos);
    
    f=@(t,h) k1_h -(k1_h + k2_h)*h;
    t0=0;
    h0=0; 
    h=eulerPuntual(f,t0,t,h0,pasos);
    
    %Calculamos la intesidad con la n calculada y el voltaje de inyección;
    i=gNa_max * m * h * V;

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