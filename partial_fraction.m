function [c,order_r] = partial_fraction(N, r)
% N = [1 3];
% r = [-1; -1; -2];

r = r'; %�����ͷ� �Ǿ� �ִ� r�� �� ���ͷ� ��ġ

%%
%partial_fraction��� �κ� �м� �и��� ����, order�� 2 �̻��̸� �߱� ����
order_r = ones(1,length(r));

for k = 1:length(r)-1
    for j = k+1:length(r)
        if r(k) == r(j)
            order_r(j) = order_r(j)+1;
        end
    end
end

%���� ����� ���� ��, �̺��� ��� �ؾ� �ϴ� ��
deriv_count = ones(1,length(r));

for k = 1:length(r)-1
    for j = k+1:length(r)
        if r(k) == r(j)
            deriv_count(k) = deriv_count(k)+1;
        end
    end
end



%order�� r�� ������ c���� ���Ѵ�.(N�� find_dif_poly���� ����ؼ�)
c = zeros(1, length(r));
for i = 1:length(r)
    if deriv_count(i) == 1 %�и� ���� ������ 1�� ���, deriv_count�� 1��, �� ��� �̺� ���� ����
        c(i) = polyval(N,r(i)) / polyval(find_dif_poly(r, r(i)), r(i));
    else %�ʿ��� �̺� Ƚ�� 2 �̻�
        [N_d,D_d] = polyder(N,find_dif_poly(r, r(i)));
        for k = 2: deriv_count(i)-1
            [N_d,D_d] = polyder(N_d,D_d);
        end
        c(i) = polyval(N_d, r(i))/polyval(D_d, r(i));
        
    end
         
end
  

function res = find_dif_poly(r, pole) %D(s) �� �ڽ��� ���� ������ ���׽� ��ȯ
dif_r = [];
for n = 1:length(r)
    if r(n) ~= pole
        dif_r = [dif_r r(n)];
    end
end

%���� ���߱����θ� �̷���� ���׽��̶��? -> 1�� ��ȯ�Ѵ�.(������ �ʿ䰡 ���⿡)
if isempty(dif_r)
    res = 1;
    return;
end    

res = [1 -dif_r(1)];

for j = 2:length(dif_r)
    res = conv(res, [1 -dif_r(j)]); %���׽� ��� convolution ������ ���
end
   

    
    

    
