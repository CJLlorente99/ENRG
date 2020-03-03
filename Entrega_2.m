%% Definicion de constantes
Urs = 400 * (cosd(30)+j*sind(30));
Utr = 400 * (cosd(150)+j*sind(150));
Ust = 400 * (cosd(-90)+j*sind(-90));

Urn = 400 / sqrt(3) * (cosd(0) + j*sind(0));
Utn = 400 / sqrt(3) * (cosd(120) + j*sind(120));
Usn = 400 / sqrt(3) * (cosd(-120) + j*sind(-120));

UL = 400;
UF = 400 / sqrt(3);
%% Apartado I

% Apartado a

P1 = 7886.8;
P2 = 2113.2;

phi = atand(sqrt(3)* (P1-P2)/(P1+P2));
IL = P1/(UL*cosd(phi-30));

IR1 = IL * (cosd(-phi) + j*sind(-phi));

ZR = Urn/IR1 - 2

% Apartado b

P = sqrt(3) * UL * IL * cosd(phi);

phinueva = acosd(0.95);

Qc = P*(1-tand(phinueva))

% Apartado c

IT1 = IL * (cosd(75) + j*sind(75));
IS1 = IL * (cosd(-165) + j*sind(-165));

round(IS1 + IT1 + IR1,3);

%% Apartado II

Zrs = 24;
Zrt = j*18;
Zst = 24+j*18;

Zaux = Zrs + Zrt + Zst;

% Apartado d

Zr = (Zrs*Zrt)/Zaux;
Zs = (Zrs*Zst)/Zaux;
Zt = (Zrt*Zst)/Zaux;

Unn = ((Urn/Zr)+(Usn/Zs)+(Utn/Zt))/(1/Zr + 1/Zt + 1/Zs);

IR2 = (Urn - Unn)/Zr
IS2 = (Usn - Unn)/Zs
IT2 = (Utn - Unn)/Zt

round(IR2 + IS2 + IT2,3);

%% Apartado III
 
P = 2000;
phi3 = acosd(0.8);

% Apartado e

IR3 = P/(abs(Urs)*cosd(phi3));

IR3 = IR3 * (cosd(rad2deg(angle(Urs))-phi3) +j*sind(rad2deg(angle(Urs))-phi3))
IS3 = -IR3;

%% Apartado IV

% Apartado f

I1 = IR1 + IR2 + IR3;
I2 = IS1 + IS2 + IS3;
I3 = IT1 + IT2;

Urt = -Utr;

P1final = real(Urt*I1')
P2final = real(Ust*I2')

P1sup = real(Urt*IR1')+real(Urt*IR2')+real(Urt*IR3')
P2sup = real(Ust*IS1')+real(Ust*IS2')+real(Ust*IS3')

%% Extra

w = 50;
t = 0:1/50/40:1;

% Apartado I

urt = abs(Urt)*sqrt(2) * cos(w.*t + angle(Urt));
ir1 = abs(IR1)*sqrt(2) * cos(w.*t + angle(IR1));

p1 = urt.*ir1;

Irc = j*IR1 * cosd(phi)*(tand(phi)-tand(phinueva));
irc = abs(Irc)*sqrt(2) * cos(w.*t + angle(Irc));

p1_corregida = urt.*(irc+ir1);

figure("Name","Apartado I")

subplot 221
plot(t,p1)
hold on;
plot(t,ir1)
plot(t,urt)
legend("p_1(t)","i_{r1}(t)","u_{rt}(t)")
grid on

subplot 222
plot(t,p1_corregida)
hold on
plot(t,(ir1+irc))
plot(t,urt)
grid on;
legend("p_1(t) corrigiendo fdp","i_{rTotal} (i_{r1}(t)+i_{rc}(t))","u_{rt}(t)")

subplot(2,2,[3 4])
plot(t,p1)
hold on;
plot(t,p1_corregida)
legend("p_1(t)","p_1(t) corrigiendo fdp")
grid on


% Apartado IV

urt = abs(Urt)*sqrt(2) * cos(w.*t + angle(Urt));
urs = abs(Urs)*sqrt(2) * cos(w.*t + angle(Urs));
ust = abs(Ust)*sqrt(2) * cos(w.*t + angle(Ust));

i1 = abs(I1)*sqrt(2) * cos(w.*t + angle(I1));
i2 = abs(I2)*sqrt(2) * cos(w.*t + angle(I2));
i3 = abs(I3)*sqrt(2) * cos(w.*t + angle(I3));

ir1 = abs(IR1)*sqrt(2) * cos(w.*t + angle(IR1));
is1 = abs(IS1)*sqrt(2) * cos(w.*t + angle(IS1));
it1 = abs(IT1)*sqrt(2) * cos(w.*t + angle(IT1));

ir2 = abs(IR2)*sqrt(2) * cos(w.*t + angle(IR2));
is2 = abs(IS2)*sqrt(2) * cos(w.*t + angle(IS2));
it2 = abs(IT2)*sqrt(2) * cos(w.*t + angle(IT2));

ir3 = abs(IR3)*sqrt(2) * cos(w.*t + angle(IR3));
is3 = abs(IS3)*sqrt(2) * cos(w.*t + angle(IS3));

figure("Name","Apartado IV")

subplot 221
plot(t,i1.*urt)
hold on;
plot(t,i1)
plot(t,urt)
legend("p_1(t)","i_1(t)","u_{rt}(t)")
grid on

subplot 222
plot(t,i2.*ust)
hold on;
plot(t,i2)
plot(t,ust)
legend("p_2(t)","i_2(t)","u_{st}(t)")
grid on

subplot 223
plot(t,urt.*(ir1+ir2+ir3))
hold on;
plot(t,urt.*ir1)
plot(t,urt.*ir2)
plot(t,urt.*ir3)
legend("p_1(t)","i_{r1}(t)·u_{rt}(t)","i_{r2}(t)·u_{rt}(t)","i_{r3}(t)·u_{rt}(t)")
grid on

subplot 224
plot(t,ust.*(is1+is2+is3))
hold on;
plot(t,ust.*is1)
plot(t,ust.*is2)
plot(t,ust.*is3)
legend("p_2(t)","i_{s1}(t)·u_{st}(t)","i_{s2}(t)·u_{st}(t)","i_{s3}(t)·u_{st}(t)")
grid on