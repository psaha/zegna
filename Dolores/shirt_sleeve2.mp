%% Basic shirt pattern - sleeve (more advanced)
%% Based on 'B.Sc. COSTUME DESIGN AND FASHION, PRINCIPLES OF PATTERN MAKING & GRADING', p.32

t := 1/10;         % Scaling factor (original size: t=1)
inch := 2.54cm*t;

sleeve_length     := 50cm*t;
lower_arm         := 15cm*t;
bust              := 80cm*t;
shoulder_to_waist := 39cm*t;
waist_to_hip      := 20cm*t;
back_width        := 32cm*t;
armhole_depth     := 20cm*t;
waist             := 60cm*t;
hip               := 85cm*t;
AAFF              := 20cm*t/2;
AAHH              := 2cm*t;
AAJJ              := 8cm*t;

a1                := 5;   % Angle for design of head opening: back part
a2                := 5;   % Angle for design of head opening: front part

AB := bust/4 - 1.5*inch;
DF := lower_arm/2 + 1*inch/4;
AABB := bust/4 + 5/4*inch;
		
vardef setSleeve =		
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
	
	% Curves
	path sleeve_fit;                      % part of the sleeve that has to fit with front/back part
	path sleeve_r;                        % rest of the sleeve
	sleeve_fit := p3..p12..p10..p9..p1..p13..p14..p15..p2;
	sleeve_r   := p2--p4--p5--p3;
	
	% Curve arc lengths
	arclb := arclength(subpath(0,4) of sleeve_fit);  % arc length of curve that has to fit back part
	arclf := arclength(subpath(4,8) of sleeve_fit);  % arc length of curve that has to fit front part
	
enddef;


vardef setBack =
	% Points
	pair q[];
	q1 = (0,0);                                                            % PP
	q2 = (0,shoulder_to_waist + waist_to_hip - AAHH);                      % HH
	q3 = (AAFF,shoulder_to_waist + waist_to_hip);                          % FF
	q4 = (back_width/2,shoulder_to_waist + waist_to_hip - 1*inch);         % KK
	q5 = (back_width/2,shoulder_to_waist + waist_to_hip - armhole_depth);  % OO
	q6 := 1/3[q4,q5];                                                      % XX
	q7 = (AABB,shoulder_to_waist + waist_to_hip - armhole_depth);          % LL
	q8 = (waist/4,waist_to_hip);                                           % MM
	q9 = (hip/4,0);                                                        % PP
		
	% Curve
	path back;
	back := q1--q2{dir a1}..q3--q4..q6..q7 & q7..{dir 270}q8{dir 270}..q9 & q9--q1;
	
	% Curve arc length
	arcl_back := arclength(subpath(3,5) of back);
	
enddef;


vardef setFront =
	% Points
	pair r[];
	r1 = (0,0);                                                            % PP
	r2 = (0,shoulder_to_waist + waist_to_hip - AAJJ);                      % JJ
	r3 = (AAFF,shoulder_to_waist + waist_to_hip);                          % FF
	r4 = (back_width/2,shoulder_to_waist + waist_to_hip - 1*inch);         % KK
	r5 = (back_width/2,shoulder_to_waist + waist_to_hip - armhole_depth);  % OO
	r6 := 1/3[q4,q5] + inch/2*dir(180);                                    % YY
	r7 = (AABB,shoulder_to_waist + waist_to_hip - armhole_depth);          % LL
	r8 = (waist/4,waist_to_hip);                                           % MM
	r9 = (hip/4,0);                                                        % PP
	
	% Curve
	path front;
	front := r1--r2{dir a2}..r3--r4..r6..r7 & r7..{dir 270}r8{dir 270}..r9 & r9--r1;
	
	% Curve arc length
	arcl_front := arclength(subpath(3,5) of front);
	
enddef;


% Draw figures
beginfig(1);
	setSleeve;
	draw sleeve_fit..sleeve_r;
endfig;

beginfig(2);
	setBack;
	draw back;
endfig;

beginfig(3);
	setFront;
	draw front;
endfig;


% Print arc lengths
show arclb, arcl_back;  % sleeve back part, back
show arclf, arcl_front; % sleeve front part, front