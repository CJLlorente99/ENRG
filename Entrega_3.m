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

%% Apartado c % mod_U2

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

%% Apartado d % eta

c = abs(I1)/mod_I1N;

eta = 100* (c*S2*cosd(phi2))/(c*S2*cosd(phi2)+Po+c^2*Pcc);

%% Apartado b y c % con aproximación de Kapp

mod_I2p2 = roots([Rcc*fdp2 + Xcc*sind(phi2), -U1N, S2]); %cojemos el resultado con sentido
mod_I2p2 = mod_I2p2(2);

mod_U2p2 = S2/mod_I2p2;
mod_U22 = mod_U2p2/m;

Zlp2 = mod_U2p2/(mod_I2p2*(cosd(-phi2)+j*sind(-phi2)));

I2p2 = U1N/(Zlp2+Rcc+j*Xcc);

I12 = I2p2+Io;

%% Apartado d % con aproximación de Kapp

c2 = abs(I12)/mod_I1N;

eta2 = 100* c2*S2*cosd(phi2)/(c2*S2*cosd(phi2)+Po+c2^2*Pcc);