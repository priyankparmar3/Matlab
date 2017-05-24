%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author        : Priyank Parmar                                          %
% Tested on     : 11th February, 2017                                     %
% Description   : Matlab Script to find acute angle between two curves    %
% Input Parameters :                                                      %
%               coefficient_1 : Polynomial coefficients of curve 1        %
%                               (quadratic equation)                      %
%               coefficient_2 : Polynomial coefficients of curve 2        %
%                               (quadratic equation)                      %
% Output Parameter :                                                      %
%               theta_angle   : Acute Angle (in Degree)                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note :                                                                  %
%       Both the Equations input paramters must be in coefficient form    %
%       and for that equation must be in y = f(x) form.                   %
%       Both Equation Coefficients size must be same                      %
%       for Example Curve 1 => y = -x^2 + 12                              %
%                   Curve 2 => y = 4*x                                    %
%       Input Coefficients Must be                                        %
%                   coefficient_1 = [ -1 0 12 ]                           %
%                   coefficient_2 = [  0 4  0 ]                           %
% Link to Test Equation with Coefficients :                               %
% http://www.mathopenref.com/quadraticexplorer.html                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear all;
close all;

%% Polynomial Coefficients
coefficient_1 = [ 0.1 -0.1 15.2];
coefficient_2 = [ -5.2 54.2 -28.1];

%% Converting Polynomial Coefficients to Polynomial(Equation of Curves)
equ_1 = poly2sym(coefficient_1);
equ_2 = poly2sym(coefficient_2);

%% Finding the Intersection of Two Curves
syms x
% Equating Both the Equation
equate_equ = poly2sym(coefficient_1 - coefficient_2);
% Find factor of one of equation
fact_equ_1 = solve(equate_equ,x);
% Find Maximum of factors 
fact_equ_max_1 = double(min(fact_equ_1));
% Putting Max value of Factor to Equation 2
poly_val_equ_2 = polyval(coefficient_2,fact_equ_max_1);
% Point of Intesection
point_of_intesection = [fact_equ_max_1 poly_val_equ_2];

%% Finding Angle Theta between Curves
% Differentiation Equation 1 and Equation 2
diff_equ_1 = diff(equ_1,x);
diff_equ_2 = diff(equ_2,x);
% Finding Slopes of both Equation 1 and Equation 2
poly_diff_equ_1 = sym2poly(diff_equ_1);
poly_diff_equ_2 = sym2poly(diff_equ_2);
slope_1 = polyval(poly_diff_equ_1, fact_equ_max_1);
slope_2 = polyval(poly_diff_equ_2, fact_equ_max_1);
% Angle between the Curves
theta_angle = abs(radtodeg(atan((slope_1-slope_2) / (1+slope_1*slope_2) )))

%% Display Plot of Curves and Intersection Points
figure,
% Plot of Curve 1
ezplot(equ_1, x); hold on;
% Plot of Curve 2
ezplot(equ_2, x); hold on;
% Plot of Intersection Point on Graph
plot(poly_val_equ_2, fact_equ_max_1,'o','color','r'); 
title(sprintf('Acute Angle : %d',theta_angle));
