% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

classdef Vector_
    properties
        x = 0; %Componente x
        y = 0; %Componente y
        z = 0; %Componente z
    end
    methods
        %Constructor de la clase Vector_
        function v = Vector_(x, y, z)
            if(nargin == 0)
                v.x = 0;
                v.y = 0;
                v.z = 0;
            else
                v.x = x;
                v.y = y;
                v.z = z;
            end
        end
        %Funcion de producto cruz entre dos objetos Vector_
        function v = cruz(a,b)
            v = Vector_();
            
            v.x = ((b.z*a.y)-(b.y*a.z));
            v.y = -((b.z*a.x)-(b.x*a.z));
            v.z = ((b.y*a.x)-(b.x*a.y));
        end   
        %Multiplicar un numero por un vector 
        function v = mtimes(entero,vec)
            v = Vector_(entero*vec.x, entero*vec.y, entero*vec.z);
        end 
        %Sumar dos objetos Vector_ 
        function v = plus(vec1,vec2)
            v = Vector_(vec1.x+vec2.x, vec1.y+vec2.y, vec1.z+vec2.z);
        end 
            
    end
end