%*****************************************************************
% Drawing Bolero (A waist sized upper)
%*****************************************************************

%********************************************************************
%These are the length of single side. The symmetry will be used to
%generate the other side
%********************************************************************

Shoulders = 8.636;
ArmHole = 17.78;
SleeveLength = 12.7;
Sleeveopening = 20.32; % this is the whole circumference of the Sleeve opening
Back = 34.29;
Chest = 86.36; 
Length = 33.02;
Neck = 40.64;


%transform t,T;
%T:= identity scaled 1.5;

	
%***********************************************************************
%				START OF THE PROGRAM
%***********************************************************************	

%%%%%%FRONTAL PART

beginfig(1)
	origin = (0,0); 	%origin
	%t:=identity scaled u;
	%pair zo,z1,z2;
	
	%Scaled down all the measurement on the scale of 1-10
	
	b = (Back/4); % quarter frontal back
	c = (Chest/4) ; %quarter fronter chest
	s0 = (Sleeveopening/2);
	n = (Neck/4); %quarter neck
	
	
	%evaluating the maximum out of measurement
	%MM := max(Shoulders,ArmHole,SleeveLength,Sleeveopening,Back,Chest,Length);
	
	%scaling the figure to 10
	
	pair Zo,Zi,Zii;
	
	Zo := origin;
	Zi := (c+10,Length-ArmHole+10);
	Zii := (c-n+4,Length+10);
	
	%corner of back to Arm-hole
	draw(4,4) .. tension1 .. Zi .. Zii rotated 2;
	draw Zii--(1,Length-2+10)--(2,Length-2+10){up}--(-5,SleeveLength+10){down} -- (s0-3,SleeveLength+10){right} -- (4,4);
	
	% Now using the symmetry for the other half
	
	draw(Chest-27,5.5) ..tension1.. (c+5,Length-ArmHole+10) .. (c+n+10,Length+10){right} rotated 2;
	draw (c+n+8,Length+10) -- (Chest-30,Length-1+10) -- (Chest-29, Length-2+10){up} --
	(Chest-22,SleeveLength+10){down} -- (s0+Chest-43,SleeveLength+10){left} -- (Chest-27,5.5);
	

endfig;
end;