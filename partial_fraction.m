function [c,order_r] = partial_fraction(N, r)
% N = [1 3];
% r = [-1; -1; -2];

r = r'; %열벡터로 되어 있는 r을 행 벡터로 전치

%%
%partial_fraction결과 부분 분수 분모의 차수, order가 2 이상이면 중근 포함
order_r = ones(1,length(r));

for k = 1:length(r)-1
    for j = k+1:length(r)
        if r(k) == r(j)
            order_r(j) = order_r(j)+1;
        end
    end
end

%미정 계수를 구할 때, 미분을 몇번 해야 하는 지
deriv_count = ones(1,length(r));

for k = 1:length(r)-1
    for j = k+1:length(r)
        if r(k) == r(j)
            deriv_count(k) = deriv_count(k)+1;
        end
    end
end



%order와 r을 참조해 c값을 구한다.(N과 find_dif_poly값을 계산해서)
c = zeros(1, length(r));
for i = 1:length(r)
    if deriv_count(i) == 1 %분모 항의 차수가 1인 경우, deriv_count도 1임, 이 경우 미분 없이 구함
        c(i) = polyval(N,r(i)) / polyval(find_dif_poly(r, r(i)), r(i));
    else %필요한 미분 횟수 2 이상
        [N_d,D_d] = polyder(N,find_dif_poly(r, r(i)));
        for k = 2: deriv_count(i)-1
            [N_d,D_d] = polyder(N_d,D_d);
        end
        c(i) = polyval(N_d, r(i))/polyval(D_d, r(i));
        
    end
         
end
  

function res = find_dif_poly(r, pole) %D(s) 중 자신의 항을 제외한 다항식 반환
dif_r = [];
for n = 1:length(r)
    if r(n) ~= pole
        dif_r = [dif_r r(n)];
    end
end

%만일 다중근으로만 이루어진 다항식이라면? -> 1만 반환한다.(나눠줄 필요가 없기에)
if isempty(dif_r)
    res = 1;
    return;
end    

res = [1 -dif_r(1)];

for j = 2:length(dif_r)
    res = conv(res, [1 -dif_r(j)]); %다항식 계수 convolution 곱으로 계산
end
   

    
    

    
