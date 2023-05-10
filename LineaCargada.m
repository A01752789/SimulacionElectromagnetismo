% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

classdef LineaCargada
    properties
        %Vector de la función paramétrica
        s, lx, ly, lz;
        dlx, dly, dlz; 
        %Corriente
        I;  
        %Limites del parametro s
        min_s, max_s; 
        integral;
    end
    methods
        function linea = LineaCargada(lx, ly, lz, I, min_s, max_s, integral)
            linea.lx = lx;
            linea.ly = ly;
            linea.lz = lz;
            linea.I = I;
            linea.min_s = min_s;
            linea.max_s = max_s;
            
            %Derivadas de línea parametrizada
            linea.dlx = diff(lx);
            linea.dly = diff(ly);
            linea.dlz = diff(lz);
            
            linea.integral = integral;
        end
    end
end