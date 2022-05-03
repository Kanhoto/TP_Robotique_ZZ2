%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 		  Simulation d'un robot de type SCARA 2D.          %%
%%        TP Modélisation et Commande des Robots                   %%
%%                                                                 %% 
%% Fonction qui définit le modèle géométrique inverse d'un robot   %%
%% planaire 2ddl, i.e. permet d'obtenir les coordonnées            %%
%% articulaires du robot en fonction des configurations x,y        %%  
%% que fait l'effecteur du robot.                                  %%
%% NB : cette fonction est appelée par le programme                %%  
%% SimulationRobotSCARA.m.                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Theta = ModeleGeometriqueInverse(Position)
global l1 l2
global theta1 theta2

global Z1 Z2 A B C W
x = Position(1);
y = Position(2);
angleLimite = asin(y/x);

%Les consignes x et y de l'effecteur doivent impérativement etre 
%contenues dans "l'espace de travail" du robot 
xmax = cos(angleLimite) * (l1 + l2);
ymax = sin(angleLimite) * (l1 + l2);
xmin = cos(angleLimite) * (l1 - l2);
ymin = sin(angleLimite) * (l1 - l2);

if (x > xmax || x < xmin || y > ymax || y < ymin || y < 0)
    warning(['Attention la consigne (x,y) est en d''hors de l''espace attiegnable par le robot']);
end 

Z1 = -l1;
Z2 = 0;
X = y;
Y = -x;
W = l2;
A = 2*(Y*Z1+X*Z2);
B = 2*(X*Z1-Y*Z2);
C = W^2-X^2-Y^2-Z1^2-Z2^2;

sintheta1 = A*C+(B*sqrt(A^2+B^2-C^2))/(A^2+B^2);
costheta1 = B*C+(A*sqrt(A^2+B^2-C^2))/(A^2+B^2);
tantheta1 = sintheta1/costheta1;


theta1 = atan(tantheta1);
theta2 = asin((X*cos(theta1)+Y*sin(theta1)+Z1)/W);


Theta=[theta1 theta2];
