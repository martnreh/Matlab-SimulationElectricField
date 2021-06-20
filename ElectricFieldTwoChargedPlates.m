clear; close all; clc;

%RETO AVANCE 2 PARTE 1

%Adrian Martin Hernandez Barrientos 	A01570656
%Jose Gustavo Buenaventura Carreon      A01570891 
%Jose Arnoldo Rositas Salinas 			A00829760
%Axel Canales Rodriguez 				A01284296
%Ana Helena Garcia Lopez 				A01197782
%Santiago Minga Martinez 				A00830698

%Crear grid como espacio donde estan las cargas
N=40; %cantidad de flechas o flujo en el campo
Xmin=-5;  Xmax=+5;
Ymin=-5;  Ymax=+5;
x=linspace(Xmin,Xmax,N); 
y=linspace(Ymin,Ymax,N);
[Mx,My]=meshgrid(x,y);

%Inicializar variables constantes 
Ex_T= 0;
Ey_T= 0;
xUbiNeg = 1;
yUbiNeg = [];
xUbiPos = -1;
yUbiPos = 0;

%Valor de las cargas para ambas placas
q = 50;
qNeg = -q; %asignar el valor de la carga para negativos
qPos = q; %asignar el valor de la carga para positivos

%Declarar la longitud en unidades de las placas parelelas
longitudPlaca = 4;

%Declarar variables de la cargas
intervalo = 0.1; %espacio en eje y entre cada carga
K = 9 * 10^9; 
n = 0; %cantidad de cargas negativas
p = 0; %cantidad de cargas positivas
ancho = 0.4; %ancho de las cargas



%%%%%%%% Placa Negativa
%For que repite la obtención del Campo Eléctrico por cada carga negativa en la
%longitud de la placa
for i = round((-longitudPlaca/2),1):intervalo:round((longitudPlaca/2),1)
    n = n+1;
    yUbiNeg(n) = i;
    Rx = Mx - xUbiNeg; 
    Ry = My - yUbiNeg(n) ;
    R = sqrt(Rx.^2 + Ry.^2);
    
    ExNeg = K .* qNeg .* Rx  ./ R.^2; 
    EyNeg = K .* qNeg .* Ry ./ R.^2;
    Ex_T = Ex_T+ExNeg;
    Ey_T = Ey_T+EyNeg;
   
end

%%%%%%%% Placa Positiva
%For que repite la obtención del Campo Eléctrico por cada carga positiva en la
%longitud de la placa
for i = round((-longitudPlaca/2),1):intervalo:round((longitudPlaca/2),1)
    p = p+1;
    yUbiPos(p) = i;
    Rx = Mx - xUbiPos; 
    Ry = My - yUbiPos(p) ;
    R = sqrt(Rx.^2 + Ry.^2);
    
    ExPos = K .* qPos .* Rx  ./ R.^2; 
    EyPos = K .* qPos .* Ry ./ R.^2;
    Ex_T = Ex_T+ExPos;
    Ey_T = Ey_T+EyPos;
   
end


%Función quiver para graficar las flechas en el grid y ajustar titulos y
%axis
graf = quiver(Mx,My,Ex_T,Ey_T,1.1);
title('Par de Placas con diferente signo');xlabel('X');ylabel('Y');legend('Campo electrico');

set(graf, 'Color', [0.4940 0.1840 0.5560])
axis([(-longitudPlaca/2 - 1) (longitudPlaca/2 + 1) (-longitudPlaca/2 - 1) (longitudPlaca/2 + 1)]);
axis equal


%For para graficar todas las cargas negativas circulares para dibujar la
%placa
for i = 1:n
    CargaNeg = rectangle('Position',[xUbiNeg - ancho/2,yUbiNeg(i) - ancho/2,ancho,ancho/2],'curvature',[1 1]);
    set(CargaNeg,'FaceColor',[0 0.4470 0.7410], 'EdgeColor',[0 0 0]);
    text( xUbiNeg-.05,yUbiNeg(i)-.1 ,'-','Color','white','FontSize',25)
end

%For para graficar todas las cargas positivas circulares para dibujar la
%placa
for i = 1:p
    CargaPos = rectangle('Position',[xUbiPos - ancho/2,yUbiPos(i)-ancho/2,ancho,ancho/2],'curvature',[1 1]);
    set(CargaPos,'FaceColor',[0.6350 0.0780 0.1840], 'EdgeColor',[0 0 0]);
    text( xUbiPos-.05,yUbiPos(i)-.12 ,'+','Color','white','FontSize',20)
end

%legend([CargaNeg CargaPos],"Carga Negativa" "Carga Positiva")
set(gcf, 'WindowState', 'maximized');
