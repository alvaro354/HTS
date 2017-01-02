%tf=input('tiempo final, tf: ');
%pasos=input('número de pasos, n: '); % f=@(t,x) cos(t);
%voltaje=input('Voltaje de inyeccion, V: '); % f=@(t,x) cos(t);

tf=100;
H=0.01; % f=@(t,x) cos(t);
pasos = tf / H;
t = 0:H:100;
%voltaje=input('Voltaje de inyeccion, V: '); % f=@(t,x) cos(t);
Iinyeccion= [5,10,15,50];

 Ek = -12;
 ENa = 115;
 EL = 10.6;

 gL = 0.3;
 gK=36;
 gNa= 120;

%Caso inicial
V0 = 10;

k1_n = 0.01 * ( (10-V0) / (exp((10-V0)/10)-1) );
k2_n = 0.125*exp(-V0/80); 
k1_m = 0.1*( (25-V0) / (exp((25-V0)/10)-1) ); 
k2_m = 4*exp(-V0/18);
k1_h = 0.07*exp(-V0/20); 
k2_h = 1/(exp((30-V0)/10)+1); 

n0 = k1_n/(k1_n+k2_n); 
m0 = k1_m/(k1_m+k2_m); 
h0 = k1_h/(k1_h+k2_h);


for j=1:4
    I = Iinyeccion(j);
    V(1) = V0;
    %Euler
    for i=1:(pasos-1)
        
        V(i+1) = V(i) + H*(I - (n0^4) * gK * (V(i)-Ek) - (m0^3) * gNa * h0 * (V(i)-E_Na) - gL *(V(i)-EL))/C;
        
        k1_n = 0.01 * ( (10-V(i)) / (exp((10-V(i))/10)-1) );
        k2_n = 0.125*exp(-V(i)/80);
        k1_m = 0.1*( (25-V(i)) / (exp((25-V(i))/10)-1) );
        k2_m = 4*exp(-V(i)/18);
        k1_h = 0.07*exp(-V(i)/20);
        k2_h = 1/(exp((30-V(i))/10)+1);

        
        n0 = n0 + H*(k1_n *(1-n0) - k2_n  * n0);
        m0 = m0 + H*(k1_m  *(1-m0) - k2_m  * m0);
        h0 = h0 + H*(k1_h  *(1-h0) - k2_h  * h0);
    

    end
    
    VF{j} = V;
    
end


plot(t,VF{1},t,VF{2},t,VF{3},t,VF{4})
    ylabel('mv')
    xlabel('ms')
    legend('Voltaje(I=5)','Voltaje(I=10)','Voltaje(I=15)','Voltaje(I=50)')