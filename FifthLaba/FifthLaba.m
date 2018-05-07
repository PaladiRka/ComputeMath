clc;
clear;
close all;


func = @(x) 1000./(x.^2 -7.*x + 73);
ifunc = quad('1000./(x.^2 -7.*x + 73)',2,4);

n = 4 : 2 : 180;
Alfa1 = [];
Alfa2 = [];
Alfa3 = [];
Alfa4 = [];


for i = 4 : 2 : 180
    x = linspace(2, 4, i + 10);
    h = x(2) - x(1);
    znch = func(x);   
    % метод правых прямоугнольников     
    for j = 2 : i
        in1(j) = (func(x(j)) + (1 - rand())) * h;
    end
    sum1(i) = sum(in1);
    del1 = abs(ifunc - sum1(i));
    alpha1 = log(del1)/log(h);
    Alfa1 = [Alfa1 alpha1];   
    % метод средних прямоугнольников
    for j = 2 : 2 : i
        in2(j/2) = (func(x(j)) + (1 - rand()))*2*h;
    end
    sum2(i) = sum(in2);
    del2 = abs(ifunc - sum2(i));
    alpha2 = log(del2)/log(h);
    Alfa2 =[Alfa2 alpha2];

    % метод трапеций
    for j = 1 : i
        in3(j) = ((func(x(j)) + func(x(j + 1) + 2*(1 - rand())))/2)*h;
    end
    sum3(i) = sum(in3);
    del3 = abs(ifunc - sum3(i));
		alpha3 = log(del3)/log(h);
		Alfa3 =[Alfa3 alpha3];
    % метод Сипсона (Парабола)
    for j = 2 : 2 : i
        in4(j/2) = (func(x(j - 1)) + 2*(1 - rand()) + 4*(func(x(j)) + (1 - rand())) + func(x(j + 1)))*h/3;
    end
    sum4(i) = sum(in4);
    del4 = abs(ifunc - sum4(i));
    alpha4 = log(del4)/log(h);
    Alfa4 =[Alfa4 alpha4];
end


plot (n, Alfa1, 'c');
hold on;
plot (n, Alfa2, 'm');
plot (n, Alfa3, 'y');
plot (n, Alfa4, 'r');
legend('Alfa 1', 'Alfa 2', 'Alfa 3', 'Alfa 4');
grid on;