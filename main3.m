function main3()
%%
%ctrl+r�� �ּ�, ctrl+t�� �ּ� ����
%�ʱ갪 �ֱ�
% N = [1 2];
% D = [1 4 3 0];

format long;
%%
%�ʱ� �� �Է� [1 2] <- �̷� ������ �Է��ؾ� ��.
prompt_N = "���� ���׽��� ����� �Է��ϼ���, N(s): ";
N = input(prompt_N);
N
prompt_r = "�ߺ���ų �� �Է�: ";
r_input = input(prompt_r);
r_input
prompt_c = "�ߺ���ų Ƚ�� �Է�(2�̻�): ";
cnt = input(prompt_c);
cnt
r = [];
for k = 1:cnt
    r = [r; r_input];
end
r = [r; 0];

%%

K_s = 0;
%�� �߿� ���Ҽ��� �ִ� �κ��� 1�� ���� ���� is_complex
is_complex = zeros(1,length(r));
for k = 1:length(r)
    if ~isreal(r(k)) %r(k)�� ���Ҽ���, �Ǽ��� �ƴϸ�
        is_complex(k) = 1;
    end
end


%% ���� �������� ������ ���ö� ����ȯ�� ��ġ�� ����
hold off
format long;
[c, order_r] = partial_fraction(N, r);
[new_c, new_d] = coeff_changer(c, r);

res = inverse_laplace(new_c, new_d,K_s, is_complex, order_r);
r

res
% fplot(res, [-9, 6]); %���� for �׷��� ������ �� ��
% hold on %���� for �׷��� ������ �� ��
res_origin = res;


% fplot(res);
% hold on

h = 1;
for i = 1:5
    %���� ���ϱ�
    h = h*1e-2;
    r_temp = r;
    for k = 1:length(r_temp)
%         rng('default'); % For reproducibility �ּ� ���� �� ���� ������ ���� �߻�
        rnd_num = randi([1 10]); %���� ����
        rnd_num = rnd_num*h; %������ ũ�⸦ �����ϱ� ���� h
        r_temp(k) = r(k)+((-1)^(randi([1,2])))*rnd_num; %������ �ٿ� ���������ν� ���� ���������� ���ø��� ������ ����� �ش�. ��, ������ ������ ��
                                                      %(-1)^randi([1,2]): ��, �� ��ȣ�� random�ϰ� ��    
        
    end

    
    [c, order_r] = partial_fraction(N, r_temp);
    [new_c, new_d] = coeff_changer(c, r_temp);
    res = inverse_laplace(new_c, new_d,K_s, is_complex, order_r);
    r_temp
    res
%     fplot(res, [-9, 6]); %���� for �׷��� ������ �� ��
    fplot(res_origin-res); %���� ��� �� plot
    hold on

end
% legend('h: 1','h: 1e-2', 'h: 1e-4', 'h: 1e-6' , 'h: 1e-8'); %���� for �׷��� ������ �� ��
legend('h: 1e-2', 'h: 1e-4', 'h: 1e-6' , 'h: 1e-8', 'h: 1e-10'); %���� for ���� ��

