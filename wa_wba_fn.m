function activity_level = wa_wba_fn( weight, sband_mat )
    % Activity level computation method
    % the function to compute weigthed average window-based activity (WA-WBA) level of input sub-band at specific decomposition level and specific frequency band
    % input: weight matrix (squared matrix, 3x3 or 5x5); specific sub-band matrix from wavelet decomposition
    % to implement eq. 22 of the paper:
    % Pajares, Gonzalo, and Jesus Manuel De La Cruz. "A wavelet-based image fusion tutorial." Pattern recognition 37.9 (2004): 1855-1872.
    % Input:
    %   weight: weight matrix
    %   sband_mat: sub-band matrix for WA-WBA level computation
    % Output:
    %   activity_level: computed activity level


    % at first, rot weight matrix 180 degrees for conv operation:
    weight = rot90(weight,2);
    activity_level = conv2( abs(sband_mat), weight, 'same' );
    