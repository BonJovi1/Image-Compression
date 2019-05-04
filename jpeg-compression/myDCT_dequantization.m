%part 1e
function deqnt_dct_img = myDCT_dequantization(imDCT, qm, c)
	N = c * qm;
	deqnt_dct_img = imDCT.*N;
end