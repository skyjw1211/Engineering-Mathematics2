function main2()
%%
%ctrl+r로 주석, ctrl+t로 주석 해제
%초깃값 주기
% N = [1 2];
% D = [1 4 3 0];

%%
%초기 값 입력 [1 2] <- 이런 식으로 입력해야 함.
prompt_N = "분자 다항식의 계수를 입력하세요, N(s): ";
N = input(prompt_N);
N
prompt_D = "분모 다항식의 계수를 입력하세요, D(s): ";
D = input(prompt_D);
D
% prompt_r = "해를 입력하세요, r: ";
% r = input(prompt_r);
% r

%%
%N의 차수가 D보다 큰 경우
syms s
Q = [];
if size(N,2) >= size(D,2)
    [Q, ~] = deconv(N, D);
    N = N-conv(Q,D);
end
K_s = poly2sym(Q,s);
% K_s =0;
%%
%Bairstow방식으로 분모 다항식의 해 구하기
r = Bairstow(D); %bairstow 해


%해 중에 복소수가 있는 부분을 1로 갖는 벡터 is_complex
is_complex = zeros(1,length(r));
for k = 1:length(r)
    if ~isreal(r(k)) %r(k)가 복소수면, 실수가 아니면
        is_complex(k) = 1;
    end
end


%% 실측 값에서의 오차가 라플라스 역변환에 미치는 영향
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
    %오차 구하기
    h = h*0.1;
    r_temp = r;
    for k = 1:length(r_temp)
        %rng('default'); % For reproducibility
        rnd_num = randn; %난수 생성(정규 분포)
        rnd_num = rnd_num*h; %오차의 크기를 변경하기 위한 h
        r_temp(k) = r(k)+rnd_num; %난수를 근에 더해줌으로써 실제 측정값으로 나올만한 값으로 만들어 준다. 즉, 오차를 포함한 값
    end

    [c, order_r] = partial_fraction(N, r_temp);
    [new_c, new_d] = coeff_changer(c, r_temp, order_r);
    res = inverse_laplace(new_c, new_d, K_s, is_complex, order_r);
    r_temp
    res
    
    fplot(res_origin-res, [-1, 1]); %오차 계산 후 plot
    hold on

end
legend('h: 0.001', 'h: 0.0001', 'h: 0.00001'); %범례

