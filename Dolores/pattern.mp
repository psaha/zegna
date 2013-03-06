%% Coat pattern

% Parameters
t = 30;   % Length of collar opening
a1 = 40;  % Angle determining slope of collar
l1 = 10;  % Length determining hight of collar
a2 = 30;  % Angle determining slope of shoulder part
l2 = 20;  % Length determining hight of shoulder part
a3 = 60;  % Angle determining width of coat (nicest between 45 and 70 degrees)
l3 = 100; % Length determining hight of coat
a4 = 150; % Angle determining roundness of bottom part (nicest between 130 and 180 degrees)

% Pairs
pair p[];
p5 = -p4 = (t/2,0);                          % making use of symmetry
p3 = p4 - l1*dir a1;
xpart p6 = -xpart p3; ypart p6 = ypart p3;   % making use of symmetry
p2 = p3 - l2*dir a2;
xpart p7 = -xpart p2; ypart p7 = ypart p2;   % making use of symmetry
p1 = p2 - l3*dir a3;
xpart p8 = -xpart p1; ypart p8 = ypart p1;   % making use of symmetry


% Figure: Varying the bottom part
beginfig(1);
	for d=130 step 10 until 180:
		draw p1--p2{dir a3}..{right}p3--p4--p5--p6{right}..p7{dir -a3}--p8..p1{dir d};
	endfor;
	for i=1 upto 8:                           % draw points and labels
		draw p[i] withpen pencircle scaled 4;
		if ((i>=3) and (i<=6)):
			label.top(decimal i, p[i]);
		elseif ((i=1) or (i=2)):
			label.lft(decimal i, p[i]);
		elseif ((i=7) or (i=8)):
			label.rt(decimal i, p[i]);
		fi
	endfor;
endfig;


% Figure: Varying the angle determining the width of the coat
beginfig(2);
	for d=40 step 10 until 70:
		pair p[];
		p5 = -p4 = (t/2,0);                          % making use of symmetry
		p3 = p4 - l1*dir a1;
		xpart p6 = -xpart p3; ypart p6 = ypart p3;   % making use of symmetry
		p2 = p3 - l2*dir a2;
		xpart p7 = -xpart p2; ypart p7 = ypart p2;   % making use of symmetry
		p1 = p2 - l3*dir d;
		xpart p8 = -xpart p1; ypart p8 = ypart p1;   % making use of symmetry
		
		draw p1--p2{dir d}..{right}p3--p4--p5--p6{right}..p7{dir -d}--p8..p1{dir a4};
	endfor;
	for i=1 upto 8:                           % draw points and labels
		draw p[i] withpen pencircle scaled 4;
		if ((i>=3) and (i<=6)):
			label.top(decimal i, p[i]);
		elseif ((i=1) or (i=2)):
			label.lft(decimal i, p[i]);
		elseif ((i=7) or (i=8)):
			label.rt(decimal i, p[i]);
		fi
	endfor;
endfig;