function fsd_sband = method_weighted_avg_fuse_fn(inp_wt,Nlevels)
    %* fusion of ALL subbands of two input images, by general weighted average method
    %* to implement eq.26 in the paper:
    % Pajares, Gonzalo, and Jesus Manuel De La Cruz. "A wavelet-based image fusion tutorial." Pattern recognition 37.9 (2004): 1855-1872.
    % Input:
    %   inp_wt: subbands of all images to be fused, cell object
    %   Nlevels: number of levels for DWT
    % Output:
    %   fsd_sband: fused subbands cell object for all images, by general weighted average method


    %* weight matrix will be used in weighted average combination method:
    % the user can select one of the following weight matrix or create weight matrix by themself
    w1=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];
    w2=[2/15 2/15 2/15;2/15 2/15 2/15;1/15 1/15 1/15];
    w3=[4/21 2/21 1/21;4/21 2/21 1/21;4/21 2/21 1/21];
    w4=[8/35 4/35 2/35;8/35 4/35 2/35;4/35 2/35 1/35];


    NoOfBands=3*Nlevels+1;

    % weighted average method for low and high frequency subbands:
    for k=NoOfBands:-1:1
        
        sband1=cell2mat(inp_wt{1}(k));
        sband2=cell2mat(inp_wt{2}(k));

        fused_sband_mat = weighted_ave_coef_comb_fn(w3, sband1, sband2, 0.5);
        fsd_sband{k} = fused_sband_mat;

    end






