%% Shirt pattern - sleeve
%% Based on http://www.schneidern-naehen.de/kostenloses-schnittmuster-shirt

t := 1/5;       % Scaling factor (original size: t=1)

vardef setParamPoints(expr u) =
		% Parameters
		h1 := (13cm+u)*t;           % Height 1
		h2 := 36cm*t;               % Height 2
		w1 := (13cm + u)*t;         % Width 1
		w2 := (7cm + u)*t;          % Width 2
		w3 := (10cm + u/2)*t;       % Width 3
		w4 := (16cm + u)*t;         % Width 4
		a1 := 190;                  % Angle 1
		a2 := 160;                  % Angle 2
		a3 := 285;                  % Angle 3
		hem := 2cm*t;
		% Points
		pair p[];
		p1 = (0,h1);
		xpart p2 = xpart p1 - w1/2;
		ypart p2 = ypart p1/2;
		xpart p3 = xpart p1 - w1;
		ypart p3 = ypart p1 - h1;
		xpart p4 = xpart p1 - w2;
		ypart p4 = ypart p1 - h1 - h2;
		xpart p5 = xpart p1 + w3;
		ypart p5 = ypart p4;
		xpart p6 = xpart p1 + w4;
		ypart p6 = ypart p3;
		xpart p7 = xpart p1 + w4/2;
		ypart p7 = ypart p1/2;
enddef;

beginfig(1);
	for u=0cm step 1cm until 2cm:  % Loop over sizes S, M, L		
		setParamPoints(u);
		path sleeveA; sleeveA := p1{dir a1}..p2..{dir a1}p3{dir a3}..p4--p5;  % left part of sleeve
		path sleeveB; sleeveB := p5..{dir -a3}p6{dir a2}..p7..{dir a1}p1;     % right part of sleeve
		path line; line := (-w1,-h2+hem)--(w4,-h2+hem);                       % hem line 
		line := line cutbefore sleeveA cutafter sleeveB;                      % adjust size to sleeve curves
		draw sleeveA;
		draw sleeveB;
		draw line dashed evenly;
	endfor;
endfig;