%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 		  Simulation d'un robot de type SCARA 2D.          %%
%%        TP Modélisation et Commande des Robots                   %% 
%%                                                                 %% 
%% Fonction qui définit le modèle géométrique direct d'un robot    %%
%% planaire 2ddl, i.e., les positions (xi,yi) des différentes      %%
%% articulations du robot en fonction de leurs coordonnées         %%
%% articulaires.                                                   %% 
%% NB : cette fonction est appelée par le programme                %%  
%% SimulationRobotSCARA.m.                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PositionEffecteur = ModeleGeometriqueDirect(Theta)
global x1 y1 x2 y2
global l1 l2 
global DegToRad RadToDeg
global theta1 theta2
global theta1_old theta2_old
global L1 L2 Link1 Link2
global S1 S2 S3 S4 					

theta1 = Theta(1);
theta2 = Theta(2);

TM01 = [cos(theta1), -sin(theta1), 0, 0; sin(theta1), cos(theta1), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
TM12 = [cos(theta2), -sin(theta2), 0, l1; sin(theta2), cos(theta2), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
TM02 = TM01 * TM12;

x2 = TM02(1,1)*l2 + TM02(1,4);
y2 = TM02(2,1)*l2 + TM02(2,4);

L1 = TM01 * Link1;
L2 = TM02 * Link2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S1=['\theta_{1} = ' num2str(0.01*round(100*theta1)*RadToDeg,3) '^o'];
S2=['X_{T} =' num2str(0.01*round(100*x2),3) ''];
S3=['\theta_{2} = ' num2str(0.01*round(100*theta2)*RadToDeg,3) '^o'];
S4=['Y_{T} = ' num2str(0.01*round(100*y2),3) ''];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PositionEffecteur = [x2 y2];
