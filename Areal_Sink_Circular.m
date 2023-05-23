function [F_AS] = Areal_Sink_Circular(N,R,r)
%R=radius of the circle
%N=sink density
if(r<=R)
    F_AS=(N/4)*(r^2-R^2);
else
    F_AS=(N*R^2/2)*log(r/R);
end

