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
k=100;       %  Permeability Outside the Traingular Domain
k1=20;    %  Permeability Inside the Traingular Domain
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

[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );                    %%  [fm1,gm1,pm1] Parameter Calculated using "Paraboloc_Line_Doublet_Strack"  Function      
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));  %%  Contribution of Potential from Doublet 1 at Reference point(z_ref)

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));  %%  Contribution of Potential from Doublet 2 at Reference point(z_ref)

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));  %%  Contribution of Potential from Doublet 3 at Reference point(z_ref)

Dis_Pot=Discharge_potential(b,h_ref,k,H);                                    %%  Discharge potential at Reference Point

eq1=paq+F_Uniform_FLow+S_D1+S_D2+S_D3-Dis_Pot;                               %%  Equation 1 at reference Point: 
                                                                             %% Dis_Pot_at_ref= Total Contribution from all the element + aquifer Constant 


Brk_Pt=1;



%% There are six more control Points 

%% DISCHARGE POTENTIAL ARE CALCULATED AT VERY CLOSE POINT TO AVOID DISCONTINUITY:::
%% 

 zp1=z1+(-0.000001-0*i);     %% Node 1 ( Very Close Point near z1; just Outside the inhomogeneity Domain)
 zp2= z2+(0+0.00001*i);      %% Node 2 ( Very Close Point near z2; just Outside the inhomogeneity Domain
 zp3= z3+ (0.000001-0*i);    %% Node 3 ( Very Close Point near z3; just Outside the inhomogeneity Domain
 
 zmid1=((z1+z2)/2)+(-0.00001+0*i);       %% _Mid_Point1
 zmid2=((z2+z3)/2)+(+0.00001+0*i);       %%  Mid Point2
 zmid3=((z3+z1)/2)+(0-0.0000*i);         %%  Mid Point3
 zp=[zp1, zp2, zp3,zmid1, zmid2, zmid3 ]; %% Control Points sets 
 s_Value=[s1,s2,s3, sc1, sc2, sc3];       %% Jump Value Set 
  
 %% THIS FOR LOOP WILL GENERATE SIX EQUATION AT SIX Points (Three end Nodes and Three Mid Points)--> See array zp and array s_Value 
 
  for ii=1:1:6
      z=zp(ii);                                                                 %% Control Points                 
      
F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));     %% Doublet 1 Contribution at Control Point

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );                       %% Doublet 2 Contribution at Control Point
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );                       %% Doublet 3 Contribution at Control Point
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));
eqn(ii)=Perm_Factor*(paq+F_Uniform_FLow+S_D1+S_D2+S_D3)-s_Value(ii);            %% Using Equation:: s=((k1-k)/k)*(Total contribution of Discharge_potential At Control Point)       
  end

sol=solve(eq1,eqn(1),eqn(2),eqn(3),eqn(4),eqn(5),eqn(6)); 
    paq=double(sol.paq);    
    s1=double(sol.s1);
    s2=double(sol.s2);
    s3=double(sol.s3);
    sc1=double(sol.sc1);
    sc2=double(sol.sc2);
    sc3=double(sol.sc3);

%% CONTOUR PLOT OF HEAD [ head is poltted in two parts: (1)One part is for inhomogeneity domain. (2) Other part is for Outside of Inhomogeneity Domain]
py=0;            % arbitrary variable defined
for y=0:1:120;
    py=py+1;
    px=0;        % arbitrary variable defined
    for x=0:1:120;       
        px=px+1;
        z=x+i*y;   
        if ((-43*x+25*y+900)<=0)& ((43*x+25*y-5550)<=0)& ((50*y-2500)>=0)      %% Using Equations of  every lines of the Traingle:: This part is for Inhomogenetity domain
                        
%       if ((-43*x+25*y+900)<0)& ((43*x+25*y-5550)<0)& ((50*y-2500)>0)              
%         F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
% [fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
% S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));
% 
% [fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
% S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));
% 
% [fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
% S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));
% 
% Dis_Pot=paq+F_Uniform_FLow+S_D1+S_D2+S_D3;

%    Head(py,px)=Head_Conversion(k1,H,Dis_Pot);
    Head(py,px)=NaN;
        else                                                               % THIS PART IS FOR OUTSIDE THE INHOMOGENEITY DOMAIN
             F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));

Dis_Pot=paq+F_Uniform_FLow+(S_D1)+(S_D2)+(S_D3);
   Head(py,px)=Head_Conversion(k,H,Dis_Pot);
%          Head(py,px)=NaN; 
           end
    end       
end
Head;

py=0;            % arbitrary variable defined
for y=0:1:120;
    py=py+1;
    px=0;        % arbitrary variable defined
    for x=0:1:120;       
        px=px+1;
        z=x+i*y;   
%         if ((-43*x+25*y+900)<=0)& ((43*x+25*y-5550)<=0)& ((50*y-2500)>=0)      %% Using Equations of  every lines of the Traingle:: This part is for Inhomogenetity domain
                        
      if ((-43*x+25*y+900)<0)& ((43*x+25*y-5550)<0)& ((50*y-2500)>0)              
        F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));

Dis_Pot=paq+F_Uniform_FLow+S_D1+S_D2+S_D3;

    Head1(py,px)=Head_Conversion(k1,H,Dis_Pot);
%     Head(py,px)=NaN;
        else                                                               % THIS PART IS FOR OUTSIDE THE INHOMOGENEITY DOMAIN
%              F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
% [fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
% S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));
% 
% [fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
% S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));
% 
% [fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
% S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));
% 
% Dis_Pot=paq+F_Uniform_FLow+(S_D1)+(S_D2)+(S_D3);
%    Head(py,px)=Head_Conversion(k,H,Dis_Pot);
        Head1(py,px)=NaN; 
           end
    end       
end
Head1;







[cc,hh]=contour(Head);
clabel(cc,hh);

hold on;
[cc,hh]=contour(Head1);
clabel(cc,hh);
xlabel('x(m)');
ylabel('y(m)');
%title('Plot of Head Contour: Strack plot');

hold on;
nnn=1;
 plot(50/nnn,50/nnn,'r+');
 hold on
 plot(75/nnn,93.30127/nnn,'r+');
 hold on
 plot(100/nnn,50/nnn,'r+');
 
 
 
 %% CHECKING BOUNDARY CONDITION ::: 
 
  %% (1) Head(+)=Head(-)---> Means for a particular Point on the boundary, Head should be contineous, just left and right side of the point.
  %% (2) Dis_Pot(+)/Dis_Pot(-)=k(+)/k(-)
  %% (3) s=Dis_Pot(+)-Dis_Pot(-)------> Means: At every node and at every midpoint, the jump value (s1,s2,s3,sc1,sc2,sc3) should be equal to Dis_Pot(+)-Dis_Pot(-)  
     
 
 %% A point Selected just outside the Inhomogeneity domain(along the boundary) and discharge potential and Head calculated at that point 
%  z=z1+(-0.00000001+0.00000001*i);
%  z=z2+(+0.00000001*i);
% z=z3+(+0.00001+0.00001*i);  
% z=((z1+z2)/2)-0.0000001;
% z=((z2+z3)/2)+0.0000001;
 z=((z3+z1)/2)-0.0000001*i;

% z=(58+63.76*i)-0.0001;

F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));

Dis_Pot_Outside=paq+F_Uniform_FLow+S_D1+S_D2+S_D3
Head_Outside=Head_Conversion(k,H,Dis_Pot_Outside)

%% Inside Part
%% A point Selected  inside the Inhomogeneity domain ((along the boundary) and discharge potential and Head calculated at that point 
%  z=z1+(0.00000001+0.00000001*i);
% z=z2+(-0.00000001*i);
% z=z3+(-0.00001+0.00001*i);
% z=((z1+z2)/2)+0.0000001;
% z=((z2+z3)/2)-0.0000001;
 z=((z3+z1)/2)+0.0000001*i;

% z=(58+63.76*i)+0.0001;  %% a point over Line 1

F_Uniform_FLow=Uniform_Flow(k,H,grad,z,angle);
[fm1,gm1,pm1] = Paraboloc_Line_Doublet_Strack (z1,z2,z );
S_D1=-real((1/(2*pi*i))*(s1*fm1+s2*gm1+s1*(0.5)*pm1+s2*(0.5)*pm1-sc1*pm1));

[fm2,gm2,pm2] = Paraboloc_Line_Doublet_Strack (z2,z3,z );
S_D2=-real((1/(2*pi*i))*(s2*fm2+s3*gm2+s2*(0.5)*pm2+s3*(0.5)*pm2-sc2*pm2));

[fm3,gm3,pm3] = Paraboloc_Line_Doublet_Strack (z3,z1,z );
S_D3=-real((1/(2*pi*i))*(s3*fm3+s1*gm3+s3*(0.5)*pm3+s1*(0.5)*pm3-sc3*pm3));

Dis_Pot_Inside=paq+F_Uniform_FLow+(S_D1)+(S_D2)+(S_D3);
Head_inside=Head_Conversion(k1,H,Dis_Pot_Inside);

Dis_Pot=[Dis_Pot_Outside,Dis_Pot_Inside];

jump=Dis_Pot_Inside-Dis_Pot_Outside ;

jump1=s1;
jump2=s2;
jump3=s3;
jump4=sc1;
jump5=sc2;
jump6=sc3;

%% Check:: Dis_Pot(+)/Dis_Pot(-)=k(+)/k(-)
ch1=Dis_Pot_Inside*k;
ch2=Dis_Pot_Outside*k1;

%%
Head_Diff=Head_Outside-Head_inside;   %% (1) Head(+)=Head(-)
brk_Pt=1


% Observation Well
hh1=Head(10,10);
hh3=Head1(75,65);
hhh=[hh1,hh3]
breakpoint=1;

    
% %    
% %    z=z1+0.0001;
% %    z=z1;
% %    z=(z1+z2)/2;
% %    z=58+63.76*i;
% %    z=(z1+z2+z3)/3;
% %    Z  = Convert_zj_To_Zj(z1,z2,z );
% %    break_point=1
% %    lamda1=(-0.5)*Z*(Z-1);
% %    lamda0=(Z-1)*(Z+1);
% %    lamda2=(-0.5)*Z*(Z+1);
% %    s1=s1;
% %    sc2=sc2;
% %    s2=s2;
% %    J1=(s1*lamda1)+(sc2*lamda0)+(s2*lamda2);
% %    break_point=1
   