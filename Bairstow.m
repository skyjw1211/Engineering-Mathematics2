function r = Bairstow(a)
global b
a = fliplr(a);  r = [];
while(numel(a) >2) 
    r2 = bairstow(a);
    r = [r;r2];
    a = b;
end
if(numel(a) == 2) %���� ���׽��� 1�����̸�, �� ���տ� �� �������� �� �߰�
    r = [r;-a(1)/a(2)];
end

function r2 = bairstow(a)
error = 1;
n = numel(a);
u = a(n-1)/a(n);
v = a(n-2)/a(n);
while error > 1e-10
    [c,d,g,h] = cdgh(a, u, v);
    D = v*g^2 + h*(h - u*g);
    u = u - (g*d - c*h)/D;
    v = v - ((u*g - h)*d - c*v*g)/D;
    error = norm([c,d]);
end
D = sqrt(u^2-4*v);
r2 = [0.5*(-u + D);0.5*(-u - D)];


function [c,d,g,h] = cdgh(a, u, v) %c,d,g,h ã�Ƽ� ��������, ���������
global b
b = zeros(size(a)); f = b; n = numel(b);
for i = n-2:-1:1
    b(i) = a(i+2) - u*b(i+1) - v*b(i+2);
    f(i) = b(i+2) - u*f(i+1) - v*f(i+2);
end
c = a(2) - u*b(1) - v*b(2);
g = b(2) - u*f(1) - v*f(2);
d = a(1) - v*b(1);
h = b(1) - v*f(1);
b = b(1:n-2);