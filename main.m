function main()
%%
%ctrl+r�� �ּ�, ctrl+t�� �ּ� ����
%�ʱ갪 �ֱ�
N = [1 2];
D = [1 4 3 0];

%%
%�ʱ� �� �Է� [1 2] <- �̷� ������ �Է��ؾ� ��.
% prompt_N = "���� ���׽��� ����� �Է��ϼ���, N(s): ";
% N = input(prompt_N);
% N
% prompt_D = "�и� ���׽��� ����� �Է��ϼ���, D(s): ";
% D = input(prompt_D);
% D

%%
%N�� ������ D���� ū ���
syms s
K_s = [];
if size(N) > size(D)
    Q, K_s = deconv(N, D);
    N = Q;
end
K_s = poly2sym(K_s,s);

%%
%Bairstow������� �и� ���׽��� �� ���ϱ�
r = Bairstow(D); %bairstow ��


%�� �߿� ���Ҽ��� �ִ� �κ��� 1�� ���� ���� is_complex
is_complex = zeros(1,length(r));
for k = 1:length(r)
    if ~isreal(r(k)) %r(k)�� ���Ҽ���, �Ǽ��� �ƴϸ�
        is_complex(k) = 1;
    end
end


%%

[c, order_r] = partial_fraction(N, r);
[new_c, new_d] = complex_changer(c, r, order_r, is_complex);
res = inverse_laplace(new_c, new_d, K_s);
res

% c
% r
% K_s