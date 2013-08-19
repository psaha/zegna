%% Bodice sloper
%% Based on 
%% http://www.madalynne.com/how-to-draft-a-sleeve-sloper-update
%% http://www.madalynne.com/how-to-draft-a-front-bodice-sloper-update
%% http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update

t := 1;         % Scaling factor (original size: t=1)
inch := 2.54cm*t;

% Sleeve
overarm_l := 60*cm*t;
elbow_l   := 36*cm*t;
bicep     := 35*cm*t + 1*inch;
wrist     := 23*cm*t;
cap_h     := 7.5*inch;   %% US size 0: 5.75, size 2: 6, size 4: 6.25, size 6: 6.5, size 8: 6.75, size 10: 7, size 12: 7.25

% Front
full_l          := 48*cm*t;
cf_l            := 40*cm*t;
shoulder_l      := 13*cm*t;
across_shoulder := 41/2*cm*t;
armhole_depth   := 18*cm*t;
bust_depth      := 27*cm*t;
bust_span       := 21/2*cm*t;
bust_arc        := 19*cm*t + bust_span;
shoulder_slope  := 47.5*cm*t;
side_seam_l     := 17*cm*t;
waist_arc       := 27.5*cm*t;
dart_pl         := bust_span - 3/4*inch;

% Back
full_l_b          := 41.5*cm*t;
cb_l              := 39.5*cm*t; % Looks nice if difference between full_l_b and cb_l is not less than 2cm!
shoulder_slope_b  := 43*cm*t;
waist_arc_b       := 20.5*cm*t;
back_neck         := 9*cm*t;
back_arc          := 24*cm*t;
across_back       := 20*cm*t; % Adjust this measurement in order to obtain nice curve! Shouldn't have too big an influence.

b13 := 0;

vardef setSleeve =		
	% Points
	pair r[];
	r1 = (0,overarm_l);                     % A
	r2 = (0,0);                             % B (origin!)
	r3 = (0,overarm_l - cap_h);             % C
	r4 = (0,overarm_l - elbow_l);           % D
	r5 = (-bicep/2, overarm_l - cap_h);     % E
	r6 = (bicep/2, overarm_l - cap_h);      % F
	r7 = (-wrist/2, 0);                     % G
	r8 = (wrist/2, 0);                      % H
	r9 = (r5--r7) intersectionpoint (r4--(-max(bicep/2,wrist/2),overarm_l-elbow_l)); % I
	r10 = (r6--r8) intersectionpoint (r4--(max(bicep/2,wrist/2),overarm_l-elbow_l)); % J
	r11 := r5 + bicep/8*dir(0);             % K 
	r12 := r6 + bicep/8*dir(180);           % L
	r13 := r1 + bicep/8*dir(180);           % M
	r14 := r1 + bicep/8*dir(0);             % N
	r15 := r11 + 7/8*inch*dir(90);          % O
	r16 := r13 + 5/8*inch*dir(270);         % P
	r17 := r14 + 3/8*inch*dir(270);         % Q
	r18 := r12 + 5/8*inch*dir(90);          % R
	r19 := 1/2[r15,r16];                    % S
	r20 := 1/2[r17,r18];                    % T
	r21 := 1/2[r4,r9];                      % U
	r22 := r21 + 3/8*inch*dir(270);         % V
	
	r23 := r9 + 1*inch*unitvector(direction 0 of (r9--r7));  % W
	r24 := r7 + 5/8*inch*right;             % X
	r25 := r23 + (arclength(r6--r8)-arclength(r5--r9))*unitvector(direction 0 of (r23--r24));  % Y
	path u;
	path v;
	
	% Dart construction: Start
	r23 := r22 + arclength(r22--r9)*unitvector(direction 0 of (r22--r23));     % W (verlängert)
	u := r9--r5;  % I-E
	v := r9--r22; % I-V
	in := angle direction 0 of u + abs(angle direction 0 of v); % incoming angle at dart
	u := r23--r22; % W-V
	v := r23--r25; % W-Y
	out := angle direction 0 of u + abs(angle direction 0 of v);  % outcoming angle at dart
		
	% translation of points I and W by the same length -> sum of incoming and outcoming angle should be decreased until 180 degrees
	eps := 1;  % result should be: incoming angle + outcoming angle - 180° < eps°
	s := 0.01;  % increase of length in percent: if too large, procedure fails (t-1: in + out > 180, t: in + out < 180 and abs(in + out - 180)>eps!!!)
	pair iter[];
	iter1 := r9;  % I
	iter2 := r23; % W
	%counter := 0;
	
	%forever: exitif((abs(in + out - 180) < eps) or (counter>50));
	forever: exitif(abs(in + out - 180) < eps);
		iter3 := iter1 + s*arclength(r22--iter1)*unitvector(direction 0 of (r22--iter1));  % New I
		iter4 := iter2 + s*arclength(r22--iter2)*unitvector(direction 0 of (r22--iter2));  % New W
		in := angle direction 0 of (iter1--r5) + abs(angle direction 0 of (iter1--r22));   % incoming angle at dart
		out := angle direction 0 of (iter2--r22) + abs(angle direction 0 of (iter2--r25)); % outcoming angle at dart
		%show in+out;
	
		if (in + out > 180): iter1 := iter3; iter2 := iter4; % accept new solution
		else: s:=s*0.5; fi;                                  % otherwise decrease step length
		%counter := counter + 1;
	endfor;
	
	r9  := iter1;  % I
	r23 := iter2;  % W
	% Dart construction: End
	
	u := fullcircle scaled (2*wrist) shifted r25;
	v := fullcircle scaled (2*(arclength(r5--r9) + arclength(r23--r25))) shifted r6;
	z = (subpath (0,8) of u) intersectionpoint (subpath (4,8) of v);
	r26 = z;                                     % Z (new!)	
	
	% Alternative version!	
	%u := fullcircle scaled (2*1*inch) shifted r9;
	%v := fullcircle scaled (2*arclength(r9--r22)) shifted r22;
	%r23 = (subpath (6,8) of u) intersectionpoint (subpath (4,6) of v);  % W (new!)
	%u := r9--r22;  % I-V
	%v := r9--r5;   % I-E
	%c1 = angle direction 1 of u;
	%c2 = angle direction 1 of v;
	%c3 = -c1 + c2; % incoming angle to dart
	%u := r23--r22; % W-V
	%c4 = -(180 - c3 - angle direction 1 of u); % outgoing angle of dart (180 - incoming angle)
	%r24 = r23 + whatever*dir(c4) = whatever[r2,(-infinity,ypart r2)]; % X (new!)
	%r25 := r24 + 1*inch*dir(c4);                 % Y (new!)
	%u := fullcircle scaled (2*wrist) shifted r25;
	%v := fullcircle scaled (2*(arclength(r5--r9) + arclength(r23--r25))) shifted r6;
	%z = (subpath (0,8) of u) intersectionpoint (subpath (6,8) of v);
	%r26 = z;                                     % Z (new!)
	% End of alternative version!
		
	% Sleeve cap ease
	eq1 := arclength(r5{dir 0}..r15..r19..r16..{dir 0}r1) - 3/8*inch - arcl_back;
	eq2 := arclength(r1{dir 0}..r17..r20..r18..{dir 0}r6) - 3/8*inch - arcl_front;
	eps := 0.1; % absolute error of arclength differences
	s   := 1;  % step length
	pair iter[];
	iter1 := r1;  % A
	counter := 0;
	
	if ((eq1>0) and (eq2>0)):
		forever: exitif((eq1<=eps) or (eq2<=eps));
			iter2 := iter1 + s*down;            % New A
			iter3 := iter2 + bicep/8*dir(180);  % New M
			iter4 := iter2 + bicep/8*dir(0);    % New N
			iter5 := iter3 + 5/8*inch*dir(270); % New P
			iter6 := iter4 + 3/8*inch*dir(270); % New Q
			iter7 := 1/2[r15,iter5];            % New S
			iter8 := 1/2[iter6,r18];            % New T
			
			new_eq1 := arclength(r5{dir 0}..r15..iter7..iter5..{dir 0}iter2) - 3/8*inch - arcl_back;  % New eq1
			new_eq2 := arclength(iter2{dir 0}..iter6..iter8..r18..{dir 0}r6) - 3/8*inch - arcl_front; % New eq2
			
			if ((new_eq1>0) and (new_eq2>0)): iter1 := iter2; eq1 := new_eq1; eq2 := new_eq2;     % Accept new solution
			else: s:=s*0.5; fi;                                                                   % Decrease step length
		endfor;
	
		r1  := iter2;  % A
		r13 := iter3;  % M
		r14 := iter4;  % N
		r16 := iter5;  % P
		r17 := iter6;  % Q
		r19 := iter7;  % S
		r20 := iter8;  % T
		
		if (eq1 > eps):
			show arclength(r5--r1)/(72*t);
			% Problem: even straight line is too long.. maybe measurement error???
		fi;
		
	fi;
	
	% Paths
	path sleeve_b;
	path sleeve_f;
	path sleeve_r;
	sleeve_b := r5{dir 0}..r15..r19..r16..{dir 0}r1;
	sleeve_f := r1{dir 0}..r17..r20..r18..{dir 0}r6;
	sleeve_r := r6--r26 & r26{dir 180}..{dir 180}r25 & r25--r23--r22--r9--r5;
	
	% Curve arc lengths
	arcl_sl_b := arclength(sleeve_b);
	arcl_sl_f := arclength(sleeve_f);
	
	show (arclength(r6--r8) - arclength(r5--r9) - arclength(r23--r25))*2.54/(72*t);
	
enddef;


vardef setBack =		
	% Points
	pair s[];
	s1 = (0,full_l);                                                             % A
	s2 = (0,0);                                                                  % B
	s3 = (across_shoulder,full_l_b);                                             % C
	s4 = (0,cb_l);                                                               % D
	s5 = (waist_arc_b + 1.5*inch,0);                                             % E
	s6 = (dart_pl,0);                                                            % G'
	s7 = (dart_pl + 1.5*inch,0);                                                 % H'
	s8 := 1/2[s6,s7];                                                            % I
	s9 = (0,side_seam_l);                                                        % J
	s10 = (back_arc + 1/8*inch,side_seam_l);                                     % K
	s11 = (xpart s8,side_seam_l);                                                % L
	s12 = (xpart s8,ypart s11-3/4*inch);                                         % M
	
	% Dart construction: Start
	path v;
	v := s6--s12;  % G'-M
	in := 180 - angle direction 0 of v; % incoming angle at dart
	v := s7--s12;  % H'-M
	out := angle direction 0 of v;      % outcoming angle at dart
	
	% translation of points G' and H' by the same length -> sum of incoming and outcoming angle should be decreased until 180 degrees
	eps := 0.5;  % result should be: incoming angle + outcoming angle - 180° < eps°
	s := 0.1;  % increase of length in percent
	pair iter[];
	iter1 := s6; % G'
	iter2 := s7; % H'
	
	forever: exitif(abs(in + out - 180) < eps);
		iter3 := iter1 + s*arclength(s12--iter1)*unitvector(direction 0 of (s12--iter1)); % New G'
		iter4 := iter2 + s*arclength(s12--iter2)*unitvector(direction 0 of (s12--iter2)); % New H'
		in := angle direction 0 of (iter3--s2) - angle direction 0 of (iter3--s12);   % incoming angle at dart
		out := angle direction 0 of (iter4--s12) - angle direction 0 of (iter4--s5);  % outcoming angle at dart
		%show in + out;
		
		if (in + out > 180): iter1 := iter3; iter2 := iter4; % accept new solution
		else: s:=s*0.5; fi;                                  % otherwise decrease step length
	endfor;
	
	s13 := iter1;  % G
	s14 := iter2;  % H
	
	b1 = angle direction 0 of (s12--s13) - 90;  % incoming angle of curve at G (such that there is a right angle)
	b2 = angle direction 0 of (s12--s14) - 90;  % incoming angle of curve at H (such that there is a right angle)
	% Dart construction: End
	
	s16 = (back_neck,full_l_b);                                                  % O
	v := fullcircle scaled (2*(shoulder_l+0.5*inch)) shifted (back_neck, full_l_b);  % scaled demands the DIAMETER, NOT the RADIUS!!!
	path w;
	w := fullcircle scaled (2*shoulder_slope_b) shifted (0,0);
	
	%OLD z = (subpath (6,8) of v) intersectionpoint (subpath (0,2) of w);
	%OLD s17 = z;                                                                     % N
	
	s30 := (subpath (0,2) of w) intersectionpoint (s3--(xpart s3,-infinity));     % N'
	s17 := (subpath (6,8) of v) intersectionpoint ((-infinity,ypart s30)--(infinity,ypart s30));  % N  According to post on blog: Length B-N' does not need to be the same as B-N!!!
	
	v := s17--s16;
	b3 = angle direction 0 of v;
	s18 = s16 + whatever*dir(b3+90) = whatever[s4,(infinity,ypart s4)];          % P
	v := s16--s18;
	b4 = angle direction 0 of v;
	b5 = (180+b4)/2;
	s19 = s18 + 1/2*inch*dir(180-b5);                                            % Q
	s20 = 1/2[s16,s17];                                                          % R
	v := s20--s12;
	s21 = s20 + 3*inch*unitvector(direction 0 of v);                             % S
	
	% Dart construction: Start
	v := s16--s17;
	s22 = s20 - 1/4*inch*unitvector(direction 0 of v);                           % T'
	s23 = s20 + 1/4*inch*unitvector(direction 0 of v);                           % U'
	s29 = s21 + (arclength(s21--s22))*unitvector(direction 0 of (s21--s23));     % U''
	v := s22--s16; % T'-O
	w := s22--s21; % T'-S
	in := 360 - angle direction 0 of v - abs(angle direction 0 of w); % incoming angle at dart
	v := s29--s17; % U''-N
	w := s29--s21; % U''-S
	out := abs(angle direction 0 of w) - abs(angle direction 0 of v);  % outcoming angle at dart
	
	% translation of points T' and U'' by the same length -> sum of incoming and outcoming angle should be decreased until 180 degrees
	eps := 0.5;  % result should be: incoming angle + outcoming angle - 180° < eps°
	s := 0.1;  % increase of length in percent
	pair iter[];
	iter1 := s22; % T'
	iter2 := s29; % U''
	
	forever: exitif(abs(in + out - 180) < eps);
		iter3 := iter1 + s*arclength(s21--iter1)*unitvector(direction 0 of (s21--iter1)); % New T'
		iter4 := iter2 + s*arclength(s21--iter2)*unitvector(direction 0 of (s21--iter2)); % New U''
		in := 360 - angle direction 0 of (iter3--s16) - abs(angle direction 0 of (iter3--s21));   % incoming angle at dart
		out := abs(angle direction 0 of (iter4--s21)) - abs(angle direction 0 of (iter4--s17));   % outcoming angle at dart
		%show in + out;
		
		if (in + out > 180): iter1 := iter3; iter2 := iter4; % accept new solution
		else: s:=s*0.5; fi;                                  % otherwise decrease step length
	endfor;
	
	s24 := iter1;  % T
	s25 := iter2;  % U
	% Dart construction: End
	
	b6 = angle direction 0 of (s21--s24) - 90;
	b7 = angle direction 0 of (s21--s25) - 90;
	s26 = s10 + 1/2*inch*unitvector(direction 0 of (s10--s5));                   % V
	s27 = 1/2[s9,s4] + 3/4*inch*down;                                            % W
	s28 = (across_back + 3/16*inch, ypart s27);                                  % X
	s31 := s26 + 1/8*inch*right;                                                 % Y
	%b8 = angle direction 0 of (s26--s5) + 90;
	b8 = angle direction 0 of (s31--s5) + 90;
	
	% Angles at neck for smooth transition
	v := s18--s16;  % P--O
	b9 := angle direction 0 of v;  % Angle neck transition (back): right angle
	%b10 = angle direction 0 of (s17--s16);               % N--O
	b10 = angle direction 0 of (s24--s16);               % T--O
	b11 = angle direction 0 of (s17--s25);               % N--U
	%b12 = angle direction 0 of (s17..s28..{dir b8}s26);  % N..X..V
	b12 = angle direction 0 of (s17..s28..{dir b8}s31);  % N..X..Y
	b13 := -b12 - (180-b11);  % Angle sleeve transition (back) --> corresponding angle at front has to be 180-b13
	
	% Paths
	path back_sleeve;
	path back;
	%back_sleeve := s17..s28..{dir b8}s26;
	back_sleeve := s17..s28..{dir b8}s31;
	%back := back_sleeve & s26--s5 & s5{dir 180}..{dir b2}s14 & s14--s12--s13 & s13{dir b1}..{dir 180}s2 & s2--s4 & s4{dir 0}..s19..{dir b9}s16 & s16--s24 & s24--s21--s25 & s25--s17;	
	%back := back_sleeve & s26--s5 & s5{dir 180}..{dir b2}s14 & s14--s12--s13 & s13{dir b1}..{dir 180}s2 & s2--s4 & s4{dir 0}..s19..{dir b9}s16 & s16--s24 & s24--s21--s25 & s25--s17;	
	back := back_sleeve & s31--s5 & s5{dir 180}..{dir b2}s14 & s14--s12--s13 & s13{dir b1}..{dir 180}s2 & s2--s4 & s4{dir 0}..s19..{dir b9}s16 & s16--s24 & s24--s21--s25 & s25--s17;	

	% Curve arc length
	arcl_back := arclength(back_sleeve);
	
enddef;


vardef setFront =		
	% Points
	pair p[];
	p1 = (0,full_l);                                                             % A
	p2 = (0,0);                                                                  % B
	p3 = (-across_shoulder, full_l);                                             % C
	p4 = (0,cf_l - 3/4*inch);                                                    % D
	path q;
	q := fullcircle scaled (2*shoulder_slope) shifted (0,0);
	z = (subpath (2,4) of q) intersectionpoint (p3--(xpart p3,-infinity));
	p5 = z;                                                                      % E
	q := fullcircle scaled (2*shoulder_l) shifted z;
	p6 = (subpath (0,2) of q) intersectionpoint (p3--(0,ypart p3));              % F
	q := p5--p6;
	a1 = angle direction 1 of q;
	p7 = p6 + whatever*dir(a1+90) = whatever[p4,(-infinity,ypart p4)];           % G
	q := p6--p7;
	a2 = angle direction 0 of q;
	a3 = (180 + a2)/2;
	p8 = p7 + 1/2*inch*dir(a3);                                                  % H
	p9 = p5 + armhole_depth*down;                                                % I
	p10 = p9 + 2*inch*down;                                                      % J
	p11 = p5 + armhole_depth/2*down;                                             % K
	p12 = p11 + 1/2*inch*right;                                                  % M
	q := p5--p2;
	p13 = p5 + bust_depth*unitvector(direction 0 of q);                          % N
	p14 = p13 + whatever*right = whatever[p2,p4];                                % O
	p15 = p14 + bust_span*left;                                                  % P
	q := fullcircle scaled (2*(bust_arc-bust_span)) shifted p15;
	p16 = (subpath (2,6) of q) intersectionpoint (p10--(-infinity,ypart p10));   % Q
	q := fullcircle scaled (2*(bust_arc + 1/2*inch - bust_span)) shifted p15;
	p17 = (subpath (2,6) of q) intersectionpoint (p9--(-infinity,ypart p9));     % R
	q := p17--p16;
	p18 = p17 + side_seam_l * unitvector(direction 0 of q);                      % S
	p19 = p17 + 1/2*inch * unitvector(direction 0 of q);                         % T
	p20 = (-dart_pl,0);                                                          % U
	q := p15--p20;
	p21 = p20 + 3/16*inch * unitvector(direction 0 of q);                        % V
	q := p18--p21;
	p22 = p18 + (waist_arc - dart_pl) * unitvector(direction 0 of q);            % W
	q := p15--p22;
	p23 = p15 + arclength(p15--p21) * unitvector(direction 0 of q);              % X
	p24 = p19 + 1/8*inch*left;                                                   % Y
	q := p24--p18;  % Y-S
	a4 = angle direction 0 of q;
	a5 = a4-90;
	a6 = a4+90;
	q := p15--p23;  % P-X
	a7 = angle direction 0 of q;
	a8 = a4-90;
	q := p21--p15;  % V-P
	a11 = angle direction 0 of q + 90;	
	
	% Angles at neck for smooth transition
	q := p5--p6; % E--F
	a9 = angle direction 0 of q;
	a10 := (180 - b13) + a9;      % Angle sleeve transition (front)
		
	% Paths
	path front_sleeve;
	path front;
	%front_sleeve := p24{dir a6}..{dir 90}p12..{dir a10}p5;  % Force vertical tangent at point M
	front_sleeve := p24{dir a6}..p12..{dir a10}p5;
	front := p18--p24 & front_sleeve & p5--p6 & p6{dir a2}..p8..{dir 0}p4 & p4--p2 & p2..{dir a11}p21 & p21--p15--p23 & p23{dir a8}..{dir a5}p18;	
	
	% Curve arc length
	arcl_front := arclength(front_sleeve);

enddef;
		
		
% Draw figures

beginfig(2);
	setBack;
	pickup pencircle scaled 3pt
	draw back;
	%draw s[17] withpen pencircle scaled 10;
	%draw s[28] withpen pencircle scaled 10;
	%draw s[31] withpen pencircle scaled 10;
endfig;

beginfig(3);
	setFront;
	pickup pencircle scaled 3pt
	draw front;
	%draw p[5] withpen pencircle scaled 10;
	%draw p[9] withpen pencircle scaled 10;
	%draw p[12] withpen pencircle scaled 10;
	%draw p[24] withpen pencircle scaled 10;
endfig;

beginfig(1);
	setSleeve;
	pickup pencircle scaled 3pt
	draw sleeve_b..sleeve_f & sleeve_r;
	%draw r[5]--r[7];
endfig;


% Print arc lengths
%show arcl_sl_b*2.54/(72*t);  % sleeve back part (in cm, rescaled)
show arcl_sl_f/(72*t);  % sleeve: front part (in inch, rescaled)
show arcl_front/(72*t); % front: sleeve part (in inch, rescaled)
show arcl_sl_f/(72*t) - arcl_front/(72*t) - 3/8;

show arcl_sl_b/(72*t);  % sleeve: back part (in inch, rescaled)
show arcl_back/(72*t);  % back: sleeve part (in inch, rescaled)
show arcl_sl_b/(72*t) - arcl_back/(72*t) - 3/8;