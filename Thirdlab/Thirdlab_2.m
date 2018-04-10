pkg load symbolic;

close all;
clc;
clear;

F = input('Введите функцию: F(x)= ','s');
f = inline(F);

epsilon = 0.001;

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
qwertyu = 0;
% точки Чебышева n + 2
H = 0 : (A + 2 - 1);
X = 0.5*((LeftLimit-RightLimit)*cos((2*H + 1)/(A + 2)*0.5*pi) + LeftLimit + RightLimit);
while (1)
    % Формирование матрицы коэффициентов
    koef=[];
    one = ones(1, A + 2)*(-1);
    for i = 1 : (A + 1)
        koef(:, i) = X.^(i - 1); 
        one(i) = one(i).^(i - 1);
    endfor
    one(A + 2) = one (A + 2).^(A + 1);
    koef(:, A + 2) = one;
    %законченно
    leftexpr_1 = f(X);
    leftexpr = leftexpr_1';
    anser = koef\leftexpr;
    qwertyu = qwertyu + 1
    Qn = anser(1 : (A + 1)); % Коэффициенты многочлена
    NewVar = Qn(end: -1:1);
    
    sigma = anser(A + 2);
    % поиск точки глобального максимума
    [maxim, indx] = max(abs(f(XX) - polyval(NewVar,XX)));
    

    plot(XX, polyval(NewVar,XX));
    hold on;
    plot(XX, sin(XX));
    
    [leftborder, rightborder] = FNVSV(X, XX(indx));
    if leftborder == 0
        if anser(1)*XX(indx) > 0
            pointChang = 1;
        else
            pointChang = 0;
        endif
    elseif leftborder == length(X)
        if anser(leftborder)*XX(indx) > 0
            pointChang = leftborder;
        else
            pointChang = rightborder;
        endif
    endif             
    
    
    if ((pointChang >= 1) && (pointChang <= length(X))) 
          X(pointChang) = maxim;
      elseif pointChang > length(X)
          for i = 1 : length(X) - 1
              X(i) = X(i + 1);
          endfor
          X(length(X)) = maxim;
          pointChang = length(X);
      elseif pointChang < 1
          for i = length(X) : -1 : 2
              X(i) = X(i - 1);
          endfor
          X(1) = maxim;
          pointChang = 1;
    endif

    h = abs(f(X(pointChang)) - polyval(NewVar,pointChang));

    if epsilon > (h - abs(sigma))
        break;
    endif
endwhile