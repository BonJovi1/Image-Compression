allfiles = dir('dataset/*.jpg');
arr=[];
for i = 1:1:length(allfiles)
    I = imread(strcat('dataset/', allfiles(i).name));
    arr = [arr; I(:)'];
end

transpose_mat = arr';
covariance_mat = cov(double(transpose_mat));
[vectors, values] = eig(covariance_mat);
%sort by diagonals
[a,b] = sort(diag(values), 'descend');
norm_mat = normalize( double(transpose_mat) * vectors(:, b(1:520, :)));%so if we multiply with this, we can compress it
% norm_mat = normalize( double(transpose_mat) * vectors(:, b(1:35, :)));
compress_mat = double(arr) * norm_mat;
decompress_mat = compress_mat * norm_mat';

%1D scatterplot
x = size(compress_mat, 1);
x2 = zeros(x);
size(compress_mat)
size(x2(1, :)')
scatter(compress_mat(:,1), x2(1, :)');

%2D scatterplot
scatter(compress_mat(:, 1), compress_mat(:, 2) );

%3D scatterplot
scatter3(compress_mat(:, 1), compress_mat(:, 2), compress_mat(:, 3));

%displaying the images
for i = 1:1:4
    img = reshape(decompress_mat(i, :), [256 256 3]);
    subplot(1,4,i);
    imshow(mat2gray(img));
end

    