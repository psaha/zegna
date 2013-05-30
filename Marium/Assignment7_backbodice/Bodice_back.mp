%*************************************************************
%Drawing pattern of Back Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update
%*************************************************************
input sarith;

t := 1; % scaling factor of the square
inch := 2.54*t; % since 1 inch = 2.54; This provides the space to stich
ease := 2*inch; %ease is taken of 2 inches
%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
	full_length     := 46*t;
	cb_length       := 44*t;
	shoulder_slope  := 46.5*t;
	shoulder_length := 9*t;
	across_shoulder := 34/2*t;
	back_arc 		:= 23 * t;
	across_back		:= 16.6 * t;
	back_neck		:= 10.5 * t;
	side_seam_length := 23*t;
	bust_span       := (24/2)*t;
	waist_arc       := 27*t;
	dart_pl         := bust_span - 3/4*inch;
%========================================
def BackBodice =
    %%%%STEP 2%%%%
	
	p1 := (0,full_length); 						% A
	p4 := (0,0);								% B
	p2 := (across_shoulder,full_length);		% C
	p3 := (0,cb_length);						% D
	p10 := (waist_arc + (1.5*inch) ,ypart p4); 	% E(1.5" for dart in xpart)
	
	p5 := (dart_pl ,-1/8*inch);					% G
	p6 := (xpart p5 + (1.5 * inch),-1/8*inch);	% H
	
	p25 := 1/2[p5,p6];							% I
	p7 := (0,side_seam_length);					% J
	p8 := (back_arc + (1/8 * inch),ypart p7);   % K (NOTE: 1/8 is for ease)
	
	p26 := (xpart p25,ypart p7);				% L
	p9 := (xpart p26,ypart p26 - ((3/4) * inch)); 	% M
		
	N := ypart p4 + sqrt((shoulder_slope ** 2) - ((xpart p2 - xpart p4)**2));
	p11 := (xpart p2,N);						% N
	%p11 := (xpart p10,ypart p2);    			% N (with respect to shoulder slope)
	
	%%%%STEP 3%%%%
	
	%determining O
	
	p12 := (back_neck,ypart p1);  				% O
	n := 0;
	ON := sqrt((((xpart p11 - xpart p12))**2) + (((ypart p11 - ypart p12))**2));
	
	if ON = shoulder_length + (0.5 * inch):
		message "OK";
	else:
	% point of intersection for B and N
		forever:
			%adjust N
			ON := round(sqrt((((xpart p11 - xpart p12))**2) + (((ypart p11 - ypart p12))**2)));
			%show ON;
			if n mod 2=0:
				p11 := (xpart p2,N + (n * inch));    % N
			else:
				p11 := (xpart p2,N - (n * inch));
			fi;
			n := n+0.0001;
	
			exitif ON = round(shoulder_length  + (0.5 * inch));
		endfor;
	fi;
	
	extra := (shoulder_length + (0.5 *inch)) - ON;
	p11 := (xpart p11,ypart p11 + extra);				%N(modified)
	
	% Now calculate ON again after adjustments
	ON_new := ON + extra;

	%perpendicular of ON and OP
	z1 = p12;
	z2 = p11;
	y0 = ypart p3;
	(z1-z0) dotprod (z2-z1) = 0;
	p13 := z0;												% P
	p14 := ((xpart p13 - (1/(2*sqrt(2)))),(ypart p3 + (1/(2*sqrt(2))))); 	% Q
	p15 := 1/2[p12,p11]; 									% R
	
	pair temp;
	path RM;
	RM := p9--p15;
	p16 := p15 - 3.0*inch*unitvector(direction 0 of RM); 	% S
	temp := p15 - 1/4*inch*unitvector(direction 0 of RM); 	% T*
	p17 := (xpart temp,ypart temp +(1/8*inch));				% T
	temp := p15 + 1/4*inch*unitvector(direction 0 of RM); 	% U*
	p18 := (xpart temp,ypart temp + (1/4*inch));				% U
	
	if arclength(p17--p16) = arclength(p16--p18):
		message "equal";
	fi;

%%%%STEP 4 %%%%
	
	p19 := (xpart p8,ypart p8 - (0.5 *inch)); 				% V
	p20 := 1/2[p3,p7];										% DJ
	p21 := (0,ypart p20 - (3/4*inch)); 						% W (subtract just because of downward mark)
	p22 := (across_back + (3/16 * inch),ypart p21); 		% X
	p23 := (xpart p2,ypart p2 - (7*inch)); %guideline for C
	p24 := (xpart p3 + (4*inch), ypart p3); %guideline for D
	
	%draw p21 withpen pencircle scaled 1mm;
enddef;

%===============================================================================

beginfig(1)

	pair p[];
	BackBodice;
	%pickup pencircle scaled 0.7bp;
	path back;
	back := p4--p5--p9--p6--p10--p19..p22..p11--p18--p16--p17--p12..p14..p3--p4;
	path JLK,BN,guidelineC,guidelineD;
	JLK := p7--p8;
	BN := p4--p11; 
	guidelineC := p11--p2--p1--p3;
	guidelineD := p24--p3;
	
	draw back;
	draw JLK withcolor blue;
	draw BN withcolor red;
	draw guidelineC withcolor .5(black+white);
	%draw guidelineD withcolor blue;
	
	%%% Matching front armhole with the sleeve
	message "================================";
	message "Arm hole for back";
	show arclength(p11..p22..p19);
	message "================================";
	

	endfig;
end;
		
	


