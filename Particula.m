classdef Particula
    properties
        %Matrices de objetos Vector_ para la posicion, velocidad y
        %aceleracion de la particula
        posicion = Vector_.empty()
        velocidad = Vector_.empty()
        aceleracion = Vector_.empty()
        %Carga y masa de la particula
        carga
        masa
        color
    end
    methods
        %Constructor de la clase Particula
        function p = Particula(pos0,v0,q,m)
            if(nargin == 0)
                carga = 1;
                masa = 1;
            else
                p.posicion(1) = pos0;
                p.velocidad(1) = v0;
                p.carga = q;
                p.masa = m;
                p.color = [rand rand rand]; 
            end
        end
        %Calculo de la trayectoria de la particula
        function p = calcularTrayectoria(p,linea,n,tmax)
            %Calcular campo en el punto inicial
            campo = calcularCampoPunto(linea, p.posicion(1));
            %Calcular aceleracion inicial
            p.aceleracion(1) = (p.carga/p.masa)*cruz(p.velocidad(1),campo);
            %Calcular delta t
            delta = tmax;
            %delta = tmax / n;
            %Ciclo para calcular la trayectoria mediante euler mejorado
            for i=2:n
                %Posicion, velocidad, campo y aceleracion temporales
                %para calcular los datos en el siguiente punto (euler) 
                p_euler = p.posicion(i-1) + (delta*p.velocidad(i-1));
                v_euler = p.velocidad(i-1) + (delta*p.aceleracion(i-1));
                campo_euler = calcularCampoPunto(linea, p_euler);
                a_euler = (p.carga/p.masa)*cruz(v_euler,campo_euler);
                %Posicion, velocidad, campo y aceleracion en el siguiente
                %punto de la trayectoria
                p.posicion(i) = p.posicion(i-1) + (delta*0.5)*(v_euler + p.velocidad(i-1));
                p.velocidad(i) = p.velocidad(i-1) + (delta*0.5)*(a_euler + p.aceleracion(i-1));
                campo = calcularCampoPunto(linea, p.posicion(i));
                p.aceleracion(i) = (p.carga/p.masa)*cruz(p.velocidad(i),campo);
            end
        end 
    end
end