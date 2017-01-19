clear all;
cm=colormap(winter(256));
cm16=cm*255; cm16=round(cm16);
r16=dec2hex(cm16(:,1));
g16=dec2hex(cm16(:,2));
b16=dec2hex(cm16(:,3));
lut16=[r16 g16 b16];
lutDEC = hex2dec(lut16);

save('WinterDEC.txt', 'lutDEC', '-ascii');