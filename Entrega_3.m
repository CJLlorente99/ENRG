%% Definicion de constantes

U1N = 10000;
mod_U2N = 120;
f = 50;
SN = 100000;

% Ensayo vacio

mod_Io = 0.85;
Po = 1000;

% Ensayo cortocircuito

mod_Ucc = 430;
Pcc = 1600;

% Otras

m = U1N/mod_U2N;
mod_I1N = SN/U1N;
Ohm = char(hex2dec('03A9'));
mu = char(hex2dec('03BC'));

%% Apartado a % Rcc, Xcc, Rfe, Xmu

fdpo = Po/(U1N*mod_Io);
phio = acosd(fdpo);

Ife = mod_Io * fdpo;
Imu = mod_Io * sind(phio);

Rfe = U1N/Ife;
Xmu = U1N/Imu;

Rcc = Pcc/(mod_I1N^2);
Zcc = mod_Ucc/mod_I1N;
Xcc = sqrt(Zcc^2 - Rcc^2);

fprintf(">Apartado a \n");

fprintf("Rcc vale %.0f %s \n",Rcc, Ohm);
fprintf("Xcc vale %.2f %s \n",Xcc, Ohm);
fprintf("R_{fe} vale %.0f %s \n",Rfe, Ohm);
fprintf("X_{%s} vale %.2f %s \n",mu,Xmu, Ohm);

%% Apartado b y c % mod_U2 y abs(I1)

% Datos

S2 = 75000;
fdp2 = 0.8; %inductivo
phi2 = acosd(0.8);

Zeq = (Rfe*j*Xmu)/(Rfe+j*Xmu);

Io = U1N/Zeq;

mod_I2p = roots([(Rcc^2+Xcc^2),(-2*U1N*Rcc),U1N^2, 0, -S2^2]); %tomamos solución real y positiva
mod_I2p = mod_I2p(3);

mod_U2p = S2/mod_I2p;
mod_U2 = mod_U2p/m;

Zlp = mod_U2p/(mod_I2p*(cosd(-phi2)+j*sind(-phi2)));

I2p = U1N/(Zlp+Rcc+j*Xcc);
I1 = Io + I2p;

fprintf(">Apartado b y c \n");

fprintf("U_2 vale %.2f V \n",mod_U2);
fprintf("I_1 vale %.2f \n",abs(I1));

%% Apartado d % eta

c = abs(I1)/mod_I1N;

eta = 100* (c*S2*cosd(phi2))/(c*S2*cosd(phi2)+Po+c^2*Pcc);

fprintf(">Apartado d \n");

fprintf("%s vale %.2f %% \n",mu,eta);

%% Apartado b y c % con aproximación de Kapp mod_U22 y abs(I12)

mod_I2p2 = roots([Rcc*fdp2 + Xcc*sind(phi2), -U1N, S2]); %cojemos el resultado con sentido
mod_I2p2 = mod_I2p2(2);

mod_U2p2 = S2/mod_I2p2;
mod_U22 = mod_U2p2/m;

Zlp2 = mod_U2p2/(mod_I2p2*(cosd(-phi2)+j*sind(-phi2)));

I2p2 = U1N/(Zlp2+Rcc+j*Xcc);

I12 = I2p2+Io;

fprintf(">Apartado b y c, utilizando la aproximación de Kapp \n");

fprintf("U_2 vale %.2f V \n",mod_U22);
fprintf("I_1 vale %.2f A \n",abs(I12));

%% Apartado d % con aproximación de Kapp eta2

c2 = abs(I12)/mod_I1N;

eta2 = 100* c2*S2*cosd(phi2)/(c2*S2*cosd(phi2)+Po+c2^2*Pcc);

fprintf(">Apartado d utilizando la aproximación de Kapp \n");

fprintf("%s vale %.2f %% \n",mu,eta2);