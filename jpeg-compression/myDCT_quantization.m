%part 1d
function qnt_dct_img = myDCT_quantization(imDCT, qm, c)
	N = c * qm;
	qnt_dct_img = imDCT./N;
end