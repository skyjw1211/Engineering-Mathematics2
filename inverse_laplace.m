function res = inverse_laplace(new_c, new_d, K_s)

% new_c = [-0.5000   -0.1667    0.6667];
% new_d = [[1 1];[1 3]; [1 0]];


syms s t %symbolic 생성 위한 준비 작업

%항을 합친다.
terms = 0;
for k = 1:length(new_c)
    snum = poly2sym(new_c(k), s);
    sden = poly2sym(new_d(k, 1:end), s);
    terms = terms + snum/sden;
end
terms = terms + K_s;

%역 라플라스 변환
res = [];
res = ilaplace(terms);
res = simplify(res, 'Steps',10);
res = collect(res, exp(-t)); %exp(-t)를 기준으로 다항식을 모은 후 정렬

