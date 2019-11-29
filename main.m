function main()
%%
%ctrl+r로 주석, ctrl+t로 주석 해제
%초깃값 주기
%N = [1 2];
%D = [1 4 3 0];

%%
%초기 값 입력 [1 2] <- 이런 식으로 입력해야 함.
prompt_N = "분자 다항식의 계수를 입력하세요, N(s): ";
N = input(prompt_N);
N
prompt_D = "분모 다항식의 계수를 입력하세요, D(s): ";
D = input(prompt_D);
D

%%
%N의 차수가 D보다 큰 경우
syms s
K_s = [];
if size(N) > size(D)
    Q, K_s = deconv(N, D);
    N = Q;
end
K_s = poly2sym(K_s,s);

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


%%

[c, order_r] = partial_fraction(N, r);
[new_c, new_d] = complex_changer(c, r, order_r, is_complex);
res = inverse_laplace(new_c, new_d, K_s);
res

% c
% r
% K_s
