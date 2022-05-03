%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 		  Simulation d'un robot de type SCARA 2D.           %%
%%                                                                  %%
%%  Gère tous les évenement affectant la fenetre GUI (Graphical     %%
%%  User Interface)                                                 %%
%%  NB : cette fonction est appelée par le programme                %%
%%  SimulationRobotSCARA.m.                                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = GestionGUI(OP,action)

global PushBut1 PushBut2 PushBut3
global x1 y1 x2 y2
global theta1 theta2
global fig
global T
global r_last psi_last Down
global rmax rmin
global xi yi xf yf
global RadToDeg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if OP<3 & action~=1
    set(PushBut1,'BackgroundColor',[0.8 0.8 0.8])
    set(PushBut2,'BackgroundColor',[0.8 0.8 0.8])
    set(PushBut3,'BackgroundColor',[0.8 0.8 0.8])
    set(gcf,'WindowButtonMotionFcn','')
    set(gcf,'WindowButtonDownFcn','')
    set(gcf,'WindowButtonUpFcn','')
end
 
%%%%%%%%%%%%%%%%%%
if OP==1		% Option 1 
    r=sqrt(x2^2+y2^2);
    psi=atan2(y2,x2);

    if action==0
        set(PushBut1,'BackgroundColor',[0.6 0.6 0.6]);
        %Initialisations nécessaires pour pouvoir utiliser la souris
        set(gcf,'WindowButtonDownFcn','GestionGUI(1,1)');
        set(gcf,'WindowButtonMotionFcn','');
        set(gcf,'WindowButtonUpFcn','');
        %% Mettre à jour les coordonnées du robot et l'afficher
        ModeleGeometriqueInverse([x2,y2]);
        ModeleGeometriqueDirect([theta1, theta2]);
        SetAffichage;
        %%
        set(gcf,'WindowButtonDownFcn','GestionGUI(1,1)')
        r_last=r;
        psi_last=psi;
    else
        step=40; % Nombre d'incrément entre la position initiale du robot et la position qu'il doit atteindre,
        % cette position finale est donnée en utilisant la souris.
        cp=get(gca,'CurrentPoint');
        set(gcf,'WindowButtonDownFcn','')
        x=cp(1,1);
        y=cp(1,2);
        r=sqrt(x^2+y^2);
        psi=atan2(y,x);
        if r<=rmax & r>=rmin & psi>=0 & psi<=pi
            FLIP=sign((psi-pi/2)*(psi_last-pi/2));	%Valeur négative si le robot doit tourner
            if FLIP==1;
                Dr=(r-r_last)/step;
                Dpsi=(psi-psi_last)/step;
                for k=1:step;                       %Animation du robot de sa position courante vers une position finale (consigne)
                    x=(r_last+k*Dr)*cos(psi_last+k*Dpsi);
                    y=(r_last+k*Dr)*sin(psi_last+k*Dpsi);
                    ModeleGeometriqueInverse([x,y]);
                    ModeleGeometriqueDirect([theta1, theta2]);
                    SetAffichage;
                end
            else
                theta1_last=theta1;
                theta2_last=theta2;

                ModeleGeometriqueInverse([r*cos(psi),r*sin(psi)]);

                theta1_goal=theta1;
                theta2_goal=theta2;

                Deltatheta1=(theta1_goal-theta1_last)/step;
                Deltatheta2=(theta2_goal-theta2_last)/step;

                for n=1:step;
                    theta1=theta1_last+n*Deltatheta1;
                    theta2=theta2_last+n*Deltatheta2;
                    ModeleGeometriqueDirect([theta1, theta2]);
                    SetAffichage;
                end
            end
            r_last=r;
            psi_last=psi;
        end
        set(gcf,'WindowButtonDownFcn','GestionGUI(1,1)');
    end

elseif OP==2  
    disp(' Mettez l''Aide de votre programme ici.....');
    disp(' .....');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
