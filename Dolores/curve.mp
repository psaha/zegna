% Figure 1: Draw a simple line
beginfig(1);
	draw (20,20)--(0,0);
	draw (20,20) withpen pencircle scaled 4;
	draw (0,0) withpen pencircle scaled 4;
endfig;

% Figure 2: Connecting 5 points with straight lines
beginfig(2);
	z0 = (0,0);
	z1 = (60,40);
	z2 = (40,90);
	z3 = (10,70);
	z4 = (30,50);
	draw z0--z1--z2--z3--z4;
	for i=0 upto 4:
		draw z[i] withpen pencircle scaled 4;  % draw points
	endfor;
endfig;

% Figure 3: Draw a smooth curve through 5 points
beginfig(3);
	z0 = (0,0);
	z1 = (60,40);
	z2 = (40,90);
	z3 = (10,70);
	z4 = (30,50);
	draw z0..z1..z2..z3..z4;
	for i=0 upto 4:
		draw z[i] withpen pencircle scaled 4;
	endfor;
endfig;

% Figure 4: Draw a smooth closed curve through 5 points
beginfig(4);
	z0 = (0,0);
	z1 = (60,40);
	z2 = (40,90);
	z3 = (10,70);
	z4 = (30,50);
	draw z0..z1..z2..z3..z4..cycle;
	for i=0 upto 4:
		draw z[i] withpen pencircle scaled 4;
	endfor;
endfig;

% Figure 5: Draw a smooth through 5 points, with horizontal and vertical extrema
beginfig(5);
	z0 = (0,0);
	z1 = (60,40);
	z2 = (40,90);
	z3 = (10,70);
	z4 = (30,50);
	draw z0..z1{up}..z2{left}..z3..z4;
	for i=0 upto 4:
		draw z[i] withpen pencircle scaled 4;   % draw points
		if i=1:                                 % label points
			label.rt(decimal i, z[i]); 
		elseif i=2:
			label.top(decimal i, z[i]);
		fi
	endfor;
endfig;

% Figure 6: Draw a smooth through 5 points, with horizontal and vertical extrema
beginfig(6);
	z0 = (0,0);
	z1 = (60,40);
	z2 = (40,90);
	z3 = (10,70);
	z4 = (30,50);
	draw z0..z1{z2-z0}..z2..z3..z4;
	for i=0 upto 4:
		draw z[i] withpen pencircle scaled 4;
		if i=0:
			label.top(decimal i, z[i]);
		elseif i=1:
			label.rt(decimal i, z[i]);
		elseif i=2:
			label.top(decimal i, z[i]);
		fi
	endfor;
endfig;

% Figure 7: Curve family
beginfig(7);
	for d=0 step 10 until 90:
		z0 = (0,0);
		z1 = (6cm,0);
		draw z0{dir 60}..{dir -d}z1;
		draw z0 withpen pencircle scaled 4;
		draw z1 withpen pencircle scaled 4;
		label.lft(decimal 0, z0);
		label.rt(decimal 1, z1);
	endfor;
endfig;

% Figure 8: Curve family
beginfig(8);
	for d=0 step -10 until -90:
		z0 = (0,0);
		z1 = (6cm,0);
		draw z0{dir 60}..{dir -d}z1;
		draw z0 withpen pencircle scaled 4;
		draw z1 withpen pencircle scaled 4;
		label.lft(decimal 0, z0);
		label.rt(decimal 1, z1);
	endfor;
endfig;

end