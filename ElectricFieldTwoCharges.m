clear; close all; clc;

%RETO AVANCE 1 

%Adriann Martin Herna¡ndez Barrientos 		A01570656
%Jose Gustavo Buenaventura CarreÃ³n 		A01570891 
%Jose Arnoldo Rositas Salinas 			A00829760
%Axel Canales Rodriguez 				A01284296
%Ana Helena Garcia Lopez 				A01197782
%Santiago Minga Martinez 				A00830698


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CARGA NEGATIVA
%Crear grid como espacio donde estan las cargas
N=15;
x=linspace(-2,2,N);
y=linspace(-2,2,N);
[Mx,My]=meshgrid(x,y);

%Posición de la particula negativa
xUbi = 0; yUbi = 0; ancho = 0.4;

%Campo Eléctrico
qNeg = -50; %valor de la carga negativa
qPos = 50; %valor de la carga positiva
K = 9 * 10^9;
Rx = Mx - xUbi ; 
Ry = My - yUbi ;

R = sqrt(Rx.^2 + Ry.^2); %magnitud de distancia entre cargas

%Negativo
ExNeg = K .* qNeg .* Rx  ./ R.^2; %calculo de campo electrico en x
EyNeg = K .* qNeg .* Ry ./ R.^2; %calculo de campo electrico en y

subplot(3,2,2)
quiver(Mx,My,ExNeg,EyNeg, 1.4, 'k')
axis([-1 1 -1 1]);
axis equal
Carga = rectangle('Position',[xUbi-ancho/2,yUbi-ancho/2,ancho,ancho],'curvature',[1 1]);
set(Carga,'FaceColor',[0 0 1], 'EdgeColor',[0 0 0]);
text(-.08 , .07 ,'-','Color','white','FontSize',40)
title('Campo eléctrico con carga negativa en el origen')

%Positivo
ExPos = K .* qPos .* Rx  ./ R.^2; %calculo de campo electrico en x
EyPos = K .* qPos.* Ry ./ R.^2; %calculo de campo electrico en y

subplot(3,2,1)
quiver(Mx,My,ExPos,EyPos, 1.4, 'k')
axis([-1 1 -1 1]);
axis equal
Carga = rectangle('Position',[xUbi-ancho/2,yUbi-ancho/2,ancho,ancho],'curvature',[1 1]);
set(Carga,'FaceColor',[1 0 0], 'EdgeColor',[0 0 0]);
text(-.139 , .02 ,'+','Color','white','FontSize',40)
title('Campo eléctrico con carga positiva en el origen')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CARGA POSITIVA Y NEGATIVA

%Crear grid como espacio donde estan las cargas
N=15;
Xmin=-4;  Xmax=+4;
Ymin=-4;  Ymax=+4;
x=linspace(Xmin,Xmax,2*N);
y=linspace(Ymin,Ymax,2*N);
[Mx,My]=meshgrid(x,y);

%Posición de la particula positiva
xPosPos = -0.5; yPosPos = 0; ancho = 0.5;

%Posición de la particula negativa
xPosNeg = 0.5; yPosNeg = 0; 


%Campo Eléctrico
qPos = 50;  %valor de carga positva
qNeg = -50; %valor de carga negativa

K = 9 * 10^9;

%Calculo de campo eléctrico de la carga positiva
Rx = Mx - xPosPos ;
Ry = My - yPosPos ;

R = sqrt(Rx.^2 + Ry.^2); %magnitud de distancia 
Ex = K .* qPos .* Rx  ./ R.^2; %calculo de campo electrico en x
Ey = K .* qPos .* Ry ./ R.^2; %calculo de campo electrico en y


%Calculo de campo eléctrico de la carga negativa + lo obtenido de la carga
%positiva
Rx = Mx - xPosNeg ;
Ry = My - yPosNeg ;
R = sqrt(Rx.^2 + Ry.^2);
Ex = Ex +  K .* qNeg .* Rx  ./ R.^2; % se le suma el Ex por el campo eléctrico pasado, así el campo es afectado por el campo nuevo y el pasado
Ey =  Ey + K .* qNeg .* Ry ./ R.^2;  % se le suma el Ey por el campo eléctrico pasado, así el campo es afectado por el campo nuevo y el pasado
E = sqrt(Ex.^2 + Ey.^2);

%Componentes direccionales de x, y
u = Ex./E;
v = Ey./E;

subplot(3,2,(3:6))
quiver(Mx,My,u,v,'k');
axis([-2 2 -2 2]);
axis equal
%Dibujar la carga Positiva
CargaPos = rectangle('Position',[xPosPos-ancho/2,yPosPos-ancho/2,ancho,ancho],'curvature',[1 1]);
set(CargaPos,'FaceColor',[1 0 0], 'EdgeColor',[0 0 0]);
text(-0.65 ,0.03 ,'+','Color','white','FontSize',50)

title('Dipolo eléctrico ')

hold on
%Dibujar la carga Negativa
CargaNeg = rectangle('Position',[xPosNeg-ancho/2,yPosNeg-ancho/2,ancho,ancho],'curvature',[1 1]);
set(CargaNeg,'FaceColor',[0 0 1], 'EdgeColor',[0 0 0]);
text( 0.425 ,0.065 ,'-','Color','white','FontSize',55)

set(gcf, 'Position', get(0, 'Screensize'))