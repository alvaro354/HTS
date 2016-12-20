tf=input('tiempo final, tf: ');
pasos=input('número de pasos, n: '); % f=@(t,x) cos(t);
voltaje=input('Voltaje de inyeccion, V: '); % f=@(t,x) cos(t);

%----------- Potasio --------------
k1=@(Vm) (0.01*(10-Vm))/(exp((10-Vm)/(10))-1);
km1=@(Vm) (0.125*exp((-1*Vm)/80));
k1V = k1(voltaje);
km1V = km1(voltaje);

f=@(t,n) k1V -(k1V + km1V)*n;
%condiciones iniciales
t0=0;
n0=0; 
[t,n]=euler(f,t0,tf,n0,pasos);
n = 
%intensidadK=(gK*voltaje)*n;
% x=euler(f,t0,tf,x0,n); hold on
%plot(t,intensidadK,'*'), grid, title('N') 
%pause
%----------- Sodio --------------

gNa=120

k1mNa=@(Vm) (0.01*(25-Vm))/(exp((25-Vm)/(10))-1);
k_1mNa=@(Vm) (4*exp((-1*Vm)/18));

k1hNa=@(Vm) (0.07*exp((-1*Vm)/20));
k_1hNa=@(Vm) (1)/((exp(30-Vm)/(10))+1);

%Calculo de la M

fm=@(t,m) k1V -(k1V + km1V)*m;
%condiciones iniciales
t0=0;
n0=0; 
[t,m]=euler(fm,t0,tf,n0,pasos);
m

%Calculo de la M

fh=@(t,h) k1V -(k1V + km1V)*h;
%condiciones iniciales
t0=0;
n0=0; 
[t,h]=euler(fh,t0,tf,n0,pasos);


%intensidadNa=(gNa*voltaje)*h'*m;
% x=euler(f,t0,tf,x0,n); hold on
%plot(t,m,'*'), grid,title('M') 
%pause
%plot(t,h,'*'), grid,title('H') 
%pause

Ek = -12;
ENa = 115;
EL = 10.6;

gL = 0.3;
gK=36;
gNa= 120;

INa = gNa * (voltaje - ENa);
IK = gK * (voltaje - Ek);
IL = gL * (voltaje - EL);

Iinj= INa + IK + IL;

fIfinal=@(t,Vm) (gNa*m*h*(Vm - ENa))-(gK*n*(Vm - Ek))-(gL *(Vm - EL))+Iinj;

[t,Vm]=euler(fIfinal,t0,tf,n0,pasos);
plot(t,Vm,'*'), grid,title('V Final') 






function n = eulerPuntual(f,t0,tf,n0,pasos)

    [t,x] = euler( f,t0,tf,n0,pasos);
    n = []
    

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