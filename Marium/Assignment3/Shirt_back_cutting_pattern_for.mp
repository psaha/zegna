%*************************************************************
%Drawing the back part of the shirt
%*************************************************************

inc = 2.54; % since 1 inch = 2.54;

% Entering the measurements
%========================================
Neck = 30.385;
Waist = 69.29;
Chest = 86.36;
Hip = 101.6;
Length = 101.6;
Shoulder = 8.382; % This is of 1 side taking from the neck to the end of shoulder
ArmHole = 17.78;
%========================================
%scaling to quarter portion
n := Neck/4;
w := Waist/4;
c := Chest/4;
h := Hip/4;
a := 45; % angle of cutting from neck to shoulders

beginfig(1)
	pair p[];
	
	% Starting from the length
		
	p1 =(0 ,0);
	%from length to waist
	p2 = (h,0);
	p3 = (h,Length - 3.81 - 5.08); % 1.5 inch for the back neck
	p4 = (n,Length - 5.08+2.54);
	p5 = (-Shoulder,Length - 7.62);
	p6 = (-Shoulder,38.1 + 25.4 + ((2/3)* ArmHole));
	p7 = (-c,25.4 + 38.1);
	p8 = (2.54,17.78); %1 inch inside to make it a bit curvy
		
	path back;
	back = p1--p2..p3--p4{dir a}--p5..p6..p7{curl 1}..p8 rotated 2..p1;
	draw back;
	
	
	
	%draw p1 withpen pencircle scaled 4bp;
	%draw p2 withpen pencircle scaled 4bp;
	%draw p3 withpen pencircle scaled 4bp;
	%draw p4 withpen pencircle scaled 4bp;
	%draw p5 withpen pencircle scaled 4bp;
	%draw p6 withpen pencircle scaled 4bp;
	%draw p7 withpen pencircle scaled 4bp;
	%draw p8 withpen pencircle scaled 4bp;
	
endfig;
end;
		
	


