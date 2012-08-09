%Input matrix, return RMS...

function [rms_val] = myRMS(m)

    rms_val = 0;
    n = size(m,1)*size(m,2);
    
    for r = 1:size(m,1)
        for c = 1:size(m,2)
            
            rms_val = m(r,c)^2 + rms_val;
        end
    end
    
    rms_val = sqrt(rms_val/n);
    
    
    



