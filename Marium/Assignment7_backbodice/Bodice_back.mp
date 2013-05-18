%*************************************************************
%Drawing pattern of Back Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update
%*************************************************************
input sarith;

ease := 2*inch; %ease is taken of 2 inches
t := 1; % scaling factor of the square
inch := 2.54*t; % since 1 inch = 2.54; This provides the space to stich
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
	back_neck		:=  10.5 * t;
	side_seam_length := 23*t;
	bust_span       := (24/2)*t;
	waist_arc       := 27*t;
	dart_pl         := bust_span - 3/4*inch;
%========================================
def BackBodice =
    %%%%STEP 2%%%%
	
	p1 := (0,full_length); 						% A
	p2 := (across_shoulder,full_length);		% C
	p3 := (0*t,cb_length);						% D
	p4 := (0*t,0*t);							% B
	p5 := (dart_pl , -5*t);						% G
	p6 := (xpart p5 + (1.5 * inch),-5*t);		% H
	pair i;
	i := 1/2[p5,p6];
	p7 := (0,side_seam_length);					% J
	p8 := (back_arc + (1/8 * inch),ypart p7);   % K (NOTE: 1/8 is for ease)
	
	pair L;	
	L := (xpart i,side_seam_length);
	p9 := (xpart i,ypart L - ((3/4) * inch)); 	% M
	p10 := (waist_arc + (1.5*inch),0 * t); 		% E
	
	N := ypart p4 + sqrt((shoulder_slope ** 2) - ((xpart p2 - xpart p4)**2));
	p11 := (xpart p2,N);						%N
	%p11 := (xpart p10,ypart p2);    				% N (with respect to shoulder slope)
	
	%%%%STEP 3%%%%
	
	%determining O
	
	p12 := (back_neck,ypart p1);  %O
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
	
			exitif ON =  round(shoulder_length  + (0.5 * inch));
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
	p13 := z0;	%P
	p14 := ((xpart p13 - (1/(2*sqrt(2)))),(ypart p3 + (1/(2*sqrt(2))))); 	% Q
	p15 := 1/2[p12,p11]; 									%R
	
	path LM;
	LM := p9--L;
	p16 := p15 - 3.0*inch*unitvector(direction 0 of LM); 	%S
	p17 := p15 - 1/4*inch*unitvector(direction 0 of LM); 	%T
	p18 := p15 + 1/4*inch*unitvector(direction 0 of LM); 	%U

%%%%STEP 4 %%%%
	
	p19 := (xpart p8,ypart p8 - (0.5 *inch)); 				% V
	p20 := 1/2[p3,p7];										% DJ
	p21 := (0,ypart p20 - (3/4*inch)); 						% W (subtract just because of downward mark)
	p22 := (across_back + (3/16 * inch),ypart p21); 		% X
	%draw p22 withpen pencircle scaled 1mm;
enddef;

%===============================================================================

beginfig(1)

	pair p[],s[];
	BackBodice;
	%pickup pencircle scaled 0.7bp;
	path back;
	back := p4--p5--p9--p6--p10--p19..p22..p11--p18--p16--p17--p12..p14..p3--p4;
	path JLK,BN;
	JLK := p7--p8;
	BN := p4--p11; 
	draw back;
	draw JLK withcolor blue;
	draw BN withcolor red;
	

	endfig;
end;
		
	


