clear;
%save('C:\Users\Labmember\Documents\Daan_Coscan_LV64bit\SubVis\Matlab Scripts\Contour_ToVolts\testparams2','pxLTRB','voltsLTRB','AngleImg','Npoints','pxXYin');

addpath('C:\Users\Labmember\Documents\Daan_Coscan_LV64bit\SubVis\Matlab Scripts\Contour_ToVolts');
%load('exampleparams.mat');
load('testparams3.mat');
[xout, yout] = genContour(pxLTRB,voltsLTRB,AngleImg,Npoints,pxXYin);
