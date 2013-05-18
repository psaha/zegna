%% Basic shirt pattern - sleeve (more advanced)
%% Based on 'B.Sc. COSTUME DESIGN AND FASHION, PRINCIPLES OF PATTERN MAKING & GRADING', p.32

t := 1/5;       % Scaling factor (original size: t=1)
inch := 2.54cm*t;

bust := 80cm*t;
sleeve_length := 50cm*t;
lower_arm := 15cm*t;

AB := bust/4 - 1.5*inch;
DF := lower_arm/2 + 1*inch/4;

vardef setParamPoints(expr u) =		
	% Points
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

beginfig(1);
	u := 0cm;
	setParamPoints(u);
	path sleeve; sleeve := q3..q12..q10..q9..q1..q13..q14..q15..q2--q4--q5--q3;
	draw sleeve;
endfig;
