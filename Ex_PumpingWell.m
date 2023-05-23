clc
clear all
close all
format short
syms paq;   % Unknown Aquifer Constant

%% Define Parameters
por=0.35;                  % Porosity of the soil
k=25;                      % Permeability Outside the Traingular Domain  unit--->m/d
H=10;                      % Aquifer Thickness
b=0;                       % Base Elevation
h_ref=25;                  % Reference Point head 
angle=0;                   % Uniform FLow Direction
z_ref=1000+1000*i;         % Reference Point Coordinate
Q=3000;
zw=150+150*i;

%% Equation at Reference Point
z=z_ref;                             
F_Well = Well_Fun(Q,z,zw);
Dis_Pot=Discharge_potential(b,h_ref,k,H);                                    %%  Discharge potential at Reference Point
paq=Dis_Pot-F_Well;

%% Contour Plot
py=0;                        % Arbitrary variable defined
for y=0:1:300;
    py=py+1;
    px=0;                    % Arbitrary variable defined
    for x=0:1:300;       
        px=px+1;
        z=x+i*y;   
        r=abs(z-zw);
        %F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
        if r>3
        F_Well = Well_Fun(Q,z,zw);

        Dis_Pot=paq+F_Well;
    Head(py,px)=Head_Conversion(k,H,Dis_Pot);   
      
        else
         Head(py,px)=NaN; 
        end;
    end       
end
Head;

[cc,hh]=contour(Head);
clabel(cc,hh);
xlabel('x(m)');
ylabel('y(m)');
grid on
title('Plot of Head Contour: Strack plot');

%.................................................................................................................%%
