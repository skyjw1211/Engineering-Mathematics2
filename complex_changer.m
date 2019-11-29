function [new_c, new_d] = complex_changer(c, r, order_r, is_complex)
% c =  [-0.5000   -0.1667    0.6667];
% order_r = [1 1 1];
% r = [-1 -3 0];
% is_complex = [0 0 0];


new_c = [];
new_d = [];

k = 1;
while k <= length(r)
    % 허근이 있는 경우
    if is_complex(k)==1
       new_d = [new_d; conv([1, -r(k)],[1, -r(k+1)])];
       new_c = [new_c; c(k)*[1, -r(k+1)]+c(k+1)*[1, -r(k)]];
       k = k+2;
    else
        %실근인 경우
        s = [1, -r(k)];
        for i = 2:order_r(k)
            s = conv(s, s);
        end
        new_d = [new_d; s];
        new_c = [new_c; c(k)];
        k = k + 1;
    end
end