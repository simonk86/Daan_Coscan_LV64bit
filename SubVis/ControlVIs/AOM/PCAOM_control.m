% commands for controlling the PolyChromatic Accousto-Optic Modulator PCAOM
% in Northwest, it is plugged into COM4 (Sept. 5, 2012)
% To check to port, go to "Devices and Printers" from the start menu.  The
% PCAOM driver (MHz frequency synthesizer) should be called 
% "FT245R USB FIFO."  Right click on the picture and select "properties".
% Click on "hardware" to find the COM port.

% Total RF power (sum of all channels) on PC-AOM should not exceed 800 mW.
% Total power when optimal is 55+120+100+170+300 = 745 mW, so I guess we
% should be safe.  In practice, we rarely want all channels open
% simultaneously anyways.

% channel name for each color
% [red, orange, yellow, green, blue]
Chan = {'ch1','ch2','ch3','ch4','ch5'};
State = [1, 1, 1, 1, 1]; % 1 = 'on', 0 = 'off'
UseMaxAmplitude = 1;    % 1 if maximum amplitude desired, otherwise uses alignment amplitude

% frequencies for each laser in NW, updated 9/5/2012
F = [52.67, 57.868, 62.133, 66.688, 74.95];


% amplitudes for maximum efficiency
AmpMax = [1023, 760, 600, 800, 460];
%AmpSame = [700, 760, 260, 800, 460]; % output power ~28mW except 488nm (13.6mW)
%AmpSame = [425, 610, 210, 580, 460]; % output power re-adjusted on 9/28/12

%AmpSame = [700, 160, 60, 200, 460]; % roughly constant fluorescence
% approximate MHz power for these numbers (not to exceed 800mW at once)
% in mW: [300, 170, 100, 120, 55]
% approximate efficiency in diffracted beam (532 polarization wrong):
% in %:  [61, 82, 80, 70, 71]

% choose lower powers for aligning
AmpAlign = [100, 100, 100, 100, 100];

% choose maximum alignment efficiency or alignment efficiency
Amp = AmpAlign;
if UseMaxAmplitude
    Amp = AmpMax;
    %Amp= AmpSame;
end

s = serial('COM4');
fopen(s);
get(s)
set(s,'Terminator','CR/LF');
for k = 1:5
    fprintf(s, Chan{k});    % select channel
    fprintf(s, ['fr ',num2str(F(k))]);  % set the frequency
    fprintf(s, ['am ',int2str(Amp(k))]); % set the amplitude
    if State(k)
        fprintf(s, 'on');   % 'on' = digital modulation, 'mod' = digital or analog modulation
    else
        fprintf(s, 'off');  % turn channel off
    end
end
fclose(s);

% % 488 nm (updated 9/5/2012, 71% of input power in diff. beam)
% fprintf(s, 'ch5');
% fprintf(s, 'fr 74.95');
% fprintf(s, 'am 460');   % ~55 mW
% fprintf(s, 'on');