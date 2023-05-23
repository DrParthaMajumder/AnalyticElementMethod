function [ Dis_Pot ] = Discharge_potential(b,h,k,H)
% THIS FUNCTION CALCULATES DISCHARGE POTENTIAL FOR CONFINED AND UNCONFINED FLOW 
%b=Base Thickness
%h=Head at particular point
%H=Thickness of the aquifer
%sample:Discharge_potential(150,200,2,15)
PHI=h-b;                             % AQUIFER HEAD
if(PHI>H)                            % IF CONFINED AQUIFER
    Dis_Pot=k*H*PHI-(1/2)*k*H*H;
else
    Dis_Pot=(1/2)*k*PHI*PHI;         % IF UNCONFINED AQUIFER   
end
end




