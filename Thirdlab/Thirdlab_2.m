pkg load symbolic;

close all;
clc;
clear;

F = input('Введите функцию: F(x)= ','s');
f = inline(F);

epsilon = 0.0001;

LeftLimit = input('Введите начало промежутка: ');
RightLimit = LeftLimit;
while RightLimit <= LeftLimit
    RightLimit = input('Введите конец промежутка: ');
    if RightLimit < LeftLimit
        disp('error');
    endif
endwhile

XX = linspace(LeftLimit, RightLimit, (RightLimit - LeftLimit)*25);

A = 0;
while A < 1
    A = input('Введите степень приближения: ');
    if A < 1
        disp('error');
    endif
endwhile
% точки Чебышева n + 2
H = 0 : (A + 2 - 1);  
X = 0.5*((LeftLimit-RightLimit)*cos((2*H + 1)/(A + 2)*0.5*pi) + LeftLimit + RightLimit); 
while (1)
% Формирование матрицы коэффициентов
    one = ones(1,A+2)*(-1);
    for i = 1 : (A + 1)
        koef(:, i) = X.^i; 
        one(i) = one(i).^i;
    endfor
    one(A + 2) = one (A + 2).^(A + 2);
    koef(:, A + 2) = one;
    leftexpr = f(X)';
    anser = koef\leftexpr; 
    Qn = anser(1 : (A + 1)); % Коэффициенты многочлена
    QnPolin = zeros(size(XX));
    for j = 1 : length(Qn)
        QnPolin = Qn(j)*XX.^(j - 1) + QnPolin;
    endfor
    sigma = anser(A + 2);
% поиск точки глобального максимума
    [maxim, indx] = max(abs(f(XX) - QnPolin));
    pointChang = FNVSV(X, XX(indx));
    

    
    
    figure(1);
    plot(XX, f(XX), 'color', 'r');
    plot(X, QnPolin(X), 'color', 'g');
    
    switch (pointChang)
      case 1 : length(X): 
          X(pointChang) = maxim;
      case (lenght(X) + 1) : (lenght(X) + 2):
          for i = 1 : lenght(X) - 1
              X(i) = X(i + 1);
          endfor
          X(lenght(X)) = maxim;
      case (lenght(X) - 2) : (lenght(X) - 1):
          for i = lenght(X) : -1 : 2
              X(i) = X(i - 1);
          endfor
          X(1) = maxim;
    endswitch

    h = abs(f(XX(pointChang)) - QnPolin)

    if epsilon > h - abs(sigma)
        break;
    endif
endwhile






