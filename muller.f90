	program muller
	implicit none
	double complex Deltaf012,Deltaf01,Deltaf02,Deltaf12, &
	&  a,b,c,x1,x2,xn,x0,f,modulus,ec,fn
	double precision tol,e
	integer k,n
	print*, "Introduce el primer punto:"
	read*, x0
	print*, "Introduce el segundo punto:"
	read*, x1
	print*, "Introduce el tercer punto:"
	read*, x2
	open(unit=1,file='mullerc2.dat')
	tol=0.00001d0
	k=0
	write(1,*)'-------------------------------------------------------------------------'
	write(1,*)'|         k','  |      (Re(raíz),','    Im(raiz))','       |       error         |'
	write(1,*)'-------------------------------------------------------------------------'
	do
	k=k+1
	Deltaf01=(f(x1)-f(x0))/(x1-x0)
	Deltaf12=(f(x2)-f(x1))/(x2-x1)
	Deltaf02=(f(x2)-f(x0))/(x2-x0)
	Deltaf012=(Deltaf12-Deltaf01)/(x2-x0)
	a=Deltaf012
	b=Deltaf02+Deltaf12-Deltaf01
	c=f(x2)
	xn=x2+(-b+sqrt(b**2-4.d0*a*c))/(2.d0*a)
	ec=(xn-x2)/xn
	e=abs(ec)*100.d0
		x1=x2
		x2=xn
	fn=f(xn)
	write(1,*) k,xn,e
	if(e.lt.tol) exit
	enddo
	write(1,*) '----------------------------------------------------------'
	write(1,*) 'Solucion:'
	if (dimag(xn).eq. 0.d0) then
	write(1,*) 'raíz=',real(xn) !,'+-',dimag(xn),'i'
	else
	write(1,*) 'raíz=',real(xn),'+-',dimag(xn),'i'
	endif
	write(1,*) 'error=',e
	end program
	
	function f(x)
	double complex f,x
	f=x**3-x**2+3.d0*x-2.d0
	!f=2.d0*x**4+6.d0*x**2+10.d0 !b)
	!f=x**4-2.d0*x**3+6.d0*x**2-8.d0*x+8.d0 !c)
	return
	end
