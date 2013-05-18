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
	pair p[];
	p1 = (0,AB/2);                        % A
	p2 = (-AB,0);                         % E mirrored
	p3 = (AB,0);                          % E
	p4 = (-DF,-(sleeve_length-AB/2));     % F mirrored
	p5 = (DF,-(sleeve_length-AB/2));      % F
	p6 := 1/4[p1,p3];                     % c
	p7 := 1/2[p1,p3];                     % b
	p8 := 3/4[p1,p3];                     % a
	alpha := -angle(p3-p1);               % angle between AB and AE (alpha>0)
	p9 := p6 + inch/2*dir(90-alpha);      % g
	p10 := p7 + inch/4*dir(90-alpha);     % f
	p11 := p8 + inch/2*dir(90-alpha+180); % d
	p12 := p8 + inch/4*dir(90-alpha+180); % e
	p13 := (-xpart p9,ypart p9);          % g mirrored
	p14 := (-xpart p7,ypart p7);          % b mirrored
	p15 := (-xpart p11,ypart p11);        % d mirrored
enddef;

beginfig(1);
	u := 0cm;
	setParamPoints(u);
	path sleeve; sleeve := p3..p12..p10..p9..p1..p13..p14..p15..p2--p4--p5--p3;
	draw sleeve;
endfig;
