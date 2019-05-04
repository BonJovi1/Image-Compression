function recon4 = reconit(img, F, qmatrix, c)

    dct_func = @(block_struct) myDCT(block_struct.data, F);
    idct_func = @(block_struct) myIDCT(block_struct.data, F);
    qnt_func = @(block_struct) myDCT_quantization(block_struct.data, qmatrix, c);
    deqnt_func = @(block_struct) myDCT_dequantization(block_struct.data, qmatrix, c);

    dct_4 = blockproc(img, [8,8], dct_func);
    qnt4 = blockproc(dct_4, [8,8], qnt_func);
    deqnt4 = blockproc(qnt4, [8,8], deqnt_func);
    recon4 = blockproc(deqnt4, [8,8], idct_func);
end