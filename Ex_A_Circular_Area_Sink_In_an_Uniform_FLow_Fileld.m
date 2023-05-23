clc
clear all
close all
format long g

%% Define parameters

k=5;                 %% Permeability
H=35;                % Aquifer Thickness
grad=-0.01;          % Aquifer Gradient
b=0;                 % Base Elevation
h_ref=40;            % Reference Point head 
angle=0;    
z_ref=200+200*i;     % Reference Point Coordinate
z0=100+100*i;          %% Center of the Circular Area sink
zc=125+125*i;          %% Any point over the Circular Area Sink
R=abs(zc-z0);
N=-0.5;
%%

%% Aquifer Constant paq determination

%% Reference Point Calculation:::
r=abs(z_ref-z0);

F_AS = Areal_Sink_Circular(N,R,r);
Dis_Pot=Discharge_potential(b,h_ref,k,H); 

paq=Dis_Pot-F_AS;


 
 
 
py=0;                  % arbitrary variable defined
for y=0:1:200;
    py=py+1;
    px=0;              % arbitrary variable defined
    for x=0:1:200;       
        px=px+1;
        z=x+i*y; 
        r=abs(z-z0);
        F_AS = Areal_Sink_Circular(N,R,r);
        Dis_Pot=paq+F_AS;
        Head(py,px)=Head_Conversion(k,H,Dis_Pot);          
            
        end
    end       

Head;

[cc,hh]=contour(Head);
clabel(cc,hh);
xlabel('x');
ylabel('y');
 
 
 
 
 
 











