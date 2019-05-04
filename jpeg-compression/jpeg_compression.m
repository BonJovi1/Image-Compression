img = imread("LAKE.TIF");

F = create_mat_dct();
disp(F);

%quantization matrix
qmatrix = [16 11 10 16 24 40 51 61; 
         12 12 14 19 26 58 60 55;
         14 13 16 24 40 57 69 56; 
         14 17 22 29 51 87 80 62; 
         18 22 37 56 68 109 103 77; 
         24 35 55 64 81 104 113 92;
         49 64 78 87 103 121 120 101; 
         72 92 95 98 112 100 103 99];

%part 2
img1 = img(420:427, 45:52);
dct1 = dct2(img1); %inbuilt
qnt1 = myDCT_quantization(dct1, qmatrix, 2);
deqnt1 = myDCT_dequantization(round(qnt1), qmatrix, 2);
recon1 = idct2(deqnt1);

subplot(1,5,1);
imagesc(img1);

subplot(1,5,2);
imagesc(dct1);

subplot(1,5,3);
imagesc(qnt1);

subplot(1,5,4);
imagesc(deqnt1);

subplot(1,5,5);
imagesc(recon1);

img2 = img(427:434, 298:305);
dct_2 = myDCT(img2 - 127, F);
qnt2 = myDCT_quantization(dct_2, qmatrix, 2);
deqnt2 = myDCT_dequantization(round(qnt2), qmatrix, 2);
recon2 = myIDCT(deqnt2, F) + 127;

subplot(1,5,1);
imagesc(img2);

subplot(1,5,2);
imagesc(dct_2);

subplot(1,5,3);
imagesc(qnt2);

subplot(1,5,4);
imagesc(deqnt2);

subplot(1,5,5);
imagesc(recon2);

img3 = img(30:37, 230:237);
dct_3 = myDCT(img3 - 127, F);
qnt3 = myDCT_quantization(dct_3, qmatrix, 2);
deqnt3 = myDCT_dequantization(round(qnt3), qmatrix, 2);
recon3 = myIDCT(deqnt3, F) + 127;

subplot(1,5,1);
imagesc(img3);

subplot(1,5,2);
imagesc(dct_3);

subplot(1,5,3);
imagesc(qnt3);

subplot(1,5,4);
imagesc(deqnt3);

subplot(1,5,5);
imagesc(recon3);

%Part 3
c=2;

dct_func = @(block_struct) myDCT(block_struct.data, F);
idct_func = @(block_struct) myIDCT(block_struct.data, F);
qnt_func = @(block_struct) myDCT_quantization(block_struct.data, qmatrix, c);
deqnt_func = @(block_struct) myDCT_dequantization(block_struct.data, qmatrix, c);

dct_4 = blockproc(img, [8,8], dct_func);
qnt4 = blockproc(dct_4, [8,8], qnt_func);
deqnt4 = blockproc(qnt4, [8,8], deqnt_func);
recon4 = blockproc(deqnt4, [8,8], idct_func);

subplot(1,2,1);
imagesc(img);
subplot(1,2,2);
imagesc(recon4); %recon image at c=2

%Part 4
n=20;
error = zeros(1,n);
entropy = zeros(1,n);

for i=1:n
	recon4 = reconit(img, F, qmatrix, i);
	error(i) = RMSE(img, recon4);
	entropy(i) = My_entropy(recon4);
end

colormap gray;
n=20;
j=1;

for i=1:2:n
	recon4 = reconit(img, F, qmatrix, i);
	subplot(2,5,j);
	imagesc(recon4);
	j = j+1;
end
 
subplot(1,2,1);
stem(error);
subplot(1,2,2);
stem(entropy);





