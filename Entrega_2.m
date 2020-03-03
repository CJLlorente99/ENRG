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