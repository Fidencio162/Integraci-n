clear all
format long;
xi=input('Introduzca el valor inicial: ');
tol=input('Introduzca la tolerancia: ');
fun=input('introduca la funcion f(x)=','s');
f=inline(fun);
dfun=input('introduca la funcion df(x)=','s');
df=inline(dfun);
k=0;
e=100;
while e>tol
    ri=xi-f(xi)/df(xi);
    e=abs((ri-xi)/ri)*100;
    xi=ri;
    k=k+1;
    A(k,:)=[k xi e];
end
fprintf('\t \tk \t \traiz \t \terror \n')
disp(A)
fprintf('Solucion: \n raíz=%5.10f\n',xi)
fprintf('error=%5.10f\n',e)
