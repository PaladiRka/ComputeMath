clf
a=1;   b=7;            % отрезок интерполирования
n=6;                % степень интерп. многочлена
Fun=@(x)  1/x;       % интерполируемая функция
x=(a+b)/2 + (b-a)/2*cos(pi*(n+2-(1:(n+2)))/(n+1));
eps=0.0001;         % требуемая погрешность
d=100;              % текущая погрешность
i=1:n+2;
xmax=b+100;         % новая точка интерполяции (т. максимума |F - P|)
A=ones(n+2,n+2);
qwer = -1;
while d>eps 
    qwer = qwer + 2        
    dold=d;         
    for ind=1:n         %
       for k=i          % подсчет коэффициентов полинома
           A(k,ind)=x(k).^(n-ind+1);    % наилучшего приближения
       end              %
    end             %
    A(i,n+2)=(-1).^(i+1);       %
    B=Fun(x)';          %
    C=A\B;              %
    Cp=C(1:n+1);            
    max=0;              
    xmaxold=xmax;   
    delta=@(x) -abs(Fun(x)-polyval(Cp,x));  % |F - P|
    
    % поиск xmax - точки с максимальной величиной ошибки
    
    for ind=a:((b-a)/100):(b-(b-a)/30)
        [xxmax,df]=fminbnd(delta,ind,ind+(b-a)/30);
        if (df<max)
            xmax=xxmax;
            max=df;
        end
    end
    
    x2=a:0.1:b;
    figure(qwer); %график ошибки на промежутке
    plot(x2,delta(x2));
    figure(qwer+1);
    plot(x2,Fun(x2),x2,polyval(Cp,x2));%график функции и полученного полинома на промежутке
    
    %добавляем новую точку интерполяции в Х
    for i = 1:n+2
        if (i>1 && i<n+2 && x(i-1)<xmax && x(i+1)>xmax)
            x(i)=xmax;
        end
    end
    d=abs(abs(C(n+2))+max);     % подсчитываем погрешность
end
xx=a:0.1:b;
remezfunc=@(x) polyval(Cp,x);
plot(xx,remezfunc(xx),xx,Fun(xx));  % рисуем фунцию и полином
grid on;