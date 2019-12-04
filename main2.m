function main2()
%%
%ctrl+r�� �ּ�, ctrl+t�� �ּ� ����
%�ʱ갪 �ֱ�
% N = [1 2];
% D = [1 4 3 0];

%%
%�ʱ� �� �Է� [1 2] <- �̷� ������ �Է��ؾ� ��.
prompt_N = "���� ���׽��� ����� �Է��ϼ���, N(s): ";
N = input(prompt_N);
N
prompt_D = "�и� ���׽��� ����� �Է��ϼ���, D(s): ";
D = input(prompt_D);
D
% prompt_r = "�ظ� �Է��ϼ���, r: ";
% r = input(prompt_r);
% r

%%
%N�� ������ D���� ū ���
syms s
Q = [];
if size(N,2) >= size(D,2)
    [Q, ~] = deconv(N, D);
    N = N-conv(Q,D);
end
K_s = poly2sym(Q,s);
% K_s =0;
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


%% ���� �������� ������ ���ö� ����ȯ�� ��ġ�� ����
[c, order_r] = partial_fraction(N, r);
[new_c, new_d] = coeff_changer(c, r, order_r);
res = inverse_laplace(new_c, new_d, K_s, is_complex, order_r);
r
res
res_origin = res;

hold off
% fplot(res);
% hold on

h = 1e-3;
for i = 1:3
    %���� ���ϱ�
    h = h*0.1;
    r_temp = r;
    for k = 1:length(r_temp)
        %rng('default'); % For reproducibility
        rnd_num = randn; %���� ����(���� ����)
        rnd_num = rnd_num*h; %������ ũ�⸦ �����ϱ� ���� h
        r_temp(k) = r(k)+rnd_num; %������ �ٿ� ���������ν� ���� ���������� ���ø��� ������ ����� �ش�. ��, ������ ������ ��
    end

    [c, order_r] = partial_fraction(N, r_temp);
    [new_c, new_d] = coeff_changer(c, r_temp, order_r);
    res = inverse_laplace(new_c, new_d, K_s, is_complex, order_r);
    r_temp
    res
    
    fplot(res_origin-res, [-1, 1]); %���� ��� �� plot
    hold on

end
legend('h: 0.001', 'h: 0.0001', 'h: 0.00001'); %����

