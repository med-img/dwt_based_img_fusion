function fsd_sband = method_simple_avg_fuse_fn(inp_wt,Nlevels)
    %* fusion of ALL subbands of two input images, by the simple average method
    %* in the paper:
    % Pajares, Gonzalo, and Jesus Manuel De La Cruz. "A wavelet-based image fusion tutorial." Pattern recognition 37.9 (2004): 1855-1872.
    % Input:
    %   inp_wt: subbands of all images to be fused, cell object
    %   Nlevels: number of levels for DWT
    % Output:
    %   fsd_sband: fused subbands cell object for all images, by simple average method

    NoOfBands=3*Nlevels+1;

    % weighted average method for low and high frequency subbands:
    for k=NoOfBands:-1:1
        
        sband1=cell2mat(inp_wt{1}(k));
        sband2=cell2mat(inp_wt{2}(k));

        fused_sband_mat = (sband1+sband2)*0.5;
        fsd_sband{k} = fused_sband_mat;

    end






