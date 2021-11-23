function combined_coef_mat = background_elimination_coef_comb_fn(sband1, sband2, window_m, window_n)
    % the function to perform Background Elimination (BE) combining scheme
    % to implement eq.37 at page 1864 of the paper:
    % Pajares, Gonzalo, and Jesus Manuel De La Cruz. "A wavelet-based image fusion tutorial." Pattern recognition 37.9 (2004): 1855-1872.
    % Input:
    %   sband1, sband2: sub-band of image 1 and 2
    %   window_m, and window_n: len and width window size for computing window based mean value for sub-band matrix, centered at position (i, j)
    % 
    % Output:
    %   combined_coef_mat: combined coefficient matrix

    % set the default threshold alpha value:
    % if(nargin<3)
    %     exp_a = 0.5;
    % end

    % windowed mean:
    w_mean_sband1 = windowed_centered_mean(sband1, window_m, window_n);
    w_mean_sband2 = windowed_centered_mean(sband2, window_m, window_n);


    combined_coef_mat = sband1+sband2-w_mean_sband1-w_mean_sband2+(w_mean_sband1+w_mean_sband2)./2;






