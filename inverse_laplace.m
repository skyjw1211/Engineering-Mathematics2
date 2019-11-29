function res = inverse_laplace(new_c, new_d, K_s)

% new_c = [-0.5000   -0.1667    0.6667];
% new_d = [[1 1];[1 3]; [1 0]];


syms s t %symbolic ���� ���� �غ� �۾�

%���� ��ģ��.
terms = 0;
for k = 1:length(new_c)
    snum = poly2sym(new_c(k), s);
    sden = poly2sym(new_d(k, 1:end), s);
    terms = terms + snum/sden;
end
terms = terms + K_s;

%�� ���ö� ��ȯ
res = [];
res = ilaplace(terms);
res = simplify(res, 'Steps',10);
res = collect(res, exp(-t)); %exp(-t)�� �������� ���׽��� ���� �� ����

