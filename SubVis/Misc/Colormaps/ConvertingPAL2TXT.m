clear all;
lut=load('FALSE2.PAL');
r=lut(:,1);r16=dec2hex(r);
g=lut(:,2);g16=dec2hex(g);
b=lut(:,3);b16=dec2hex(b);
lut=[r16 g16 b16];
lutDEC = hex2dec(lut);

save('False2DEC.txt', 'lutDEC', '-ascii');