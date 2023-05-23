function [F_Uniform_FLow] = Uniform_Flow(k,H,grad,z,angle)
alpha=(pi/180)*angle;    % To chnage degree to radian
%k=Permeability
%H=saturated aquifer thickness
%grad=hydraulic gradient
Q=k*H*grad;                   % Specific Discharge
CP=-Q*z*exp(-i*alpha);        % Complex Potential For uniform Flow  
F_Uniform_FLow=real(CP);      % Discharge potential
end
%Uniform_Flow(3,20,-0.01,20+15*i,0)


