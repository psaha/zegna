beginfig(13)
	pickup pencircle scaled 0.1pt;

	draw (0,45){dir 7}..{dir 70}(10,57); % COLLAR FOR ALL SIZES
	draw (0,43){dir 7}..{dir 70}(12,56); % COLLAR FOR ALL SIZES
	draw(0,0)--(0,45); % MIDDLE FOR ALL SIZES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	draw(0,0)--(24,0) withcolor 1red; % BUTTOM LARGE
	draw(0,2)--(24,2)withcolor 1red; % BUTTOM LARGE

	draw(10,57)--(20,52)withcolor 1red; % SHOULDER LARGE

	draw (20,52){dir 260}..{dir -18}(25,29)withcolor 1red; % SLEEVE LARGE

	draw (25,29){dir 260}..{dir -85}(22,12)withcolor 1red; % SIDE LARGE
	draw (22,12){dir -95}..{dir -95}(24,2)withcolor 1red; % SIDE LARGE
	draw (24,2){dir 85}..{dir -90}(24,0)withcolor 1red; % SIDE LARGE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	draw(0,1)--(22,1) withcolor 1blue; % BUTTOM MEDIUM
	draw(0,3)--(22,3)withcolor 1blue; % BUTTOM MEDIUM

	draw(9.8,56.65)--(19,52)withcolor 1blue; % SHOULDER MEDIUM

	draw (19,52){dir 260}..{dir -18}(22,30)withcolor 1blue; % SLEEVE MEDIUM

	draw (22,30){dir 260}..{dir -85}(20,13)withcolor 1blue; % SIDE MEDIUM
	draw (20,13){dir -95}..{dir -95}(22,3)withcolor 1blue; % SIDE MEDIUM
	draw (22,3){dir 85}..{dir -90}(22,1)withcolor 1blue; % SIDE MEDIUM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	draw(0,2)--(20,2); % BUTTOM SMALL
	draw(0,4)--(20,4); % BUTTOM SMALL

	draw(9.7,56.15)--(18,52); % SHOULDER SMALL

	draw (18,52){dir 260}..{dir -18}(20,31); % SLEEVE SMALL

	draw (20,31){dir 260}..{dir -85}(18,14); % SIDE SMALL
	draw (18,14){dir -95}..{dir -95}(20,4); % SIDE SMALL
	draw (20,4){dir 85}..{dir -90}(20,2); % SIDE SMALL

endfig;
end;