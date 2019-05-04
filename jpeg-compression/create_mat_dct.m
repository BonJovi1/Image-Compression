%part 1a
function basis_matrix = create_mat_dct()
	N=8;
	it = 0:N-1;
	[x,y] = meshgrid(it, it);
	basis_matrix = cos((pi*(1.*x + 1/2).*y)/N);

	basis_matrix(1,:) = basis_matrix(1,:)*sqrt(1/N);
	basis_matrix(2:N, :) = basis_matrix(2:N,:)*sqrt(2/N);
end