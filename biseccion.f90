program biseccion
	implicit double precision(a-h,o-z)
	parameter(kmax=5000)
	dimension r(kmax)
	print*, 'Introduzca el valor de a: '
	read(*,*), a
	print*, 'Introduzca el valor de b: '
	read(*,*), b
	print*, 'Introduzca la tolerancia: '
	read(*,*), tol
	open(unit=1,file="biseccion.dat")
	! método de bisección
	k=0
	write(1,*),'------------------------------------------------------'
	write(1,*),'|         k','  |       raíz','       |          error     |'
	write(1,*),'------------------------------------------------------'
	do
	c=(a+b)/2
	dis=f(a)*f(c)
	if (dis .lt. 0.d0) then
		b=c
	else
		a=c
	endif
	k=k+1
	e=abs((b-a)/b)*100.d0
	write(1,*), k,c,e
	if (e.lt.tol) exit
	enddo
	write(1,*), '------------------------------------------------------'
	write(1,*), 'Solucion:'
	write(1,*), 'raíz= ',c
	write(1,*), 'error=',e
   20	format(i5,2x,f3.8,2x,f3.8)
end program

	function f(x)
	implicit double precision(a-h,o-z)
	f=x**6-1
	return
	end
