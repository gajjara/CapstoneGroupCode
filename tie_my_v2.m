% Credit goes to Laura Waller's Computational Imaging lab for their open source code that this file is based on
% Source: https://drive.google.com/file/d/0B_HY5ZswCff-cU8zWnFnZ3hIa1k/view
% Source: http://www.laurawaller.com/opensource/

function [amplitude, fourier, phaseamp] = tie_my_v2(Img1, Img0, Img2)
% Images
I1 = double(rgb2gray(Img1(:, 1101:5100, :)));
I0 = double(rgb2gray(Img0(:, 1101:5100, :)));
I2 = double(rgb2gray(Img2(:, 1101:5100, :)));

% Constants
ps = 1.785e-5; % pixel size
lambda = 400e-9; % wavelength (assumed to be this)
dz = 0.025; % change in z
nozero = 1;

% Ampltiude
amplitude = I0 + dz*(I2-I1)/dz;

% From Transport of Intensity Equation
% Let Del(I*Del(Phi)) = Del^2(Psi)
Del2_Psi_xy = (-2*pi/(lambda*2*dz)).*(I2-I1);

clear I2 I1

N = size(Del2_Psi_xy,1);
% Angular frequency axis
wx =2*pi*(0:(N-1))/N; 
% Calculate axises
fx = 1/(2*pi*ps)*(wx-pi*(1-mod(N,2)/N)); 
[Fx,Fy] = meshgrid(fx,fx);
% Fourier transform
Del2_Psi_ft = fftshift(fft2(Del2_Psi_xy));
fourier = Del2_Psi_ft;

Psi_ft = Del2_Psi_ft./(-4*pi^2*(Fx.^2+Fy.^2+nozero));

clear Del2_Psi_ft

% Inverse fourier
% Psi_xy = ifftshift(ifft2(Psi_ft));
% Alternate:
Psi_xy = ifft2(Psi_ft);

% From Del(I*Del(Phi)) = Del^2(Psi), we get
% Del(Phi) = Del(Psi)/I
[Grad_Psi_x, Grad_Psi_y] = gradient(Psi_xy/ps);
Grad_Psi_x = Grad_Psi_x./(I0+nozero);
Grad_Psi_y = Grad_Psi_y./(I0+nozero);

clear I0 Psi_xy

% Del^2(Phi) = Del(Del(Psi)/I)
[grad2x,~] = gradient(Grad_Psi_x/ps);
[~,grad2y] = gradient(Grad_Psi_y/ps);
Del2_Phi_xy = grad2x + grad2y;
clear Grad_Psi_x Grad_Psi_y grad2x grad2y

N = size(Del2_Phi_xy,1); 
% Angular frequency axis
wx =2*pi*(0:(N-1))/N; 
% Calculate axises
fx = 1/(2*pi*ps)*(wx-pi*(1-mod(N,2)/N)); 
[Fx,Fy] = meshgrid(fx,fx);
% Fourier transform
Del2_Phi_ft = fftshift(fft2(Del2_Phi_xy));
Phi_ft = Del2_Phi_ft./(-4*pi^2*(Fx.^2+Fy.^2+nozero));
% Inverse fourier
%Phi_xy = ifftshift(ifft2(Phi_ft));
% Alternate:
Phi_xy = ifft2(Phi_ft);

phaseamp = abs(amplitude.*(exp(1i.*Phi_xy)));


clear ps lambda dz nozero N wx fx Fx Fy
end