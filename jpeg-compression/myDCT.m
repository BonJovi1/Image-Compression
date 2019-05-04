%part 1b
function dct_img = myDCT(im, F)
	dct_img = F * double(im) * F';
end