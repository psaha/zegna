% Assignment #1: Draw different style of curves

%***************************************************
% S-curve 
%***************************************************
beginfig(1)
    draw (0,0) .. (0,1cm) .. (1cm,0) .. (1cm,1cm);
    draw (0,0)     withpen pencircle scaled 4bp;
    draw (0,1cm)   withpen pencircle scaled 4bp;
    draw (1cm,0)   withpen pencircle scaled 4bp;
    draw (1cm,1cm) withpen pencircle scaled 4bp;
  
endfig;

%***************************************************
% U-curve
%***************************************************
beginfig(2)
    draw (0,0) -- (0,1cm) .. (1cm,0) .. (1cm,1cm);
  
endfig;

%***************************************************
% Inverted S-curve
%***************************************************
beginfig(3)
    draw (0,0) --- (0,1cm) .. (1cm,0) .. (1cm,1cm);
  
endfig;

%***************************************************
%Cyclic-8-like curve
%***************************************************
beginfig(4)
    draw (0,0) .. (0,1cm) .. (1cm,0) .. (1cm,1cm)
         .. cycle;
  
endfig;


%***************************************************
% Hump like curve
%***************************************************
beginfig(5)
    draw (0,0){(0,1)} .. (2cm,0){(1,0)};
  
endfig;


%***************************************************
% Inverted flexible S-curve
%***************************************************
beginfig(6)
  draw (0,0){up} .. (2cm,0){up};
endfig;


%***************************************************
%Parabolic Shaped curve
%***************************************************

beginfig(7)
    draw (0,0) .. tension 2 ..
         (1cm,1cm) .. (2cm,0);
  
endfig;


%***************************************************
% Cyclic flower curve
%***************************************************
beginfig(8)
  draw (0,u)         {right}    .. tension 4 ..
       ( u*dir -150 ){dir 120}  .. tension 4 ..
       ( u*dir -30  ){dir -120} .. tension 4 ..
  cycle;
endfig;

%***************************************************
% Family of curves
%***************************************************
beginfig(9)
    path p;
    p := (5mm,-5mm) {right} .. (2cm,0);
    draw p;
    draw p rotated 10;
    draw p rotated 20;
    draw p rotated 30;
    draw p rotated 40;
    draw p rotated 50;
    draw p rotated 60;
    draw p rotated 70;
    draw p rotated 80;
    draw p rotated 90;
  
endfig;



%***************************************************
% A semi-circle curve
%***************************************************
beginfig(10)
    draw (0,0) .. (1cm,1cm) .. (2cm,0);
  
endfig;


%***************************************************


