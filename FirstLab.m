pkg load symbolic;

close all;
clc;
clear;


F = input('Введите функцию: F(x)= ','s');

f = inline(F);

A = 0;
while A < 1
    A = input('Введите количество точек: ');
    if A < 1
        disp('error');
    endif
endwhile

LeftLimit = input('Введите начало промежутка: ');
RightLimit = LeftLimit;
while RightLimit <= LeftLimit
    RightLimit = input('Введите конец промежутка: ');
    if RightLimit < LeftLimit
        disp('error');
    endif
endwhile

anser = 0;
while (anser != 1) && (anser != 2) && (anser != 3)
    anser = input('Задать равномерное разбиение или по точкам?(1 - равномерное, 2 - по точкам, 3 - по Чебышеву):  ');
endwhile

switch (anser) 
    case 1
        lngt = (RightLimit - LeftLimit);
        X = LeftLimit : lngt/(A - 1) : RightLimit;
    case 2
        X = eye(A,1);
        for i = 1 : A
            do
                X(i) = input('x=');
                if (X(i) < LeftLimit) || (X(i) > RightLimit)
                    disp('error');
                endif
            until(X(i) >= LeftLimit) && (X(i) <= RightLimit);
        endfor
    case 3
        H = 0 : (A - 1);
        X = 0.5*((LeftLimit-RightLimit)*cos((2*H + 1)/A*0.5*pi) + LeftLimit + RightLimit);
endswitch    


Y = f(X);

diap = linspace(LeftLimit, RightLimit, (RightLimit - LeftLimit)*100);

do
    ErrorPoint = input('Введите координату Х для проверки: ');
    if (ErrorPoint < LeftLimit) || (ErrorPoint > RightLimit)
        disp('error');
    endif
until(ErrorPoint >= LeftLimit) && (ErrorPoint <= RightLimit);

syms x;

maxim = diff(f(x),A + 1);
maxim = max (f(diap));


wn = ones(size(ErrorPoint));
if anser == 3
    wn = abs(RightLimit - LeftLimit)/2^(A - 1);
else
    for i = 1 : A
        wn = wn.*(ErrorPoint .- X(i));
    endfor
endif

ErrorTeoretical = wn*maxim/factorial(A + 1);

LagrangePointPolinom = LagrangPolinom(Y, X, diap);
NewtonPointPolinom = NewtonPolinom(Y, X, diap);

LagrangErrorPointY = LagrangPolinom(Y,X,ErrorPoint);
NewtonErrorPointY = NewtonPolinom(Y,X,ErrorPoint);

LagrangErrorPractical = abs(f(ErrorPoint) - LagrangErrorPointY);
NewtonErrorPractical = abs(f(ErrorPoint) - NewtonErrorPointY);

LagrangAns = abs(ErrorTeoretical) - abs(LagrangErrorPractical)
NewtonAns = abs(ErrorTeoretical) - abs(NewtonErrorPractical)

figure(1);
hold on;
grid on;
plot(X,Y,'bo','color','b');
plot(diap,f(diap),'color','m');
plot(diap,LagrangePointPolinom,'color','c');
plot(ErrorPoint,LagrangErrorPointY,'bo','color','r');
legend('interpolation knots','input func','LagrangePolinom','ErrorPoint');

figure(2);
hold on;
grid on;
plot(X,Y,'bo','color','b');
plot(diap,f(diap),'color','m');
plot(diap,NewtonPointPolinom,'color','r');
plot(ErrorPoint,NewtonErrorPointY,'bo','color','r');
legend('interpolation knots','input func','NewtonPolinom','ErrorPoint');

