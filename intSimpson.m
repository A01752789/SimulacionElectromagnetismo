% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

%Método de Integración por regla de Simpson
function A = intSimpson(f, a, b, n)

deltax = (b-a)/n; %Longitud de las particiones
A=0;
x = a; %x incial

for i=0:n
    %Para x inicial y x final
    if i == 0 || i == n
        A = A + f(x);
        
    %Para x par
    elseif mod(i,2) == 0 && i ~= 0 && i ~= n 
        A = A + (2*f(x));
        
    %Para x impar
    elseif mod(i,2) ~= 0 && i ~= 0 && i ~= n 
        A = A + (4*f(x));
    end
  
    x = x + deltax;
end

%Aproximación de la integral
A = (deltax/3)* double(A);
end