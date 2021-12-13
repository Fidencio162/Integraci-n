	program Lorenz
	implicit double precision(a-h,o-z)
	
	open(1,file='LorenzRK4.dat')
	
	t1=0.d0
	x1=0.d0
	y1=1.d0
	z1=0.d0
!	---------------------------------------------------
	h=0.0001d0
	h2=0.5d0*h
	h6=h/6.d0
	
	write(1,*)x1,y1,z1
	do i=1,4000000
		a1=f1(x1,y1,z1)
		b1=f2(x1,y1,z1)
		c1=f3(x1,y1,z1)
!		-------------------------------------------
		x11=x1+h2*a1
		y11=y1+h2*b1
		z11=z1+h2*c1
!		-------------------------------------------
		a2=f1(x11,y11,z11)
		b2=f2(x11,y11,z11)
		c2=f3(x11,y11,z11)
!		-------------------------------------------
		x12=x1+h2*a2
		y12=y1+h2*b2
		z12=z1+h2*c2
!		-------------------------------------------
		a3=f1(x12,y12,z12)
		b3=f2(x12,y12,z12)
		c3=f3(x12,y12,z12)
!		-------------------------------------------
		x13=x1+h2*a3
		y13=y1+h2*b3
		z13=z1+h2*c3
!		-------------------------------------------
		a4=f1(x13,y13,z13)
		b4=f2(x13,y13,z13)
		c4=f3(x13,y13,z13)

		x2=x1+h6*(a1+2.d0*a2+2.d0*a3+a4)
		y2=y1+h6*(b1+2.d0*b2+2.d0*b3+b4)
		z2=z1+h6*(c1+2.d0*c2+2.d0*c3+c4)
		t2=t1+h
!		theta=xi(t1+h)
		write(1,*)x2,y2,z2
		x1=x2
		y1=y2
		z1=z2
		t1=t2
	enddo
	
	end

	function f1(x,y,z)
	implicit double precision(a-h,o-z)
	sigma=10.d0
	f1=sigma*(y-x)
	return
	end

	function f2(x,y,z)
	implicit double precision(a-h,o-z)
!	
	rho=28.d0
	f2=x*(rho-z)-y
	return
	end
	
	function f3(x,y,z)
	implicit double precision(a-h,o-z)
	beta=8.d0/3.d0
	f3=x*y-beta*z
	return
	end
