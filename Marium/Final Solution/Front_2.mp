%*************************************************************
%Drawing pattern of Front Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-front-bodice-sloper-update
%*************************************************************
input sarith;

t := 1; % scaling factor of the square
inch := 2.54*t*cm; % since 1 inch = 2.54cm; This provides the space to stich
ease := 2*inch; %ease is taken of 2 inches
% definition pi
pi=3.141592653689793238462643;
%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
	%full_length     := 49.5*cm*t;
	%cf_length       := 40.5*cm*t;
	%shoulder_slope  := 48.5*cm*t;
	%shoulder_length := 9*cm*t;
	%across_shoulder := 34/2*cm*t;
	%bust_depth      := 27*cm*t;
	%bust_span       := 24/2*cm*t;
	%bust_arc        := 18*cm*t + bust_span;
	%armhole_depth   := 16.5*cm*t;
	%side_seam_length:= 23*cm*t;
	%waist_arc       := 27*cm*t;
	%dart_pl         := bust_span - 3/4*inch;
	
	full_length     := 47*cm*t;
	cf_length       := 39*cm*t;
	shoulder_slope  := 45*cm*t;
	shoulder_length := 7*cm*t;
	across_shoulder := 28/2*cm*t;
	bust_depth      := 22*cm*t;
	bust_span       := 21/2*cm*t;
	bust_arc        := 16.5*cm*t; %+ bust_span;
	armhole_depth   := 14*cm*t + (0.5*inch);
	side_seam_length:= 27*cm*t;
	waist_arc       := 22*cm*t;
	dart_pl         := bust_span - 3/4*inch;

%========================================
def intersectioncurve(expr px, py, r, b, e) = 
	subpath ((b*(4.0/pi)),(e*(4.0/pi))) of fullcircle xscaled (2*r) yscaled (2*r) shifted (px,py) enddef;

def cos(expr x) = cosd(x*180/pi) enddef;

def sin(expr x) = sind(x*180/pi) enddef;

def FrontBodice = 
%%%% STEP 1 %%%%
	f1 := (0,full_length); 									% A
	f2 := (0,0); 											% B
	f3 := (-across_shoulder,full_length); 					% C
	f4 := (xpart f3,ypart f1 - 10*inch); 					% guideline for C
	f5 := (xpart f2, cf_length - (3/8 * inch));				% D
	% Intersection for BE
	path E,F;
	E := intersectioncurve(xpart f2,ypart f2,shoulder_slope,0 * cm,(5*pi/18)*cm);
	f6 := E intersectionpoint (f3--f4); 					% E
	
	F := intersectioncurve(xpart f6,ypart f6,shoulder_length,0*cm,(5*pi/18)*cm);
	f7 := F intersectionpoint (f1--f3);						% F
	
	%F := xpart f4 + sqrt((shoulder_length**2) -((ypart f6 - ypart f1)));
	%f7 := (F,ypart f1); 									% F

	%perpendicular from FE to FG
	z1 = f7/2;
	z2 = f6/2;
	y0 = ypart f5/2;
	(z1-z0) dotprod (z2-z1) = 0;
	f8 := z0 * 2;											% G
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
	path OP,intsec,ON;
	%OP := f17--f16--f18; 									% ONP
	ON := f17--f16; 									% Bust span
	OP_length := arclength(ON);
	PJ := bust_arc;
	%PJ := bust_arc - bust_span;
	intsec := fullcircle scaled (2*(PJ)) shifted f18;
	f19 := (subpath(0,8) of intsec) intersectionpoint (f11--J_guideline);  % Q
	intsec := fullcircle scaled (2*(PJ+(0.5 *inch))) shifted f18;
	f20 := (subpath(2,8) of intsec) intersectionpoint (f10--I_guideline);  % R
	f21 := (f20 + side_seam_length * unitvector(direction 0 of (f20--f19))); % S
	f22 := (f20 + 0.5*inch * unitvector(direction 0 of (f20--f19)));         % T
	
	%f21 := (xpart f20 + xpart f21,ypart f21);
	%f22 := (xpart f20 + xpart f22,ypart f22);
	
	f23 := (-dart_pl,ypart f2); 										   % U
	f24 := f23 - 3/16*inch * unitvector(direction 0 of (f18--f23));        % V
	W := waist_arc - arclength(f23--f2);
%	W := waist_arc - dart_pl;
	f25 := f21 + W * unitvector(direction 0 of(f21--f24));				   % W
	PV := arclength(f18--f24);
	f26 := f18 + PV * unitvector(direction 0 of (f18--f25)); 			   % X
	%WX := ypart f26 + ypart f25;
	%f26 := (xpart f26,WX - ypart f26);
	
	
	
	%draw f20 withpen pencircle scaled 1cm;
	%draw f19 withpen pencircle scaled 1cm;
	%draw f10 withpen pencircle scaled 1cm withcolor red;
	%draw f11 withpen pencircle scaled 1cm withcolor blue;
	%draw f22 withpen pencircle scaled 1mm withcolor red;
	


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
	front := f2--f5{curl 0}..f9..f7{curl 0}--f6..f15..f22--f21..f26--f25--f18--f24--f2;
	draw guide withcolor 0.5(black+white);
	draw BE withcolor red;
	draw KL withcolor red;
	draw OP withcolor blue;
	draw PQ withcolor .5(black+white);
	draw ONP withcolor .5(black+white);
	draw front;
	draw f5--f8 withcolor blue;
	%%% Matching front armhole with the sleeve
	message "================================";
	message "Arm hole for front";
	show arclength(f6..f15..f22);
	message "================================";
	



	endfig;
end;