% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

function v = calcularCampoPunto(linea, punto)
   syms s rx ry rz fx fy fz;
   %disp("Calculando campo...");
   %Calculo vector r
   r = [(punto.x - linea.lx) (punto.y - linea.ly) (punto.z - linea.lz)];
   r = r(s);
   rx(s) = r(1);
   ry(s) = r(2);
   rz(s) = r(3);
   
   %Calculo producto cruz de vector r y derivada de la linea
   cruz1 = [((rz*linea.dly)-(ry*linea.dlz)) -((rz*linea.dlx)-(rx*linea.dlz)) ...
       ((ry*linea.dlx)-(rx*linea.dly))];
   
   %Calculo de funciones a integrar con la Ley de Biot-Savart
   funciones_integrandos = (linea.I*(10^(-7))*cruz1)/(norm(r)^3);
   funciones_integrandos = funciones_integrandos(s);
   fx(s) = funciones_integrandos(1);
   fy(s) = funciones_integrandos(2);
   fz(s) = funciones_integrandos(3);
   
   %Calculo de componentes del campo magnético con método de simpson
   try
       vx = intSimpson(fx, linea.min_s, linea.max_s, linea.integral);
       vy = intSimpson(fy, linea.min_s, linea.max_s, linea.integral);
       vz = intSimpson(fz, linea.min_s, linea.max_s, linea.integral);
              
   catch
       vx = 0;
       vy = 0;
       vz = 0;  
   end
   v = Vector_(vx, vy, vz);
end
