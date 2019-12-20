function main3()
%%
%ctrl+r로 주석, ctrl+t로 주석 해제
%초깃값 주기
% N = [1 2];
% D = [1 4 3 0];

format long;
%%
%초기 값 입력 [1 2] <- 이런 식으로 입력해야 함.
prompt_N = "분자 다항식의 계수를 입력하세요, N(s): ";
N = input(prompt_N);
N
prompt_r = "중복시킬 근 입력: ";
r_input = input(prompt_r);
r_input
prompt_c = "중복시킬 횟수 입력(2이상): ";
cnt = input(prompt_c);
cnt
r = [];
for k = 1:cnt
    r = [r; r_input];
end
r = [r; 0];

%%

K_s = 0;
%해 중에 복소수가 있는 부분을 1로 갖는 벡터 is_complex
is_complex = zeros(1,length(r));
for k = 1:length(r)
    if ~isreal(r(k)) %r(k)가 복소수면, 실수가 아니면
        is_complex(k) = 1;
    end
end


%% 실측 값에서의 오차가 라플라스 역변환에 미치는 영향
hold off
format long;
[c, order_r] = partial_fraction(N, r);
[new_c, new_d] = coeff_changer(c, r);

res = inverse_laplace(new_c, new_d,K_s, is_complex, order_r);
r

res
% fplot(res, [-9, 6]); %범례 for 그래프 유사한 지 비교
% hold on %범례 for 그래프 유사한 지 비교
res_origin = res;


% fplot(res);
% hold on

h = 1;
for i = 1:5
    %오차 구하기
    h = h*1e-2;
    r_temp = r;
    for k = 1:length(r_temp)
%         rng('default'); % For reproducibility 주석 해제 시 같은 난수로 오차 발생
        rnd_num = randi([1 10]); %난수 생성
        rnd_num = rnd_num*h; %오차의 크기를 변경하기 위한 h
        r_temp(k) = r(k)+((-1)^(randi([1,2])))*rnd_num; %난수를 근에 더해줌으로써 실제 측정값으로 나올만한 값으로 만들어 준다. 즉, 오차를 포함한 값
                                                      %(-1)^randi([1,2]): 음, 양 부호를 random하게 줌    
        
    end

    
    [c, order_r] = partial_fraction(N, r_temp);
    [new_c, new_d] = coeff_changer(c, r_temp);
    res = inverse_laplace(new_c, new_d,K_s, is_complex, order_r);
    r_temp
    res
%     fplot(res, [-9, 6]); %범례 for 그래프 유사한 지 비교
    fplot(res_origin-res); %오차 계산 후 plot
    hold on

end
% legend('h: 1','h: 1e-2', 'h: 1e-4', 'h: 1e-6' , 'h: 1e-8'); %범례 for 그래프 유사한 지 비교
legend('h: 1e-2', 'h: 1e-4', 'h: 1e-6' , 'h: 1e-8', 'h: 1e-10'); %범례 for 오차 비교

