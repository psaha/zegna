%% Bodice sloper
%% Based on 
%% http://www.madalynne.com/how-to-draft-a-sleeve-sloper-update
%% http://www.madalynne.com/how-to-draft-a-front-bodice-sloper-update
%% http://www.madalynne.com/how-to-draft-a-back-bodice-sloper-update

input sarith;

t := 1/9;         % Scaling factor (original size: t=1)
inch := 2.54cm*t;

% Sleeve
overarm_l := 65*cm*t;
elbow_l   := 38*cm*t;
bicep     := 35*cm*t + 1*inch;
wrist     := 22.5*cm*t;
cap_h     := 7.5*inch;   %% US size 0: 5.75, size 2: 6, size 4: 6.25, size 6: 6.5, size 8: 6.75, size 10: 7, size 12: 7.25

% Front
full_l          := 49.5*cm*t;
cf_l            := 40.5*cm*t;
shoulder_l      := 9*cm*t;
across_shoulder := 34/2*cm*t;
armhole_depth   := 16.5*cm*t;
bust_depth      := 27*cm*t;
bust_span       := 24/2*cm*t;
bust_arc        := 18*cm*t + bust_span;
shoulder_slope  := 51.5*cm*t;
side_seam_l     := 23*cm*t;
waist_arc       := 27*cm*t;
dart_pl         := bust_span - 3/4*inch;

% Back
full_l_b          := 46*cm*t;   % NEW!!!
cb_l            := 44*cm*t;
shoulder_slope_b  := 46.5*cm*t; % NEW!!!
waist_arc_b       := 22*cm*t;   % NEW!!!
back_neck       := 10.5*cm*t;
back_arc        := 23*cm*t;
across_back     := 16.5*cm*t;

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
	t1 = arctime 1*inch of (r9--r7);        % Find time, where arclength is 1 inch --> there is W
	r23 = point t1 of (r9--r7);             % W
	r24 := r7 + 5/8*inch*dir(0);            % X
	z1 = r24 - (xpart r23 - xpart r24, ypart r23 - ypart r24);  % Create point which is on WX, but double as far away as X from W
	                                                            % This method only works if overarm_l - elbow_l > 1 inch, which is always the case!
	t2 = arctime (arclength(r23--r24) + 1*inch) of (r23--z1);   % Find time, where arclength is arclength(WX) + 1 inch --> there is Y
	r25 := point t2 of (r23--z1);           % Y
	r26 := r8 + 5/8*inch*dir(0);            % Z
	
	% Paths
	path sleeve_b;
	path sleeve_f;
	path sleeve_r;
	sleeve_b := r5{dir 0}..r15..r19..r16..{dir 0}r1;
	sleeve_f := r1{dir 0}..r17..r20..r18..{dir 0}r6;
	sleeve_r := r6--r26--r25--r23--r22--r9--r5;
	
	% Curve arc lengths
	arcl_sl_b := arclength(sleeve_b);
	arcl_sl_f := arclength(sleeve_f);	

enddef;


vardef setFront =		
	% Points
	pair p[];
	p1 = (0,full_l);                                                             % A
	p2 = (0,0);                                                                  % B
	p3 = (-across_shoulder, full_l);                                             % C
	p4 = (0,cf_l - 3/4*inch);                                                    % D
	p5 = (-across_shoulder, sqrt((shoulder_slope**2) - (across_shoulder**2)));   % E
	p6 = (xpart p3 + sqrt((shoulder_l**2)-((ypart p3 - ypart p5)**2)), full_l);  % F
	path q;
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
	p13 = p5 + bust_depth* unitvector(direction 0 of q);                         % N
	p14 = p13 + whatever*right = whatever[p2,p4];                                % O
	p15 = p14 + bust_span*left;                                                  % P
	p16 = (xpart p15 - sqrt(((bust_arc-bust_span)**2)-((ypart p10 - ypart p15)**2)), ypart p10);             % Q
	p17 = (xpart p15 - sqrt(((bust_arc + 1/2*inch - bust_span)**2)-((ypart p9 - ypart p15)**2)), ypart p9);  % R
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
	q := p17--p18;
	a4 = angle direction 0 of q;
	a5 = a4-90;
	a6 = a4+90;
	q := p15--p23;
	a7 = angle direction 0 of q;
	a8 = a4-90;
	
	%test := arclength(p5--p19)/(72*t)*2.54;
	%show test;
	%test := bust_arc Smul bust_arc;
		
	% Paths
	path front_sleeve;
	path front;
	front_sleeve := p19{dir a6}..p9..p12..p5;
	front := p18--p19 & front_sleeve & p5--p6{dir a2}..p8..{dir 0}p4--p2--p21--p15--p23 & p23{dir a8}..{dir a5}p18;                   
	
	% Curve arc length
	arcl_front := arclength(front_sleeve);

enddef;


vardef setBack =		
	% Points
	pair r[];
	r1 = (0,full_l);                                                             % A
	r2 = (0,0);                                                                  % B
	r3 = (across_shoulder,full_l_b);                                             % C
	r4 = (0,cb_l);                                                               % D
	r5 = (waist_arc_b + 1.5*inch,0);                                             % E
	r6 = (dart_pl,0);                                                            % G'
	r7 = (dart_pl + 1.5*inch,0);                                                 % H'
	r8 := 1/2[r6,r7];                                                            % I
	r9 = (0,side_seam_l);                                                        % J
	r10 = (back_arc + 1/8*inch,side_seam_l);                                     % K
	r11 = (xpart r8,side_seam_l);                                                % L
	r12 = (xpart r8,ypart r11-3/4*inch);                                         % M
	path v;
	v := r12--r6;
	r13 = r6 + 1/8*inch*unitvector(direction 0 of v);                            % G
	b1 = angle direction 0 of v - 90;
	v := r12--r7;
	r14 = r7 + 1/8*inch*unitvector(direction 0 of v);                            % H
	b2 = angle direction 0 of v - 90;
	r15 = (across_shoulder,sqrt(shoulder_slope_b**2 - across_shoulder**2));      % N'
	r16 = (back_neck,full_l_b);                                                  % O
	v := fullcircle scaled (2*(shoulder_l+1.5*inch)) shifted (back_neck, full_l_b);  % scaled demands the DIAMETER, NOT the RADIUS!!!
	path w;
	w := fullcircle scaled (2*shoulder_slope_b) shifted (0,0);
	z = (subpath (6,8) of v) intersectionpoint (subpath (0,2) of w);
	r17 = z;                                                                     % N
	%show arclength(r17--r16);
	%show shoulder_l + 1.5*inch;
	%show arclength(r17--r2);
	%show shoulder_slope_b;
	v := r17--r16;
	b3 = angle direction 0 of v;
	r18 = r16 + whatever*dir(b3+90) = whatever[r4,(infinity,ypart r4)];          % P
	v := r16--r18;
	b4 = angle direction 0 of v;
	b5 = (180+b4)/2;
	r19 = r18 + 1/2*inch*dir(180-b5);                                            % Q
	r20 = 1/2[r16,r17];                                                          % R
	v := r20--r12;
	r21 = r20 + 3*inch*unitvector(direction 0 of v);                             % S
	v := r16--r17;
	r22 = r20 - 1/4*inch*unitvector(direction 0 of v);                           % T'
	r23 = r20 + 1/4*inch*unitvector(direction 0 of v);                           % U'
	r24 = r21 + (arclength(r21--r22) + 1/8*inch)*unitvector(direction 0 of (r21--r22)); % T
	b6 = angle direction 0 of (r21--r24) - 90;
	r25 = r21 + (arclength(r21--r24))*unitvector(direction 0 of (r21--r23));     % U
	b7 = angle direction 0 of (r21--r25) - 90;
	r26 = r10 + 1/2*inch*unitvector(direction 0 of (r10--r5));                   % V
	r27 = 1/2[r9,r4] + 3/4*inch*down;                                            % W
	r28 = (across_back + 3/16*inch, ypart r27);                                  % X
	b8 = angle direction 0 of (r26--r5) + 90;
	
	% Paths
	path back_sleeve;
	path back;
	back_sleeve := r17..r28..{dir b8}r26;
	back := back_sleeve & r26--r5 & r5{dir 180}..{dir b2}r14 & r14--r12--r13 & r13{dir b1}..{dir 180}r2 & r2--r4 & r4{dir 0}..r19..r16 & r16..{dir b6}r24 & r24--r21--r25 & r25{dir b7}..r17;                   

	% Curve arc length
	arcl_back := arclength(back_sleeve);
	
enddef;
		
		
% Draw figures

beginfig(1);
	setSleeve;
	draw sleeve_b..sleeve_f & sleeve_r;
	%draw r[9] withpen pencircle scaled 3;
	%draw r[10] withpen pencircle scaled 3;
	%draw r[23] withpen pencircle scaled 3;
	%draw r[24] withpen pencircle scaled 3;
endfig;


beginfig(2);
	setFront;
	draw front;
	%draw p[4] withpen pencircle scaled 3;
	%draw p[7] withpen pencircle scaled 3;
	%draw p[8] withpen pencircle scaled 3;
	%draw p[14] withpen pencircle scaled 3;
	%draw p[15] withpen pencircle scaled 3;
	%draw p[16] withpen pencircle scaled 3;
	%draw p[17] withpen pencircle scaled 3;
endfig;


beginfig(3);
	setBack;
	draw back;
endfig;


% Print arc lengths
%show arcl_sl_b*2.54/(72*t);  % sleeve back part (in cm, rescaled)
show arcl_sl_f/(72*t);  % sleeve: front part (in inch, rescaled)
show arcl_front/(72*t); % front: sleeve part (in inch, rescaled)
show arcl_sl_f/(72*t) - arcl_front/(72*t) - 3/8;

show arcl_sl_b/(72*t);  % sleeve: back part (in inch, rescaled)
show arcl_back/(72*t);  % back: sleeve part (in inch, rescaled)
show arcl_sl_b/(72*t) - arcl_back/(72*t) - 3/8;

show ypart p4;
show ypart p7;