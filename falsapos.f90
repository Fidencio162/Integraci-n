program falsapos
	implicit double precision(a-h,o-z)
	parameter(kmax=5000)
	dimension r(kmax)
	print*, 'Introduzca el valor de a: '
	read(*,*), a
	print*, 'Introduzca el valor de b: '
	read(*,*), b
	print*, 'Introduzca la tolerancia: '
	read(*,*), tol
	open(unit=1,file="falsapos2.dat")
	! método de la falsa posicion
	write(1,*),'------------------------------------------------------'
	write(1,*),'|         k','  |       raíz','       |          error     |'
	write(1,*),'------------------------------------------------------'
	do k=1,20!,60
	c=(a*f(b)-b*f(a))/(f(b)-f(a))
	dis=f(a)*f(c)
	if (dis .lt. 0.d0) then
		b=c
	else
		a=c
	endif
	e=abs((b-a)/b)*100.d0
	write(1,*), k,c,e
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
