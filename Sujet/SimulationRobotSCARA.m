%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  TP Modélisation et Commande des Robots                                               %%
% %                                                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear all, close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Définition des variables globales%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global l1 l2 % Dimensions des bras
global x1 y1 x2 y2   % Positions opérationnelles des articulations respectives du robot
global theta1 theta2 % Angles respectifs des articulations du robot
global PushBut1 PushBut2 PushBut3 % Pointeurs sur les boutons poussoirs
global S1 S2 S3 				% Pointeurs sur les chaines de caractères
global L1 L2 Link1 Link2		% Matrices pour dessiner le robot SCARA
global C1 C2     	  % Pointeurs pour dessiner des cercles sur les articulations
global J1 J2          % Pointeurs pour dessiner des "plus" sur les articulations
global dis            %	Pointeurs sur des textes à afficher
global pF1 pF2 		  % Pointeurs sur les objets à colorier
global rmax rmin      % Rayon max et rayon min atteignable par l'effecteur du robot 
global DegToRad RadToDeg % Les constantes
global fig % Pointeur sur la figure courante  
global T 
%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Définition des constantes%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
DegToRad=pi/180;
RadToDeg=180/pi;

l1=8.625;			% Longueur du bras '1'
l2=6.125;	    		% Longueur du bras '2'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialisation des variables (état initial du robot) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta1= 90*DegToRad;
theta2 = 90*DegToRad;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialisation de la fenêtre d'affichage :%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig=gcf; % Récupération du pointeur de la figure courante

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Définition des boutons poussoirs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P1 = ['GestionGUI(1,0)'];
PushBut1=uicontrol(fig,'Style','pushbutton','Units','normalized', ...
   	'Position',[0.10 .02 0.17125 0.05],'string','Simulation', ...
    'Callback',P1,'visible','on','BackgroundColor',[0.8 0.8 0.8]);

P2 = ['GestionGUI(2,0)'];	
PushBut2=uicontrol(fig,'Style','pushbutton','Units','normalized', ...
   	'Position',[0.5025 .02 0.17125 0.05],'string','Aide', ...
    'Callback',P2,'visible','on','BackgroundColor',[0.8 0.8 0.8]);  

P3 = ['close;'];	
PushBut3=uicontrol(fig,'Style','pushbutton','Units','normalized', ...
   	'Position',[0.70375 .02 0.17125 0.05],'string','Fermer', ...
    'Callback',P3,'visible','on','BackgroundColor',[0.8 0.8 0.8]);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InitialisationAffichage; %Fonction pour initialiser l'interface d'affichage

