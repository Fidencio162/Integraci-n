clear all
format long;
a=input('Introduzca el límite inferior:');
b=input('Introduzca el límite superior:');
n=input('Intriduzca n:');
fun=input('introduzca la función f(x)=','s');
f=inline(fun);
Ireal=1.64053;
% Regal del Trapecio
h=(b-a)/n;
f0=f(a);
fn=f(b);
fxi=0;
for k=1:n-1
    xi=a+h*k;
    fxi=fxi+f(xi);
end
TrapInt=(h/2)*(f0+2*fxi+fn);
Err=abs(TrapInt-Ireal);
fprintf('Solucion: \n Integra=%8.5f\n',TrapInt)
fprintf('error=%8.5f\n',Err)
