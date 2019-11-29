function [new_c, new_d] = complex_changer(c, r, order_r, is_complex)
%partial fraction된 부분 분수들의 분자 계수와 분모 계수(해)를 받아 inverse laplace 변환을 위한 형태로 처리하는 함수
%복소수 분모를 갖는 부분분수가 있으면, 켤레 근을 곱하여 2차 다항식 꼴로 바꾼 후 처리해 준다.

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
