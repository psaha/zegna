%*************************************************************
%Drawing the back part of the shirt with sewing guide
%*************************************************************

inch := 2.54; % since 1 inch = 2.54; This provides the space to stich

def ParamPoints(expr t) =
	inc_neg := -1 * t * inch;
	inc_pos := t * inch;
    
	% Starting from the length
	p1 := (inc_neg+inc_neg-inch,inc_neg-inch); %double times addition in x-axis just because to allign the cloth for all sizes at right

	%from length to waist
	p2 := (h,inc_neg-inch);
	
	p3 := (h,Length - 3.81 - 5.08); % 1.5 inch for the back neck + 2 inches for creating space for L,M,S
	
	p4 := (n,Length + inc_pos +inch);
	
	p5 := (-(Shoulder-inc_neg-inc_neg)-inch,Length + inc_pos - inch +inch); %First inch is for the creating a wedge second is for sewing space in ypart
	
	p6 := (-(Shoulder-inc_neg-inc_neg)-inch,((ShoulderToWaist - ArmHole) + (NeckToHip - ShoulderToWaist) + ((2/3)* ArmHole)));
	
	p7 := (-(c-inc_neg-inc_neg)-inch,(ShoulderToWaist - ArmHole) + (NeckToHip - ShoulderToWaist) +5.08); % 8 inch + 8 inch addition is because of the distance between waist and chest and hip and waist
	
	p8 := ((h-w) + (inc_neg+inc_neg)-inch,(NeckToHip - ShoulderToWaist) + inc_pos); 
	
enddef;

%================================================================================
def sewSpace(expr t) =
	inc_neg := -1 * t * inch;
	inc_pos := t * inch;
	s1 := (inc_neg+inc_neg,inc_neg);
	s2 := (h,inc_neg);
	
	s3 := (n,Length + inc_pos);
	s4 := (-(Shoulder-inc_neg-inc_neg),Length + inc_pos - inch);
	s5 := (-(Shoulder-inc_neg-inc_neg),(ShoulderToWaist - ArmHole) + (NeckToHip - ShoulderToWaist) + ((2/3)* ArmHole));
	s6 := (-(c-inc_neg-inc_neg),(ShoulderToWaist - ArmHole) + (NeckToHip - ShoulderToWaist) +5.08);
	s7 := ((h-w) + (inc_neg+inc_neg),(NeckToHip - ShoulderToWaist) + inc_pos);
	
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
ShoulderToWaist := 65.32;
NeckToHip := 90.0;

%========================================
%scaling to quarter portion
%========================================
n := Neck/4;
w := Waist/4;
c := Chest/4;
h := Hip/4;
a := 45; % angle of cutting from neck to shoulders

%========================================
beginfig(1)
	pair p[],s[];
	pickup pencircle scaled 1bp;
	for t=0 step 1 until 2:
		ParamPoints(t);
		sewSpace(t);
		path back,sewOne,sewTwo;
		
		back := p1--p2..p3--p4{dir a}--p5..p6..p7{curl 0}...p8 rotated 2..p1;
		sewOne := s1--s2;
		sewTwo := s3--s4..s5..s6{curl 0}..s7..s1;
		
		if t=0:
			draw back withcolor black;
			
		elseif t=1:
			draw back withcolor blue;
					
		else:
			draw back withcolor red;
			
		fi;
		
		draw sewOne dashed evenly withcolor .5(black+white);
		draw sewTwo dashed evenly withcolor .5(black+white);
		
	endfor
	

endfig;
end;
		
	


