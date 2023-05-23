function [F_Well] = Well_Fun(Q,z,zw)
CP=(Q/(2*pi))*log(z-zw);       % Q in cubic meter/day      %Complex potential
F_Well=real(CP);               % Q positive for extraction and negative for injection     
end

% at r=R 





