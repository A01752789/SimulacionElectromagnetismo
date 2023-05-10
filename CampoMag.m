% Frida Cano Falcón                     A01752953
% Luis Humberto Romero Pérez 	        A01752789	
% Hortencia Alejandra Ramírez Vázquez 	A01750150
% David Damián Galán 			        A01751655
% Miguel Ángel Juárez Dorantes          A01753328

classdef CampoMag
   properties
       mesh; % Malla
       componentes; % Vectores del campo magnético 
       min_x;
       max_x;
       min_y;
       max_y;
       min_z;
       max_z;
   end
   methods
       % Constructor de CampoMag, genera la malla
       function campo = CampoMag(n, xmin, xmax, ymin, ymax, zmin, zmax)
           X=zeros(n);
           Y=zeros(n);
           Z = zeros(1,n);
           campo.min_x=xmin+(xmin*0.1);
           campo.max_x=xmax+(xmax*0.1);
           campo.min_y=ymin+(ymin*0.1);
           campo.max_y=ymax+(ymax*0.1);
           campo.min_z=zmin+(zmin*0.1);
           campo.max_z=zmax+(zmax*0.1);
           %Malla para X y Y
           for i=1:n
               for j=1:n
                   X(i,j)=xmin+((j-1)*((xmax - xmin)/(n-1)));
                   Y(i,j)=ymax-((i-1)*((ymax - ymin)/(n-1)));
               end
           end
           %Malla para Z
           for i=1:n
               Z(i) = zmax - (i - 1) * (zmax - zmin)/(n-1);
           end
           campo.mesh = Vector_.empty; % Crea matriz vacia de vectores para la malla
           %Creando matriz de malla
           for i = 1:n
               for j = 1:n
                   for k = 1:n
                       campo.mesh(i, j, k) = Vector_(X(i, j), Y(i, j), Z(k));
                   end
               end
           end
           campo.componentes = Vector_.empty; % Crea matriz vacia de vectores para las componentes
       end
       
        %Metodo que calcula el campo de la linea cargada en cada punto de
        %la malla
       function campo = calcularCampo(campo, linea)
           n = size(campo.mesh);
           n = n(1);
           for i = 1:n
               for j = 1:n
                   for k = 1:n
                       %Llamada a la función calcularCampoPunto
                       campo.componentes(i,j,k) = calcularCampoPunto(linea, campo.mesh(i,j,k));
                   end
               end
           end
       end
       
       % Método para graficar el campo
       function campo = graficar(campo,linea, escala, opacidad)
           %hold off;
           n = size(campo.mesh);
           n = n(1);
           normas = zeros(n,n,n);
           op = zeros(n,n,n);
           
           figure;
           %Gráfica de la linea cargada
           fplot3(linea.lx, linea.ly, linea.lz,[linea.min_s linea.max_s],'r','LineWidth',2);
           xlabel("X");
           ylabel("Y");
           zlabel("Z");
           axis equal;
           xlim([campo.min_x campo.max_x]);
           ylim([campo.min_y campo.max_y]);
           zlim([campo.min_z campo.max_z]);
           
           %Graficar Campo
           hold on;
           
           %Matriz con las normas del campo magnético
           for i=1:n
                for j=1:n
                    for k=1:n
                        normas(i,j,k) = norm([campo.componentes(i,j,k).x ...
                            campo.componentes(i,j,k).y ...
                            campo.componentes(i,j,k).z]);
                    end
                end
           end
           
           %Valor máximo de normas del campo magnético
           norMax = max(max(max(normas)));
           
           for i=1:n
                for j=1:n
                    for k=1:n
                        %Opacidad
                        op(i,j,k)= 1*(normas(i,j,k)/(norMax*opacidad));
                        if op(i,j,k) > 1
                            op(i,j,k) = 1;
                        end
                        
                        if normas(i,j,k) == 0
                            normas(i,j,k) = 1;
                        end
                        
                        %Graficando campo magnético
                        quiver3(campo.mesh(i,j,k).x,campo.mesh(i,j,k).y,campo.mesh(i,j,k).z...
                            ,escala*(campo.componentes(i,j,k).x)/normas(i,j,k),...
                            escala*(campo.componentes(i,j,k).y)/normas(i,j,k),...
                            escala*(campo.componentes(i,j,k).z)/normas(i,j,k),...
                            'LineWidth',1.5,'MaxHeadSize',1,'AutoScale','off', ...
                            'Color',[1-op(i,j,k) 1-op(i,j,k) 1-op(i,j,k)]);
                    end
                end
           end
           view(45,45);
       end
       %Funcion para graficar la trayectoria de particulas
       function campo = graficarParticula(campo,particulas)
           %Creacion de linea y marcador para cada particula
           size = length(particulas);
           for i =1:size
               f(i)= animatedline('Marker','o','Color',[particulas(i).color(1) particulas(i).color(2) ...
                   particulas(i).color(3)],'MarkerSize',5,'MarkerFaceColor',[particulas(i).color(1) ...
                   particulas(i).color(2) particulas(i).color(3)]);
               g(i)= animatedline('Linestyle','-','Color',[particulas(i).color(1) ...
                   particulas(i).color(2) particulas(i).color(3)],'LineWidth',2.5);
           end
           pasos = length(particulas(1).posicion);
           %Graficar y animar cada particula
           for i=1:pasos
               for j=1:size
                    clearpoints(f(j))
                    addpoints(f(j),particulas(j).posicion(i).x,particulas(j).posicion(i).y,particulas(j).posicion(i).z)
                    addpoints(g(j),particulas(j).posicion(i).x,particulas(j).posicion(i).y,particulas(j).posicion(i).z)
                    drawnow
               end
           end
       end
   end
end