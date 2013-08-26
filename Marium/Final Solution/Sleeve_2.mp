%*************************************************************
%Drawing pattern of Sleeve Bodice/Slopper
%Reference : http://www.madalynne.com/how-to-draft-a-sleeve-sloper-update
%*************************************************************
input sarith;

t := 1; % scaling factor of the square 1 X 1;
inch := 2.54*t*cm; % since 1 inch = 2.54; This provides the space to stich
ease := 2*inch; %ease is taken of 2 inches
centimeter := 1cm;
%***************************************************************

%========================================		
% Entering the measurements in cm
%========================================
%%%IMPORTANT: Make sure guidelines are atleast 1" than measurement

%overarm_length := 65*cm*t;
%elbow_length   := 38*cm*t;
%bicep     	   := 35*cm*t;
%wrist     	   := 22.5*cm*t;
%cap_height	   := 7.5*inch;   %% US size 0: 5.75, size 2: 6, size 4: 6.25, size 6: 6.5, size 8: 6.75, size 10: 7, size 12: 7.25

overarm_length := 53.5*cm*t;
elbow_length   := 33*cm*t;
bicep     	   := 29.54*cm*t;
wrist     	   := 17*cm*t;
cap_height	   := 6.5*inch;   %% US size 0: 5.75, size 2: 6, size 4: 6.25, size 6: 6.5, size 8: 6.75, size 10: 7, size 12: 7.25

%========================================

def BodiceSleeve = 
	s1 := (0,overarm_length); 							% A
	s2 := (0,0); 										% B
	s3 := (0,overarm_length - cap_height);				% C
	s4 := (0,overarm_length - elbow_length);			% D
	s5 := (-0.5 * bicep - (1 * inch),ypart s3);  		% E (This 1" is for ease)
	s6 := (0.5 * bicep + (1 * inch),ypart s3);			% F (This 1" is for ease)
	s7 := (-0.5 * wrist,ypart s2);						% G
	s8 := (0.5 * wrist,ypart s2);						% H
	s9 - s4 = whatever*((s5 - s7) rotated 90);
	s9 = whatever[s5 ,s7];								% I
	s10 - s4 = whatever * ((s6 - s8) rotated 90);
	s10 = whatever[s6 ,s8];								% J
	s11 := 1/4[s5,s3];									% K
	s12 := 1/4[s6,s3];									% L
	s13 := (-arclength(s5--s11),ypart s1);				% M
	s14 := (arclength(s6--s12),ypart s1);				% N
	s15 := (xpart s11,ypart s11 + (7/8 * inch)); 		% O
	s16 := (xpart s13,ypart s13 - (5/8 * inch)); 		% P
	s17 := (xpart s14,ypart s14 - (3/8 * inch)); 		% Q
	s18 := (xpart s12,ypart s12 + (5/8 * inch)); 		% R
	s19 := 1/2[s15,s16];								% S
	s20 := 1/2[s17,s18];								% T
	s21 := 1/2[s9,s4];									% U
	s22 := (xpart s21,ypart s21 - (3/8 *inch));			% V
	s23 := (s9 + 1* cm*unitvector(direction 0 of (s5--s7)));	% W
	s24 := (xpart s7 + (5/8 * inch),ypart s7); 					% X
	s25 := (s24 + 1* cm * unitvector(direction 0 of (s23--s24))); % Y
	s26 := (xpart s8 - (5/8 * inch),ypart s8); 					% Z
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% For refining the smoothness of curve IVW
	%show arclength(s9--s22);
	%show arclength(s22--s23);
	
	
	if round(arclength(s9--s22)) = round(arclength(s22--s23)):
		message "equal";
	else:
		path parity,WV,IV;
		save value;

		
	%%%%%figureout the smaller one
		if arclength(s22--s23) < arclength(s9--s22):
			%increase WV
			WV := s22--s23;
			parity := WV;
			value := 1;
			
		else:
			%increase IV
			IV := s9--s22;
			parity := IV;
			value := 0;
			
		fi;
			n := 0.00;		

			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		forever:
			%adjust length of WV and IV such that their angle should be 180
			len := round(arclength(parity));
			%message "len";
			%show len;
			if value = 1:
				
				if n mod 2=0:
					s23 := (xpart s23 + (n * centimeter),ypart s23 + (n * centimeter));    % W
				else:
					s23 := (xpart s23 - (n * centimeter),ypart s23 - (n * centimeter));
				fi;
			else:
				if n mod 2=0:
					s9 := (xpart s9 + (n * centimeter),ypart s9 + (n * centimeter));    % I
				else:
					s9 := (xpart s9 - (n * centimeter),ypart s9 - (n * centimeter));
				fi;
				show s9;
			
			fi;
			n := n+0.0001;
			
	    
		exitif (round((arclength(s9--s22)) - round(arclength(s22--s23))))=0;
		endfor;
		
		fi;
	
	extra := arclength(parity) - len;
	if value = 0:
		s23 := (xpart s23 + extra,ypart s23 + extra);    % W
	else:
		s9 := (xpart s9 + extra,ypart s9 + extra);    % I
	
	fi;
	
	%draw s9--s27 dashed evenly;
	%UI := arclength(s21--s9); %UI
	%pair tan;
	%tan := (UI,(3/8 * inch));
	%alpha := 2 * tan;
	%s28 := 
	
	
	%draw s9 withpen pencircle scaled 1cm;
	%draw s5 withpen pencircle scaled 1cm;
	%show s5;
	%draw s23 withpen pencircle scaled 1mm;
	

enddef;

beginfig(1)
	pair s[];
	BodiceSleeve;
	path sleeve_guide,front_sleeve,back_sleeve,IJ;
	sleeve_guide := s2--s1;
	IJ = s9--s10;
	front_sleeve := s1..s17..s20..s18..s6;
	back_sleeve := s1..s16..s19..s15..s5--s9--s22--s23--s24--s25--s26--s10--s6;
	%back_sleeve := s1..s16..s19..s15..s5--s9--s22--s23--s24--s25--s26--s6;
	draw sleeve_guide withcolor 0.5(black+white);
	draw IJ withcolor 0.5(black+white);
	draw front_sleeve;
	draw back_sleeve;
	
	%%% Matching sleeve armhole with the shirt
	message "================================";
	message "Arm hole for sleeve";
	show arclength(s15..s19..s16..s1..s17..s20..s18);
	message "================================";
	endfig;
end;