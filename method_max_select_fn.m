function fuse_im=method_max_select_fn(inp_wt,Nlevels)
    %%% for image fusion, use selection method
    %%% select the max absolute coef value of wavelet decomposed matrix

    
    
    NoOfBands=3*Nlevels+1;
    
    %%% Significance factor of all subbands who has childrens.
    for k=NoOfBands-1:-1:1

        sband1=cell2mat(inp_wt{1}(k));
        sband2=cell2mat(inp_wt{2}(k));
        
        sig_temp1 = (abs(sband1) - abs(sband2))>=0;
        sig_temp2 = ~sig_temp1;

       sig_mat1{k}=sig_temp1;
       sig_mat2{k}=sig_temp2;
       clear sband1 sig_temp1;
       clear sband2 sig_temp2;
    end
    
    %%% for fusion of approximation subbands, just perform simple average:
    [p,q]=size(cell2mat(inp_wt{1}(NoOfBands)));
    sig_mat1{NoOfBands} = 0.5*ones(p,q);
    sig_mat2{NoOfBands} = 1-sig_mat1{NoOfBands};

    %%%! perform consistency verification procedure by 3x3 window:
    % to conefficient matrices, except the low frequency coef. matrix
    % wsize = 3;
    for k=NoOfBands-1:-1:1
        % [p,q] = size(sig_mat1{k});
        sig_mat1{k} = constcy_verf(sig_mat1{k});
        sig_mat2{k} = 1-sig_mat1{k};
    end


    %%% Fusion.
    for k=1:NoOfBands
       [p,q]=size(sig_mat1{k});
       tt1=cell2mat(inp_wt{1}(k));
       tt2=cell2mat(inp_wt{2}(k));
       for ii=1:p
          for jj=1:q
            %  fuse_im{k}(ii,jj)=(tt1(ii,jj)*sig_mat1{k}(ii,jj)+tt2(ii,jj)*sig_mat2{k}(ii,jj))/(sig_mat1{k}(ii,jj)+sig_mat2{k}(ii,jj));
             fuse_im{k}(ii,jj)=(tt1(ii,jj)*sig_mat1{k}(ii,jj)+tt2(ii,jj)*sig_mat2{k}(ii,jj));
          end
       end
    end

end