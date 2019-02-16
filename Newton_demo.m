%% Fourier Ptychographic microscopy
%% Phase retrieval using Newton based algorithm
%% for the overlap mentioned
clc;
clear all;
close all;
image=imread('small.jpg');
image=rgb2gray(image);
[high,high]=size(image);
spectrum = fftshift(fft2(image));
abs(image);
figure;
imagesc(abs(image));
colormap(gray)
figure;
imagesc(abs(spectrum));
i7=1;
low={};
low_dime=10;
F = dftmtx(low_dime^2);
Fi= conj(dftmtx(low_dime^2))/low_dime;
overlap=3;
%% generating the low resolution images
for j=1:overlap:high-low_dime-1
    for i=1:overlap:high-low_dime-1
        spectrum_crop_1 = (spectrum(i:i+low_dime-1,j:j+low_dime-1));     
        low_res_image_1 = Fi*reshape(spectrum_crop_1,[low_dime^2,1]);
        %phase is lost 
        % intensity images
        low{i7}=abs(low_res_image_1); 
        i7=i7+1;
    end
    size(low);
end
%% intializing the spectrum of high resolution with one of the low resolution images
rgg=reshape(spectrum,[high^2,1]);
int=imresize(low{1},[high,high]);
spectr=fftshift(fft2(int));
%% intializing with random
spectr_updated=randn(high,high);
r=reshape(spectr,[high^2,1]); %% Now our high resolution spectrum is going to be a vector.
%% Now the task is to update high resolution spectrum.
% here r is the vector form of high resolution spectrum
 g=1;
 Iterations=10; % No of iterations
[int_final,error]=newton_FPM(low,overlap,low_dime,high,Iterations,r,spectrum);
%% after all the iterations
%% converting it to spatial domain 
r;
result=ifft2(int_final);
figure;
imagesc(abs(result))
colormap(gray)
figure;
plot(error)
