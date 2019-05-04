%part 1c
function idct_img = myIDCT(im, F)
	idct_img = F' * double(im) * F;
end