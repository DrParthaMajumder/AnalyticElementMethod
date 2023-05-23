%% A Solution to Strack Formulation using Parabolic Doublet for Traingular Element::
%% In this program a Traingular element is considered. Three line doublets are placed along the three sides of the Traingle.
%% This Is the IMp CODE
clc
clear all
close all
format long g
syms paq;               % Aquifer Constant 
syms s1;                % Strength at Node 1
syms s2;                % Strength at Node 2 
syms s3;                % Strength at Node 3
syms sc1;               % Strength at the Middle point of Doublet 1              
syms sc2;               % Strength at the Middle point of Doublet 2  
syms sc3;               % Strength at the Middle point of Doublet 3

%% Important Program:::
% Total Number of Unknowns is 7



%% <DEFINE  Cooordinates of a Traingle>
z1=50+50*i;
z2=75+93*i;
z3=100+50*i;

%% DEFINE PARAMETERS>
k=5;       %  Permeability Outside the Traingular Domain
k1=0;    %  Permeability Inside the Traingular Domain
Perm_Factor=(k1-k)/k;
H=20;       % Aquifer Thickness
grad=-0.01; % Aquifer Gradient
b=0;        % Base Elevation
h_ref=25;   % Reference Point head 
angle=0;    % Uniform FLow Direction
z_ref=200+200*i;     % Reference Point Coordinate

%%
%% Equation at Reference Point
z=z_ref;
F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);                               %% Uniform FLow Contribution
Dis_Pot=Discharge_potential(b,h_ref,k,H);                                    %%  Discharge potential at Reference Point
paq=Dis_Pot-F_Uniform_FLow; 
break_point=1;




%%
%% Contour Plot
py=0;            % arbitrary variable defined
for y=0:1:200;
    py=py+1;
    px=0;        % arbitrary variable defined
    for x=0:1:200;       
        px=px+1;
        z=x+i*y;             
        F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
        Dis_Pot=paq+F_Uniform_FLow;
    Head(py,px)=Head_Conversion(k,H,Dis_Pot);       
    end       
end
Head;

[cc,hh]=contour(Head);
clabel(cc,hh);

clabel(cc,hh);
xlabel('x(m)');
ylabel('y(m)');
%title('Plot of Head Contour: Strack plot');

check=Head(150,150)
break_point=100;

