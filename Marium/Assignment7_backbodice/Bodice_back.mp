%*************************************************************
%Drawing pattern of Back Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update
%*************************************************************


ease := 2*inch; %ease is taken of 2 inches
t := 5; %scaling factor of the square
inch := 2.54*t; % since 1 inch = 2.54; This provides the space to stich
%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
	full_length     := 49.5*t;
	cb_length       := 40.5*t;
	shoulder_slope  := 9*t;
	shoulder_length := 9*t;
	across_shoulder := 34/2*t;
	back_arc 		:= 30.8 * t	;
	across_back		:=	30.9 * t;
	neck_width		:= 30.385/4 * t;
	side_seam_length := 23*t;
	bust_span       := 24/2*t;
	waist_arc       := 27*t;
	dart_pl         := bust_span - 3/4*inch;
%========================================
def BackBodice =
    %STEP 1	    
	% Starting from the length
	p1 := (0,full_length); 						% A
	
	p2 := (across_shoulder,full_length);		% C

	p3 := (0*t,full_length - (4*inch));			% D
	
	p4 := (0*t,0*t);								% B
	
	p5 := (dart_pl , -5*t);					% G
	
	p6 := (xpart p5 + (1.5 * inch),-5*t);			% H
	
	i := (xpart p6 + xpart p5)/(2*t);
	
	p7 := (0,side_seam_length);					% J
	
	p8 := (back_arc + (1/8 * inch),ypart p7);   % K (NOTE: 1/8 is for ease)
	
	pair L;	
	L := (i,ypart p7);
	p9 := (xpart p5+i,ypart L - ((3/4) * inch)); % M
	
	p10 := (waist_arc,0); % E
	
	p11 := (xpart p10,ypart p2 - (7 * inch)); % N
	%STEP 2
	%p12 := (); % 

enddef;

%===============================================================================

beginfig(1)

	pair p[],s[];
	BackBodice;
	%pickup pencircle scaled 0.7bp;
	path back;
	back := p4--p5--p9--p6--p10--p8..p2--p1--p4;
	path JLK;
	JLK := p7--p8;
	draw back;
	draw JLK withcolor blue;


	endfig;
end;
		
	


