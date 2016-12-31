%tf=input('tiempo final, tf: ');
%pasos=input('número de pasos, n: '); % f=@(t,x) cos(t);
%voltaje=input('Voltaje de inyeccion, V: '); % f=@(t,x) cos(t);

tf=90;
pasos=100; % f=@(t,x) cos(t);
%voltaje=input('Voltaje de inyeccion, V: '); % f=@(t,x) cos(t);
Iinyeccion= [5,10,15,50];


Ek = -12;
ENa = 115;
EL = 10.6;

gL = 0.3;
gK=36;
gNa= 120;

%Caso inicial
V = -10;

k1_n = 0.01 * ( (10-V) / (exp((10-V)/10)-1) );
k2_n = 0.125*exp(-V/80); 
k1_m = 0.1*( (25-V) / (exp((25-V)/10)-1) ); 
k2_m = 4*exp(-V/18);
k1_h = 0.07*exp(-V/20); 
k2_h = 1/(exp((30-V)/10)+1); 

n(1) = k1_n/(k1_n+k2_n); 
m(1) = k1_m/(k1_m+k2_m); 
h(1) = k1_h/(k1_h+k2_h);


for j=1:4
    I = Iinyeccion(j);
    
   % m = calcularM(voltaje,tf,pasos)
   % h = calcularH(voltaje,tf,pasos)
   % n = calcularN(voltaje,tf,pasos)

    VFinal=@(t,Vm)(-gNa*calcularM(Vm,t,pasos)*calcularH(Vm,t,pasos)*(Vm - ENa)-gK*calcularN(Vm,t,pasos)*(Vm - Ek)-gL *(Vm - EL)+Vm);
    
    t0=0.000000000001;
    [t,x]=euler(VFinal,t0,tf,V,pasos);
    plot(t,x)
    pause;

    
end


H=.01;
t = 0:H:100;

plot(t,V(1),t,V(2),t,V(3),t,V(4))
    ylabel('mv')
    xlabel('ms')
    legend('Voltaje(I=5)','Voltaje(I=10)','Voltaje(I=15)','Voltaje(I=50)')





function n = calcularN(Vm,t,pasos)
    %----------- Potasio --------------
    k1= (0.01*(10-Vm))/(exp((10-Vm)/(10))-1);
    km1=(0.125*exp((-1*Vm)/80));


    f=@(t,n) k1 -(k1 + km1)*n;
    t0=0;
    n0=0; 
    n=eulerPuntual(f,t0,t,n0,pasos);
end

function m = calcularM(Vm,t,pasos)

    k1mNa= (0.01*(25-Vm))/(exp((25-Vm)/(10))-1);
    k_1mNa= (4*exp((-1*Vm)/18));
    
    fm=@(t,m) k1mNa -(k1mNa + k_1mNa)*m;
    t0=0;
    n0=0; 
    m=eulerPuntual(fm,t0,t,n0,pasos);

end

function h = calcularH(Vm,t,pasos)
    
    k1hNa= (0.07*exp((-1*Vm)/20));
    k_1hNa= (1)/((exp(30-Vm)/(10))+1);

    fh=@(t,h) k1hNa -(k1hNa + k_1hNa)*h;
    t0=0;
    n0=0; 
    h=eulerPuntual(fh,t0,t,n0,pasos);

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