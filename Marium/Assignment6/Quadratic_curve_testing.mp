
%=============This is for entering the values of coordinates of operating points=======
	pair Q[];
	Q0 := (40.0,50.0); 	%A
	Q1 := (10.0,0.0);	%a
	Q2 := (0.0,0.0);	%b
	Q3 := (30.0,0.0);	%B

%===============Function for computing terms of the Quadratic Curve=======	
def ZEquation(expr t) =
	pair S,T,U,V,W;
	S := ((1-t)* (1-t) * (1-t)) * Q0;
	T := ((1-t)*(1-t))* 3 * t * Q1;
	U := 3 * t * t * (1-t) * Q2;
	V := t * t * t * Q3;
	W := S+T+U+V;
	z := W;
	
	p[$] := z;
	
	%draw z withcolor red;
	%z2 := (t,p2);
	%z3 := (t,p3);
	%z4 := (t,p4);
	%z5 := (t,p5);
	$ := incr($);
enddef;

%===============Function for computing terms of the Derivative of Quadratic Curve=======
def Derivative(expr t) = 
	pair R,A,B,C,D;
	A := -3 * ((1-t)*(1-t)) * Q0;
	B := 3 * (((1-t)*(1-t)*(1-t)) - (2 * t * (1-t))) * Q1;
	C := 3 * ((2 * t * (1-t)) - (t*t)) * Q2;
	D := 3 * t * t * Q3;
	R := A + B + C + D;
	dz[$] := R;
	$ := incr($);
enddef;

%==================Plotting of Quadratic curve============================
beginfig(1)
	% equation of z
	let z = undefined;
	pair z;
	
	$ := 1;
	pair p[];
	
	for t =0.0 step 0.05 until 1.0:
		ZEquation(t);
	endfor
	
	path quad;
	
	quad := p[1]..p[2]..p[3]..p[4]..p[5]..p[6]..p[7]..p[8]..p[9]..p[10]..p[11]..p[12]..p[13]..p[14]..p[15]..p[16]..p[17]..p[18]..p[19]..p[20];
	
	draw quad withcolor red;
	
endfig;

%==================Derivative of Quadratic curve==================================
beginfig(2)
	pair dz[];
	$ := 1;
	
	for t =0.0 step 0.05 until 1.0:
		Derivative(t);
	endfor
	
	path der;
	
	der := dz[1]..dz[2]..dz[3]..dz[4]..dz[5]..dz[6]..dz[7]..dz[8]..dz[9]..dz[10]..dz[11]..dz[12]..dz[13]..dz[14]..dz[15]..dz[16]..dz[17]..dz[18]..dz[19]..dz[20];
	draw der withcolor blue;
	
endfig;
end;