%part 1g, calculate entropy of the image
function entropy = My_entropy(im)
	[a, b] = imhist(im);
    [ht, wt] = size(im);
	a = a./(ht * wt);
	c = nonzeros(a);
	entropy = -sum(c.*log2(c));
end