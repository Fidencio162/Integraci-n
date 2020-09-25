program NewtonRap
  implicit double precision(a-h,o-z)
	parameter(kmax=5000)
	dimension r(kmax)
	tol=2.0d0
	! método de Newton-Rapson
	! Condiciones Iniciales
	k=1
	r(1)=2
	write(*,*)'----------------------------------------------------------'
	write(*,*)'|         k','  |       raíz','       |       error            |'
	write(*,*)'----------------------------------------------------------'
	write(*,*) 1,r(1),'          ---'
	do
	k=k+1
	r(k+1)=r(k)-f(r(k))/df(r(k))
	e=abs((r(k+1)-r(k))/r(k+1))*100.d0
	c=r(k+1)
	write(*,*) k,r(k+1),e
	if (e.lt.tol) exit
	enddo
	write(*,*) '----------------------------------------------------------'
	write(*,*) 'Solucion:'
	write(*,*) 'raíz=',c
	write(*,*) 'error=',e
   20	format(i5,2x,f3.8,2x,f3.8)
end program

	function f(x)
	implicit double precision(a-h,o-z)
	f=x**3-2.d0*x-5
	return
	end
	
	function df(x)
	implicit double precision(a-h,o-z)
	df=3.d0*x**2-2.d0
	return
	end
