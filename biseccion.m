% Fidencio Pérez-Hernández
clear all
format long;
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
tol=input('Introduzca la tolerancia: ');
fun=input('introduca la funcion f(x)=','s');
f=inline(fun);
k=1
while((abs((b-a)/2)*100)>tol)
    c=(a+b)/2;
    if f(a)*f(c)<0
        b=c;
    else
        a=c;
    end
    k=k+1;
    e=abs((b-a)/2)*100;
    A(k,:)=[k a b c f(c) e];
end
fprintf('\tk \ta \tb \tc \tf(c) \te \n')
disp(A)
fprintf('Solucion: \n raíz=%8.5f\n',c)
fprintf('f(c)=%8.5f\n',f(c))
fprintf('error=%8.5f\n',e)
