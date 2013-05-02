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
	r6 := 1/3[r4,r5] + inch/2*dir(180);                                    % YY
	r7 = (AABB,shoulder_to_waist + waist_to_hip - armhole_depth);          % LL
	r8 = (waist/4,waist_to_hip);                                           % MM
	r9 = (hip/4,0);                                                        % PP
	
	% Curve
	path front;
	front := r1--r2{dir a2}..r3--r4..r6..r7 & r7..{dir 270}r8{dir 270}..r9 & r9--r1;
	
	% Curve arc length
	arcl_front := arclength(subpath(3,5) of front);
	
enddef;


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
	path sleeve_b;
	path sleeve_f;
	path sleeve_r;                        % rest of the sleeve
	sleeve_b := p3{dir 180}..p12..p10..p9..{dir 180}p1;
	sleeve_f := p1{dir 180}..p13..p14..p15..{dir 180}p2;
	sleeve_r   := p2--p4--p5--p3;
	
	% Curve arc lengths
	arcl_sl_b := arclength(sleeve_b);
	arcl_sl_f := arclength(sleeve_f);

enddef;
		
vardef adjustSleeve =
		
	% Adjusting the points
	% back: p12 (unten), p9 (oben)
	% front: p13 (oben), p15 (unten)
	% oben nach rechts, unten nach links -> front: kürzere Kurve, back: längere Kurve
	% oben nach links, unten nach rechts -> front: längere Kurve, back: kürzere Kurve
	
	% Back
	eps := 0.01;
	rel_error := abs(arcl_back - arcl_sl_b)/arcl_back;
	s := 0.1;
	iter := 0;
	maxIter := 200;
	
	forever: exitif((rel_error <= eps) or (iter=maxIter));
		if (arcl_back > arcl_sl_b): t := 1    % t = 1 if sleeve arc length has to be increased, otherwise t = -1
		else: t := -1 fi;
	
		p9  := (xpart p9  + t*s, ypart p9);  % oben
		p12 := (xpart p12 - t*s/2, ypart p12); % unten
	
		sleeve_b := p3{dir 180}..p12..p10..p9..{dir 180}p1;
		arcl_sl_b := arclength(sleeve_b);
		
		rel_error := abs(arcl_back - arcl_sl_b)/arcl_back;
		%show rel_error;
		s := s + 0.1;
		iter := iter + 1;
	endfor
	
	% Front
	rel_error := abs(arcl_front - arcl_sl_f)/arcl_front;
	s := 0.1;
	iter := 0;
	
	forever: exitif((rel_error <= eps) or (iter=maxIter));
		if (arcl_front > arcl_sl_f): t := 1    % t = 1 if sleeve arc length has to be increased, otherwise t = -1
		else: t := -1 fi;

		p13 := (xpart p13 - t*s, ypart p13);  % oben
		p15 := (xpart p15 + t*s, ypart p15);  % unten
	
		sleeve_f := p1{dir 180}..p13..p14..p15..{dir 180}p2;
		arcl_sl_f := arclength(sleeve_f);
		
		rel_error := abs(arcl_front - arcl_sl_f)/arcl_front;
		%show rel_error;
		s := s + 0.1;
		iter := iter + 1;
	endfor
		
enddef;

% Draw figures
beginfig(2);
	setBack;
	draw back;
endfig;

beginfig(3);
	setFront;
	draw front;
endfig;

beginfig(1);
	setSleeve;
	draw sleeve_b & sleeve_f & sleeve_r;
	draw p[1] withpen pencircle scaled 3;
	draw p[9] withpen pencircle scaled 3;
	draw p[10] withpen pencircle scaled 3;
	draw p[12] withpen pencircle scaled 3;
	draw p[3] withpen pencircle scaled 3;
	draw p[13] withpen pencircle scaled 3;
	draw p[14] withpen pencircle scaled 3;
	draw p[15] withpen pencircle scaled 3;
	draw p[2] withpen pencircle scaled 3;
endfig;

beginfig(4);
	adjustSleeve;
	draw sleeve_b & sleeve_f & sleeve_r;
	draw p[1] withpen pencircle scaled 3;
	draw p[9] withpen pencircle scaled 3;
	draw p[10] withpen pencircle scaled 3;
	draw p[12] withpen pencircle scaled 3;
	draw p[3] withpen pencircle scaled 3;
	draw p[13] withpen pencircle scaled 3;
	draw p[14] withpen pencircle scaled 3;
	draw p[15] withpen pencircle scaled 3;
	draw p[2] withpen pencircle scaled 3;
endfig;

% Print arc lengths
show arcl_sl_b, arcl_back;  % sleeve back part, back
show arcl_sl_f, arcl_front; % sleeve front part, front