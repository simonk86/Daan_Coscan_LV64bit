function [xout, yout] = genContour(pxLTRB,voltsLTRB,AngleImg,Npoints,pxXYin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%xy coordinates of reference corners in clicking coordinates
Crn_px_x = [pxLTRB(1), pxLTRB(1), pxLTRB(3), pxLTRB(3)];%bottom left, top left, top right, bottom right
Crn_px_y = [pxLTRB(4), pxLTRB(2), pxLTRB(2), pxLTRB(4)];

%corners in voltage space in display voltage coords
Crn_v_x = [voltsLTRB(1), voltsLTRB(1), voltsLTRB(3), voltsLTRB(3)];%bottom left, top left, top right, bottom right
Crn_v_y = [voltsLTRB(4), voltsLTRB(2), voltsLTRB(2), voltsLTRB(4)];

%corners in voltage space in galvo voltage coords
Crn_g_x = Crn_v_x*cosd(AngleImg)+Crn_v_y*sind(AngleImg);
Crn_g_y = -Crn_v_x*sind(AngleImg)+Crn_v_y*cosd(AngleImg);

tform_px_to_g = fitgeotrans([Crn_px_x;Crn_px_y]',[Crn_g_x; Crn_g_y]','affine');
T_pxtog = maketform('affine',tform_px_to_g.T);
[Xout, Yout] = tformfwd(T_pxtog, pxXYin(:,1), pxXYin(:,2));

%% debug
plot(pxXYin(:,1), pxXYin(:,2),'.');
hold on;
plot(Crn_px_x,Crn_px_y,'o');

plot(Xout,Yout);
hold on;
plot(Crn_g_x,Crn_g_y,'o');
end

