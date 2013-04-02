%*************************************************************
%Drawing the back part and the sleeve of the shirt with sewing guide
% I have merged my code with the dolores code
%*************************************************************

inch := 2.54; % since 1 inch = 2.54; This provides the space to stich

%=====================================================================
%This is for the Sleeve part
%*********************************
def ParamforSleeve(expr u) = 
	AB := c - 1.5*inch;
	DF := lArm + 1*inch/4;
	
	pair q[];
	q1 = (0,AB/2);                        % A
	q2 = (-AB,0);                         % E mirrored
	q3 = (AB,0);                          % E
	q4 = (-DF,-(sleeve_length-AB/2));     % F mirrored
	q5 = (DF,-(sleeve_length-AB/2));      % F
	q6 := 1/4[q1,q3];                     % c
	q7 := 1/2[q1,q3];                     % b
	q8 := 3/4[q1,q3];                     % a

	alpha := -angle(q3-q1);               % angle between AB and AE (alpha>0)

	q9 := q6 + inch/2*dir(90-alpha);      % g
	q10 := q7 + inch/4*dir(90-alpha);     % f
	q11 := q8 + inch/2*dir(90-alpha+180); % d
	q12 := q8 + inch/4*dir(90-alpha+180); % e
	q13 := (-xpart q9,ypart q9);          % g mirrored
	q14 := (-xpart q7,ypart q7);          % b mirrored
	q15 := (-xpart q11,ypart q11);        % d mirrored
enddef;

%===============================================================================

%This is for the back part
%*****************************
def ParamforBack(expr t) =
	inc_neg := -1 * inch;
	inc_pos := inch;
    
	% Starting from the length
	p1 := (inc_neg+inc_neg-inch,inc_neg-inch); %double times addition in x-axis just because to allign the cloth for all sizes at right

	%from length to waist
	p2 := (h,inc_neg-inch);
	
	p3 := (h,Length - 3.81 - 5.08); % 1.5 inch for the back neck + 2 inches for creating space for L,M,S
	
	p4 := (n,Length + inc_pos +inch);
	
	p5 := (-(Shoulder-inc_neg-inc_neg)-inch,Length + inc_pos - inch +inch); %First inch is for the creating a wedge second is for sewing space in ypart
	
	p6 := (-(Shoulder-inc_neg-inc_neg)-inch,20.32 + 20.32 + ((2/3)* ArmHole));
	
	p7 := (-(c-inc_neg-inc_neg)-inch,20.32 + 20.32 +5.08); % 8 inch + 8 inch addition is because of the distance between waist and chest and hip and waist
	
	p8 := ((h-w) + (inc_neg+inc_neg)-inch,20.23 + inc_pos); 
	
enddef;

%================================================================================
def sewSpace(expr t) =
	inc_neg := -1 * inch;
	inc_pos := inch;
	s1 := (inc_neg+inc_neg,inc_neg);
	s2 := (h,inc_neg);
	
	s3 := (n,Length + inc_pos);
	s4 := (-(Shoulder-inc_neg-inc_neg),Length + inc_pos - inch);
	s5 := (-(Shoulder-inc_neg-inc_neg),20.32 + 20.32 + ((2/3)* ArmHole));
	s6 := (-(c-inc_neg-inc_neg),20.32 + 20.32 +5.08);
	s7 := ((h-w) + (inc_neg+inc_neg),20.23 + inc_pos);
	
enddef;
%===============================================================================

%========================================		
% Entering the measurements in cm
%========================================
Neck := 30.385;
Waist := 69.29;
Chest := 86.36;
Hip := 101.6;
Length := 101.6;
Shoulder := 8.382; % This is of 1 side taking from the neck to the end of shoulder
ArmHole := 17.78; % it is taken from the back side
LowerArm := 15;
sleeve_length := 50;

%========================================
%scaling to quarter portion
%========================================
n := Neck/4;
w := Waist/4;
c := Chest/4;
h := Hip/4;
a := 45; % angle of cutting from neck to shoulders
lArm := LowerArm/2;

%========================================
beginfig(1)
	pair p[],s[];
	pickup pencircle scaled 1bp;
	ParamforBack(t);
	sewSpace(t);
	path back,sewOne,sewTwo;
		
	back := p1--p2..p3--p4{dir a}--p5..p6..p7{curl 0}...p8 rotated 2..p1;
	sewOne := s1--s2;
	sewTwo := s3--s4..s5..s6{curl 0}..s7..s1;
		
	
	draw back withcolor blue;
	draw sewOne dashed evenly withcolor .5(black+white);
	draw sewTwo dashed evenly withcolor .5(black+white);
		
endfig;

%********************************************************************

beginfig(2)
	u := 0;
	
	ParamforSleeve(u);
	path sleeve; sleeve := q3..q12..q10..q9..q1..q13..q14..q15..q2--q4--q5--q3;
	draw sleeve withcolor blue;
endfig;
end;
