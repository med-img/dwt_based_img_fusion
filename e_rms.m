function error = e_rms(in, est)
    % the function to compute the root mean square error of the difference
    % between the input (fused) image and est (perfect) image
    % Input: 
    %   in: input fused image
    %   est: perfect image
    % 
    % Output:
    %   error: rms error value

    e = in - est;
    error = ( mean( e(:).^2 ) )^0.5;
    