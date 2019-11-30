function res = inverse_laplace(new_c, new_d, K_s, is_complex)

% new_c = [-0.5000   -0.1667    0.6667];
% new_d = [[1 1];[1 3]; [1 0]];

% new_c = [-0.7500 - 0.2500i; -0.7500 + 0.2500i;1.5000 + 0.0000i];
% new_d = [1.0000 + 0.0000i   1.0000 - 1.0000i; 1.0000 + 0.0000i   1.0000 + 1.0000i;1.0000 + 0.0000i   0.0000 + 0.0000i];
% K_s = 0;
% is_complex = [1, 1, 0];

new_c
new_d
syms s t %symbolic 생성 위한 준비 작업

if sum(is_complex)==0 %실근으로만 이뤄진 경우
    %항을 합친다.
    terms = 0;
    for k = 1:length(new_c)
        snum = poly2sym(new_c(k), s);
        sden = poly2sym(new_d(k, 1:end), s);
        terms = terms + snum/sden;
    end
    terms = terms + K_s;
    
    
else %허근이 있는 경우
    k = 1;
    terms = 0;
    while k<=length(new_c)
        %항을 합친다.
        if is_complex(k)==0 %실근인 경우
            snum = poly2sym(new_c(k), s);
            sden = poly2sym(new_d(k, 1:end), s);
            terms = terms + snum/sden;
            k = k+1;
        else%허근인 경우
            temp_c = new_c(k)*new_d(k+1, 1:end)+new_c(k+1)*new_d(k, 1:end);
            temp_d = conv(new_d(k, 1:end),new_d(k+1, 1:end));
            snum = poly2sym(temp_c, s);
            sden = poly2sym(temp_d, s);
            terms = terms + snum/sden;
            k = k+2;
        end
    end
    terms = terms + K_s;
end
%역 라플라스 변환
res = [];
res = ilaplace(terms);
res = simplify(res, 'Steps',10);
res = collect(res, exp(-t)); %exp(-t)를 기준으로 다항식을 모은 후 정렬


