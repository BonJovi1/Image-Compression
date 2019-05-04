%part 1f
function rms_error = RMSE(img1, img2)
	A = double(img1) - double(img2);
	A = A.^2;
	rms_error = sqrt(mean(A, 'all'));
end