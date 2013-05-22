%%logon;
clear;
[Y FS N] = wavread('Falling Slowly');
Y = resample(Y,8000,FS);
Y = mean(Y,2);
Y = Y-mean(Y);
[S F T] = spectrogram(Y,2048,1024,4096,8000);

[Y1 FS1 N1] = wavread('Falling Slowly Pic');
Y1 = resample(Y1,8000,FS);
Y1 = mean(Y1,2);
Y1 = Y1-mean(Y1);
S1=spectrogram(Y1,2048,1024,4096,8000);

% subplot(421);
% plot(real(Y));
% subplot(422);
% plot(abs(S));
% subplot(423);
% plot(real(Y1));
% subplot(424);
% surf(T,F,abs(S),'edgecolor','none'); axis tight; 
% view(0,90);
% xlabel('Time (Seconds)'); ylabel('Hz');

M = ones(13);
N = (floor(13/2)+1);
M(N,N) = 0;
BW = abs(S) > imdilate(abs(S), M);
imwrite(BW, ['Constelacion' num2str(13) '.png']);

surf(T,F,10*log(abs(S)),'edgecolor','none'); axis tight; 
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');
imshow(BW);
colormap (1-gray);
imwrite(S, 'Spectro.png');

M = ones(13);
N = (floor(13/2)+1);
M(N,N) = 0;
BW1 = abs(S1) > imdilate(abs(S1), M);
imwrite(BW1, ['ConstelacionCorta' num2str(13) '.png']);

imshow(BW1);
colormap (1-gray);
imwrite(S1, 'SpectroCorta.png');
%plot(abs(S1));

%% Canciones base de datos
song2database('Falling Slowly');
song2database('Rising Sun');

%% Muestra a comparar

[Img grafica t] = compareSongs(song2hash('Falling Slowly Pic'));
imshow(Img);


%%
t=0:0.001:2;                    % 2 secs @ 1kHz sample rate
y=chirp(t,100,1,200,'q');       % Start @ 100Hz, cross 200Hz at t=1sec 
S = spectrogram(y,64,63,800,1E3); % Display the spectrogram
for i = 1:2:13
    M = ones(i);
    N = (floor(i/2)+1);
    M(N,N) = 0;
    BW = abs(S) > imdilate(abs(S), M);
    imshow(BW);
    pause;
end
imshow(BW);

