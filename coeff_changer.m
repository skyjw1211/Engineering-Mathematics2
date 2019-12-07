function [new_c, new_d] = coeff_changer(c, r)
% c =  [-0.5000   -0.1667    0.6667];
% order_r = [1 1 1];
% r = [-1 -3 0];
% is_complex = [0 0 0];
% 
% c = [0.5000 + 1.0000i   0.5000 - 1.0000i];
% order_r = [1     1];
% is_complex = [1 1];
% r = [-1.0000 + 1.0000i; -1.0000 - 1.0000i];

new_c = [];
new_d = [];

for k = 1:length(r)
    s = [1, -r(k)];
    new_d = [new_d; s];
    new_c = [new_c; c(k)];
end
