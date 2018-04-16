pkg load symbolic;

close all;
clc;
clear;

F = input('Введите функцию: F(x)= ','s');
f = inline(F);

epsilon = -1;
while epsilon < 0
    epsilon = input('Введите погрешность: ');
    if epsilon < 0
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

XX = linspace(LeftLimit, RightLimit, (RightLimit - LeftLimit)*100);

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
    maxim
    XX(indx)
    % Графики %%%%%%%%
    figure(qwertyu);
    hold on;
    plot(XX, polyval(NewVar,XX), 'b');
    plot(XX, f(XX), 'r');
    legend('polynom', 'function');
    plot(X, polyval(NewVar,X), 'ko');
    hold off;
    %%%%%%%%%%%%%%%%%%
    
    [leftborder, rightborder] = FNVSV(X, XX(indx));
    if leftborder == 0
        usl = (polyval(NewVar,X(1)) - f(X(1)))*(polyval(NewVar,XX(indx)) - f(XX(indx)))
        if usl > 0
            pointChang = 1;
        else
            pointChang = 0;
        endif
    else
        usl = (polyval(NewVar,X(leftborder)) - f(X(leftborder)))*(polyval(NewVar,XX(indx)) - f(XX(indx)))
        if usl > 0
            pointChang = leftborder;
        else
            pointChang = rightborder;
        endif
    endif             
    
    
    if ((pointChang >= 1) && (pointChang <= length(X))) 
          X(pointChang) = XX(indx);
      elseif pointChang > length(X)
          for i = 1 : length(X) - 1
              X(i) = X(i + 1);
          endfor
          X(length(X)) = XX(indx);
          pointChang = length(X);
      elseif pointChang < 1
          for i = length(X) : -1 : 2
              X(i) = X(i - 1);
          endfor
          X(1) = XX(indx);
          pointChang = 1;
    endif

    h = abs(f(X(pointChang)) - polyval(NewVar,X(pointChang)));
    h - abs(sigma)
    if epsilon > (h - abs(sigma))
        break;
    endif
endwhile