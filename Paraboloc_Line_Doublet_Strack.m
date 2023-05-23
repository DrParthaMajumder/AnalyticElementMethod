function [fm,gm,pm] = Paraboloc_Line_Doublet_Strack (z1,z2,z )
zm=(z-(0.5*(z2+z1)))/(0.5*(z2-z1)); % This is correct
% absolute_value=abs(zm);
fm=((-0.5)*(zm-1)*log((zm-1)/(zm+1)))-1;
gm=((0.5)*(zm+1)*log((zm-1)/(zm+1)))+1;
pm=((zm^2-1)*log((zm-1)/(zm+1)))+2*zm;
end

