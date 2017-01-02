
%----------------- Variables de la funcion -----------------%
H=.01;
t = 0:H:100;
I=5; %Para este caso se ignora este parametro y se usan 5,10,15,50
%-----------------------------------------------------------%

C = 1;
gK_max = 36; 
gNa_max = 120; 
g_L = 0.3;
E_K = -12; 
E_Na = 115; 
E_L = 10.6;


V=-10; 

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
    if j==1
        I=5;
    end
    if j==2
        I=10;
    end
    if j==3
        I=15;
    end
    if j==4
        I=50;
    end
    
    for i=1:numel(t)-1 
        k1_n(i) = 0.01 * ( (10-V(i)) / (exp((10-V(i))/10)-1) );
        k2_n(i) = 0.125*exp(-V(i)/80);
        k1_m(i) = 0.1*( (25-V(i)) / (exp((25-V(i))/10)-1) );
        k2_m(i) = 4*exp(-V(i)/18);
        k1_h(i) = 0.07*exp(-V(i)/20);
        k2_h(i) = 1/(exp((30-V(i))/10)+1);

        n(i+1) = n(i) + H*(k1_n(i) *(1-n(i)) - k2_n(i) * n(i));
        m(i+1) = m(i) + H*(k1_m(i) *(1-m(i)) - k2_m(i) * m(i));
        h(i+1) = h(i) + H*(k1_h(i) *(1-h(i)) - k2_h(i) * h(i));
        
        V(i+1) = V(i) + H*(I - (n(i)^4) * gK_max * (V(i)-E_K) - (m(i)^3) * gNa_max * h(i) * (V(i)-E_Na) - g_L *(V(i)-E_L))/C;
    end
    i=1;
    
    if j==1
        V1=V
    end
    if j==2
        V2=V;
    end
    if j==3
        V3=V;
    end
    if j==4
        V4=V;
    end
    
end

plot(t,V1,t,V2,t,V3,t,V4)
    ylabel('mv')
    xlabel('ms')
    legend('Voltaje(I=5)','Voltaje(I=10)','Voltaje(I=15)','Voltaje(I=50)')




