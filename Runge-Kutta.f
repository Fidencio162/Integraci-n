	program LaneEmden
	real*8 t,t1,x1,y1,x2,y2,t2,a1,b1,a2,b2,a3,b3,a4,b4,h,f,g,theta,xi
	real*8 xi1,n
	integer i
	print *, 'Solucion de la ecuacion de Lane-Emden'
	print *, '-------------------------------------'
	print *, ' Método de Runge-Kutta de 4to Orden'
	print *, '-------------------------------------'
	print *, 'introduzca el tamaño de los pasos (h)'
	read *, h
	print *, 'Introduzca el valor de n'
	read *, n
	
	open(1,file='Lane-Emden.dat')
	
	t1=0.000001
	x1=1
	y1=0
!	xi1=1
	
	write(1,*)t1,x1,y1
	do i=1,10000
		a1=f(t1,x1,y1)
		b1=g(t1,x1,y1,n)
		a2=f(t1+0.5*h,x1+0.5*h*a1,y1+0.5*h*b1)
		b2=g(t1+0.5*h,x1+0.5*h*a1,y1+0.5*h*b1,n)
		a3=f(t1+0.5*h,x1+0.5*h*a2,y1+0.5*h*b2)
		b3=g(t1+0.5*h,x1+0.5*h*a2,y1+0.5*h*b2,n)
		a4=f(t1+h,x1+h*a3,y1+h*b3)
		b4=g(t1+h,x1+h*a3,y1+h*b3,n)

		x2=x1+h/6*(a1+2*a2+2*a3+a4)
		y2=y1+h/6*(b1+2*b2+2*b3+b4)
		t2=t1+h
!		theta=xi(t1+h)
		write(1,*)t2,x2,y2
		x1=x2
		y1=y2
		t1=t2
	enddo
	
 	!call system('gnuplot plotLane-Emden.gnu')
	!call system('gnuplot postcriptLane.gnu')
	!stop
	end

	function f(t,x,y)
	real*8 t,x,y,f
	f=-y/t**2
	return
	end

	function g(t,x,y,n)
	real*8 t,x,y,g,n
!	integer n
!	write(*,*) n
	g=x**n*t**2
	return
	end
	
!	function xi(t)
!	real*8 t,x,y,xi
!	xi=sin(t)/t
!	return 
!	end
