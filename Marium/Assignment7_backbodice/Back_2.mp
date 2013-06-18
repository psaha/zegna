%*************************************************************
%Drawing pattern of Back Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update
%*************************************************************
input sarith;

t := 1/2; % scaling factor of the square
inch := 2.54*t*cm; % since 1 inch = 2.54cm; This provides the space to stich
centimeter := 1cm;
%ease := 2*inch; %ease is taken of 2 inches
% definition pi
pi=3.141592653689793238462643;

%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
	full_length     := 46*cm*t;
	cb_length       := 44*cm*t;
	shoulder_slope  := 46.5*cm*t;
	shoulder_length := 9*cm*t;
	across_shoulder := 34/2*cm*t;
	back_arc 		:= 23 * cm * t;
	across_back		:= 16.6 * cm * t;
	back_neck		:= 10.5 * cm * t;
	side_seam_length := 23* cm * t;
	bust_span       := (24/2)* cm * t;
	waist_arc       := 27*cm *t;
	dart_pl         := bust_span - 3/4*inch;
%========================================

def intersectioncurve(expr px, py, r, b, e) = 
	subpath ((b*(4.0/pi)),(e*(4.0/pi))) of fullcircle xscaled (2*r) yscaled (2*r) shifted (px,py) enddef;

def cos(expr x) = cosd(x*180/pi) enddef;

def sin(expr x) = sind(x*180/pi) enddef;

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
	
	path N;
	N := intersectioncurve(xpart p4,ypart p4,shoulder_slope,0cm,(5*pi/18)*cm);
	
	p11 := N intersectionpoint (p10--p2); 	% N
	
	%p11 := (xpart p10,ypart p2);    			% N (with respect to shoulder slope)
	
	%%%%STEP 3%%%%
	
	%determining O
	
	p12 := (back_neck,ypart p1);  				% O
	n := 0;
	ON := arclength(p11--p12);
	draw p11 withpen pencircle scaled 1mm;
	
	
	p11 := (xpart p2,ypart p11);
	message "before";
	show p11;
	show shoulder_length + (0.5 * inch);
	if ON = shoulder_length + (0.5 * inch):
		message "OK";
	else:
	% point of intersection for B and N
		forever:
			%adjust N
			ON := round(arclength(p11--p12));
			
			%show ON;
			if n mod 2=0:
				p11 := (xpart p2,ypart p11 + (n * centimeter));    % N
			else:
				p11 := (xpart p2,ypart p11 - (n * centimeter));
				show n;
				show p11;
				
			fi;
			n := n+0.0001;
	
			exitif ON = round(shoulder_length  + (0.5 * inch));
		endfor;
	fi;
	
	extra := (shoulder_length + (0.5 *inch)) - ON;
	p11 := (xpart p11,ypart p11 + extra);				%N(modified)
	message "after";
	show p11;
	show extra;
	
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
	path RM,ON,TS,US;
	RM := p9--p15;
	
	p16 := p15 - 3.0*inch*unitvector(direction 0 of RM); 	% S
	ON := p12--p11;
	temp := p15 - 1/4*inch*unitvector(direction 0 of ON); 	% T*
	p17 := (xpart temp,ypart temp +(1/8*inch));				% T
	temp := p15 + 1/4*inch*unitvector(direction 0 of ON); 	% U*
	p18 := (xpart temp,ypart temp + (1/4*inch));			% U
	
	if arclength(p17--p16) = arclength(p16--p18):
		message "equal";
	else:
		path parity;
		save value;

		
	%%%%%figureout the smaller one
		if arclength(p17--p16)<arclength(p16--p18):
			%increase TS
			TS := p17--p16;
			parity := TS;
			value := 1;
			
		else:
			%increase US
			US := p18--p16;
			parity := US;
			value := 0;
			
			
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		forever:
			%adjust length of US and TS such that their angle should be 180
			len := arclength(parity);
			if value = 1:
				%show ON;
				if n mod 2=0:
					p18 := (xpart p18 + (n * centimeter),ypart p18 + (n * centimeter));    % either T or U
				else:
					p18 := (xpart p18 -(n * centimeter),ypart p18 - (n * centimeter));
				fi;
			else:
				if n mod 2=0:
					p17 := (xpart p17 + (n * centimeter),ypart p17 + (n * centimeter));    % either T or U
				else:
					p17 := (xpart p17 -(n * centimeter),ypart p17 - (n * centimeter));
				fi;
			n := n+0.0001;
			fi;
	
			exitif (round(arclength(p17--p16)) = round(arclength(p16--p18)));
		endfor;
	fi;
	
	extra := arclength(parity) - len;
	if value = 0:
		p18 := (xpart p18 + extra,ypart p18 + extra);    % U
	else:
		p17 := (xpart p17 + extra,ypart p17 + extra);    % T
	fi;
	
%%%%STEP 4 %%%%
	
	p19 := (xpart p8,ypart p8 - (0.5 *inch)); 				% V
	p20 := 1/2[p3,p7];										% DJ
	p21 := (0,ypart p20 - (3/4*inch)); 						% W (subtract just because of downward mark)
	p22 := (across_back + (3/16 * inch),ypart p21); 		% X
	%p23 := (xpart p2,ypart p2 - (7*inch)); %guideline for C
	%p24 := (xpart p3 + (4*inch), ypart p3); %guideline for D
	
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
	%guidelineD := p24--p3;
	
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
		
	


