function [head] = Head_Conversion(k,H,Dis_Pot)
% This function calculate head from Discharge potential 
% k=aquifer permeability
% H=aquifer Thickness
% Discharge Potential
if  (Dis_Pot>=((1/2)*k*H*H))
    head=(Dis_Pot+(1/2)*k*H*H)/(k*H);
else
    head=sqrt(2*Dis_Pot/k);
end

