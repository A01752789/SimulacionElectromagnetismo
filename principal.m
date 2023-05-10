% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

clc; 
syms s lx ly lz;

%% Linea cargada: Recta Vertical
lx(s)= 0;
ly(s) = 0;
lz(s) = s;
linea_recta = LineaCargada(lx, ly, lz, 2, -3, 3, 20);
campo_recta = CampoMag(8, -5, 5, -5, 5, -5, 5);
campo_recta = campo_recta.calcularCampo(linea_recta);

linea_pos_x = (1-(-1)).*rand(6, 1)-1;
linea_pos_y = (1-(-1)).*rand(6, 1)-1;
linea_pos_z = (1-(-1)).*rand(6, 1)-1;
linea_vel_x = (1-(-1)).*rand(6, 1)-1;
linea_vel_y = (1-(-1)).*rand(6, 1)-1;
linea_vel_z = (2-(-2)).*rand(6, 1)-2;

linea_listaP = Particula.empty();
for i=1:6
    linea_listaP(i) = Particula(Vector_(linea_pos_x(i), linea_pos_y(i), ...
        linea_pos_z(i)), Vector_(linea_vel_x(i), linea_vel_y(i), linea_vel_z(i)),...
        -1, 1e-6);
    linea_listaP(i) = linea_listaP(i).calcularTrayectoria(linea_recta, 10, 0.1);
end
campo_recta = campo_recta.graficar(linea_recta,0.5, 0.5);
campo_recta = campo_recta.graficarParticula(linea_listaP);

%% Linea cargada: círculo
lx(s)= cos(s);
ly(s) = sin(s);
lz(s) = 0;
linea_circulo = LineaCargada(lx, ly, lz, 1, 0, 2*pi, 20);
campo_circulo = CampoMag(8, -2, 2, -2, 2, -2, 2);
campo_circulo = campo_circulo.calcularCampo(linea_circulo);
circulo_pos_x = (.5-(-1)).*rand(6, 1)-1;
circulo_pos_y = (.5-(-1)).*rand(6, 1)-1;
circulo_pos_z = (.5-(-1)).*rand(6, 1)-1;
circulo_vel_x = (2-(-2)).*rand(6, 1)-2;
circulo_vel_y = (2-(-2)).*rand(6, 1)-2;
circulo_vel_z = (2-(-2)).*rand(6, 1)-2;

circulo_listaP = Particula.empty();
for i=1:6
    circulo_listaP(i) = Particula(Vector_(circulo_pos_x(i), circulo_pos_y(i), ...
        circulo_pos_z(i)), Vector_(circulo_vel_x(i), circulo_vel_y(i), circulo_vel_z(i)),...
        -1, 1e-6);
    circulo_listaP(i) = circulo_listaP(i).calcularTrayectoria(linea_circulo, 10, 0.1);
end
campo_circulo = campo_circulo.graficar(linea_circulo,0.3, .6);
campo_circulo = campo_circulo.graficarParticula(circulo_listaP);


%% Linea cargada: espiral
syms s lx ly lz;
lx(s)= cos(s);
ly(s) = sin(s);
lz(s) = 0.03*s;
linea_espiral = LineaCargada(lx, ly, lz, 1, -10*pi, 10*pi, 100);
campo_espiral = CampoMag(7, -2, 2, -2, 2, -2, 2);
campo_espiral = campo_espiral.calcularCampo(linea_espiral);

espiral_pos_x = (.5-(-1)).*rand(6, 1)-1;
espiral_pos_y = (.5-(-1)).*rand(6, 1)-1;
espiral_pos_z = (.5-(-1)).*rand(6, 1)-1;
espiral_vel_x = (2-(-2)).*rand(6, 1)-2;
espiral_vel_y = (2-(-2)).*rand(6, 1)-2;
espiral_vel_z = (2-(-2)).*rand(6, 1)-2;

espiral_listaP = Particula.empty();
for i=1:6
    espiral_listaP(i) = Particula(Vector_(espiral_pos_x(i), espiral_pos_y(i), ...
        espiral_pos_z(i)), Vector_(espiral_vel_x(i), espiral_vel_y(i), espiral_vel_z(i)),...
        -1, 1e-6);
    espiral_listaP(i) = espiral_listaP(i).calcularTrayectoria(linea_espiral, 10, 0.1);
end
campo_espiral = campo_espiral.graficar(linea_espiral,0.5, 0.1);
campo_espiral = campo_espiral.graficarParticula(espiral_listaP);

%% Linea cargada: tierra
clear;
syms s lx ly lz;
lx(s)= 6371000*sqrt(1-(0.01*s)^2)*cos(s);
ly(s) = 6371000*sqrt(1-(0.01*s)^2)*sin(s);
lz(s) = 6371000*0.01*s;
linea_esfera = LineaCargada(lx, ly, lz, -3*10^7, -99, 99, 50);
campo_esfera = CampoMag(8, -7000000, 7000000, -7000000, 7000000, -7000000, 7000000);
campo_esfera = campo_esfera.calcularCampo(linea_esfera);

%Protones
proton1 = Particula(Vector_(6*10^6,6*10^6,6*10^6),Vector_(-0.1875*10^9,-0.1875*10^9,-0.1875*10^9),1.6*10^-19,1.67*10^-27);
proton1 = proton1.calcularTrayectoria(linea_esfera,200,10^-4);
proton2 = Particula(Vector_(-7*10^6,-5*10^6,2*10^6),Vector_(0.6*10^9,0,0),1.6*10^-19,1.67*10^-27);
proton2 = proton2.calcularTrayectoria(linea_esfera,200,10^-4);
proton3 = Particula(Vector_(-7*10^6,2*10^6,0),Vector_(0.75*10^9,0,0),1.6*10^-19,1.67*10^-27);
proton3 = proton3.calcularTrayectoria(linea_esfera,200,10^-4);
proton4 = Particula(Vector_(-6*10^6,4*10^6,2*10^6),Vector_(0.6*10^9,0,0),1.6*10^-19,1.67*10^-27);
proton4 = proton4.calcularTrayectoria(linea_esfera,200,10^-4);

%Electrones
electron1 = Particula(Vector_(6*10^6,6*10^6,6*10^6),Vector_(-0.75*10^6,-0.75*10^6,-0.75*10^6),-1.6*10^-19,9.11*10^-31);
electron1 = electron1.calcularTrayectoria(linea_esfera,200,5.5*10^-7);
electron2 = Particula(Vector_(6*10^6,6*10^6,6*10^6),Vector_(-0.1875*10^6,-0.1875*10^6,-0.1875*10^6),-1.6*10^-19,9.11*10^-31);
electron2 = electron2.calcularTrayectoria(linea_esfera,200,5.5*10^-7);
electron3 = Particula(Vector_(-6*10^6,-5*10^6,3*10^6),Vector_(1*10^6,0.1875*10^6,-0.1875*10^6),-1.6*10^-19,9.11*10^-31);
electron3 = electron3.calcularTrayectoria(linea_esfera,200,4.375*10^-7);
electron4 = Particula(Vector_(-6*10^6,-3*10^6,-3*10^6),Vector_(1*10^6,-0.1875*10^6,-0.1875*10^6),-1.6*10^-19,9.11*10^-31);
electron4 = electron4.calcularTrayectoria(linea_esfera,200,2.125*10^-7);

%Graficación simulación/Nota: Correr desde aquí si se integra el workspace
%de particulas
listaP = [proton1 proton2 proton3 proton4 electron1 electron2 electron3 electron4];
campo_esfera = campo_esfera.graficar(linea_esfera,10^6,0);
campo_esfera = campo_esfera.graficarParticula(listaP);
