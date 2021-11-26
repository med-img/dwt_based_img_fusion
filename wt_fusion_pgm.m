%%
% wavelet based image fusion main program
% perform wavelet based image fusion methods of the paper:
% Ganasala, Padma, and Vinod Kumar. "CT and MR image fusion scheme in nonsubsampled contourlet transform domain." Journal of digital imaging 27.3 (2014): 407-418.
% the code is written by ourself
close all;
clear all;
clc;

%%
% load image data
%dwtmode('per');
%%% Fusion Method Parameters.
Nlevels=2;
NoOfBands=3*Nlevels+1;
wname='sym4'; %% coif5 db16 db8 sym8 bior6.8

fused_path = '******';
image_a = "******";
image_b = "******";

x{1}=imread(image_a);
x{2}=imread(image_b);

[M,N]=size(x{1});

%%
%%% Wavelet Decomposition.
for m=1:2
    xin=double(x{m});
%         xin=im2double(x{m});
    % dwtmode('per');
    [C,S]=wavedec2(xin,Nlevels,wname);
    k=NoOfBands;
    %% get the approximation matrix (low frequency image) of the highest level:
        %   CW{k}=reshape(C(1:S(1,1)*S(1,2)),S(1,1),S(1,2)); %% approximation matrix (low frequency image) of the highest level
    CW{k}=appcoef2(C, S, wname, Nlevels);
    
    k=k-1;
    st_pt=S(1,1)*S(1,2);
        for i=2:size(S,1)-1
            slen=S(i,1)*S(i,2);
            CW{k}=reshape(C(st_pt+slen+1:st_pt+2*slen),S(i,1),S(i,2));     %% Vertical
            CW{k-1}=reshape(C(st_pt+1:st_pt+slen),S(i,1),S(i,2));          %% Horizontal
            CW{k-2}=reshape(C(st_pt+2*slen+1:st_pt+3*slen),S(i,1),S(i,2)); %% Diagonal
            st_pt=st_pt+3*slen;
            k=k-3;
        end

    inp_wt{m}=CW;
end

clear CW

%%
% Perform coefficients fusion for all subbands
% ! Different methods for coefficients fusion, the user can choose one of these methods for implementation:
% Using general weighted average method for subbands fusion:
% fuse_im=method_weighted_avg_fuse_fn(inp_wt,Nlevels);

% Using maximum Actitity level measurement selection method for high frequency bands,
% and simple average for low frequency bands:
% fuse_im=method_max_select_fuse_fn(inp_wt,Nlevels);

%! the simple average method for image fusion:
fuse_im = method_simple_avg_fuse_fn( inp_wt,Nlevels );

%%
%%% Wavelet Reconstruction.
yw=fuse_im; clear fuse_im
% if(isequal(wname,'DCHWT'))
%    %%% Discrete Cosine Harmonic Wavelet Reconstruction
%    xrcw=uint8(dchwt_fn2(yw,-Nlevels));
% else
   %%% General Wavelet Reconstruction.
   k=NoOfBands;
   xrtemp=reshape(yw{k},1,S(1,1)*S(1,2));
   k=k-1;
   for i=2:size(S,1)-1
       xrtemp=[xrtemp reshape(yw{k-1},1,S(i,1)*S(i,2)) reshape(yw{k},1,S(i,1)*S(i,2)) reshape(yw{k-2},1,S(i,1)*S(i,2))];
       k=k-3;
   end
%    xrcw=uint8(waverec2(xrtemp,S,wname));
   xrcw=waverec2(xrtemp,S,wname);

% clear yw xrtemp C S

temp = imresize(xrcw,[M N]);
% temp = im2double(temp);
figure,imshow(uint8(temp)),title('DWT Fused Image');

% save fused image and corresponding matrix:
imwrite(uint8(temp),strcat(fused_path,'fused_1.png'),'png');
save(strcat(fused_path,'fused_1.mat'), 'temp');


%%%%% 
% wavelet based image fusion method can also process 3D and RGB colored images
% In case of data opening error, data dimension conversion and other problems, please adopt the functions ind2rgb and gray2ind£¬ or any feasible way you know. 
