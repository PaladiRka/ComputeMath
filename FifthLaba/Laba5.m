close all;
clc;
clear;

func = @(x) 1000./(x.^2 -7.*x + 73);

dfunc = @(x) -(1000*(-7 + 2.*x))./(73 - 7.*x + x.^2).^2;

d2func = @(x) (6000*(-8 - 7.*x + x.^2))./(73 - 7.*x + x.^2).^3;

Alfa1 =[];
Alfa2 =[];
Alfa3 =[];
Alfa4 =[];
Alfa5 =[];
Alfa6 =[];

for j = 10:100
 
		x = linspace(2, 4, j);
		[d, ind] = min(abs(x - 3));
		h=x(2)-x(1);
		k=rand * 0.0001 - 0.00005;
		
		f12 = func(x(ind - 2)) + k;
    f11 = func(x(ind - 1)) + k;
    f0 = func(x(ind)) + k;
    f1 = func(x(ind + 1)) + k;
    f2 = func(x(ind + 2)) + k;
    f3 = func(x(ind + 3)) + k;    
% Первая производная (наиваня)
    p1 = (f1 - f0)/h;
    del1 = abs(dfunc(x(ind)) - p1);
    alpha1 = -log(del1)/log(ind);
    Alfa1= [Alfa1 alpha1];
        
% Первая производная (h^2)        
    p2 = (f1 - f11)/(2*h);
    del2 = abs(dfunc(x(ind)) - p2);
    alpha2 = -log(del2)/log(ind);
    Alfa2= [Alfa2 alpha2];    
% Фурмала Рунге-Кутге (h^2)       
    p3 = (-3 * f0 + 4 * f1 - f2)/(2*h);
    del3 = abs(dfunc(x(ind)) - p2);
    alpha3 = -log(del3)/log(ind);
    Alfa3= [Alfa3 alpha3];       
% Фурмала Рунге-Кутге (h^3)
    p4 = (-11 * f0 + 18 * f1 - 9 * f2 + 2 * f3)/(6*h);
    del4 = abs(dfunc(x(ind)) - p4);
    alpha4 = -log(del4)/log(ind);
    Alfa4= [Alfa4 alpha4];         
% Вторая производная по одной точке       
    p5 = (f1 - 2 * f0 + f11)/(h^2);
    del5 = abs(d2func(x(ind)) - p5);
    alpha5 = -log(del5)/log(ind);
    Alfa5= [Alfa5 alpha5];        
% Вторая производная по двум точкам        
    p6 = (- f12 + 16 * f11 - 30 * f0 + 16 * f1 - f2)/(12 * h^2);
    del6 = abs(d2func(x(ind)) - p6);
    alpha6 = -log(del6)/log(ind);
    Alfa6= [Alfa6 alpha6];          
end

j=10:100;
plot (j, Alfa1, 'c');
hold on 
plot (j, Alfa2, 'm');
plot (j, Alfa3, 'y');
plot (j, Alfa4, 'r');
plot (j, Alfa5, 'g');
plot (j, Alfa6, 'k');
legend('Alfa 1', 'Alfa 2', 'Alfa 3', 'Alfa 4', 'Alfa 5', 'Alfa 6');
grid on;