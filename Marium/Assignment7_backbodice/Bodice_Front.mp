%*************************************************************
%Drawing pattern of Front Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-front-bodice-sloper-update
%*************************************************************
input sarith;

ease := 2*inch; %ease is taken of 2 inches
t := 1; % scaling factor of the square
inch := 2.54*t; % since 1 inch = 2.54; This provides the space to stich
%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
	full_length     := 49.5*t;
	cf_length       := 40.5*t;
	shoulder_slope  := 48.5*t;
	shoulder_length := 9*t;
	across_shoulder := 34/2*t;
	bust_depth      := 27*t;
	bust_span       := 24/2*t;
	bust_arc        := 18*t + bust_span;
	armhole_depth   := 16.5*t;
	side_seam_length:= 23*t;
	waist_arc       := 27*t;
	dart_pl         := bust_span - 3/4*inch;
%========================================

def FrontBodice = 
%%%% STEP 1 %%%%
	f1 := (0,full_length); 									% A
	f2 := (0,0); 											% B
	f3 := (-across_shoulder,ypart f1); 						% C
	f4 := (xpart f3,ypart f1 - 10*inch); 					% guideline for C
	f5 := (xpart f2, cf_length - (3/8 * inch));				% D
	% Intersection for BE
	E := ypart f2 + sqrt((shoulder_slope ** 2) - ((xpart f2 + xpart f4)**2));
	f6 := (xpart f4,E); 									% E
	F := xpart f4 + sqrt((shoulder_length**2) -((ypart f6 - ypart f1)));
	f7 := (F,ypart f1); 									% F
	%perpendicular from FE to FG
	z1 = f7;
	z2 = f6;
	y0 = ypart f5;
	(z1-z0) dotprod (z2-z1) = 0;
	f8 := z0;												% G
	f9 := ((xpart f8 + (1/(2*sqrt(2)))),(ypart f8 + (1/(2*sqrt(2))))); 	% H
	f10 := (xpart f3,ypart f6 - armhole_depth); 			% I
	f11 := (xpart f10,ypart f10 - (2*inch)); 				% J
	f12 := (xpart f10,ypart f10 - (5 * inch));				% side seam line guideline
	f13 := 1/2[f6,f10];										% K
	f14 := (xpart f2,ypart f13); 							% L
	f15 := (xpart f13 + (0.5*inch),ypart f13); 				% M
	path BE;
	BE := f2--f6;
	f16 := f6 - bust_depth* unitvector(direction 0 of BE);    % N
	f17 := f16 + whatever*right = whatever[f1,f2];            % O
	f18 := (xpart f17 - bust_span,ypart f17); 				  %P
	pair J_guideline,I_guideline;
	J_guideline := (-infinity,ypart f11);
	I_guideline := (-infinity,ypart f10);
	
	%measure OP
	path OP,intsec;
	OP := f17--f16--f18; 									% ONP
	OP_length := arclength(OP);
	PJ := bust_arc - OP_length;
	intsec := fullcircle scaled (2*(PJ)) shifted f18;
	f19 := (subpath(2,5) of intsec) intersectionpoint (f11--J_guideline);  % Q
	intsec := fullcircle scaled (2*(PJ+(0.5 *inch))) shifted f18;
	f20 := (subpath(2,5) of intsec) intersectionpoint (f10--I_guideline);  % R
	f21 := f20 - side_seam_length * unitvector(direction 0 of (f19--f20)); % S
	f22 := f20 - 0.5*inch * unitvector(direction 0 of (f19--f20));         % T
	f23 := (-dart_pl,ypart f2); 										   % U
	f24 := f23 - 3/16*inch * unitvector(direction 0 of (f18--f23));        % V
	W := waist_arc - arclength(f23--f2);
	f25 := f21 + W * unitvector(direction 0 of(f21--f24));				   % W
	PV := arclength(f18--f24);
	f26 := f18 + PV * unitvector(direction 0 of (f18--f25)); 			   % X
	
	
	
	%draw f10 withpen pencircle scaled 1mm;
	%draw f11 withpen pencircle scaled 1mm;
	%draw f20 withpen pencircle scaled 1mm;
	%draw f19 withpen pencircle scaled 1mm;
	%draw f26 withpen pencircle scaled 1mm withcolor red;
	


enddef;


beginfig(1)
	pair f[];
	FrontBodice;
	path guide,front,BE,KL,OP,PQ,ONP;
	guide := f2--f1--f3--f4--f10--f12;
	PQ := f18..f19;
	ONP := f18..f20;
	BE := f2--f6;
	KL := f13--f14;
	OP := f18--f17;
	front := f2--f5{curl 0}..f9..f7{curl 0}--f6..f15..f22--f21--f26--f18--f24--f2;
	draw guide withcolor 0.5(black+white);
	draw BE withcolor red;
	draw KL withcolor red;
	draw OP withcolor blue;
	draw PQ withcolor .5(black+white);
	draw ONP withcolor .5(black+white);
	draw front;
	draw f5--f8 withcolor blue;



	endfig;
end;