function xdot = pendubot_ode(t,x,u)
% pendubot_ode Ordinary differential equations for pendubot.
%
%   author:  Rahul Moghe (rahulmoghe93@gmail.com)
%
%   parameters:
%
%   t       Column vector of time points 
%   xdot    Solution array. Each row in xdot corresponds to the solution at a
%           time returned in the corresponding row of t.
%
%   This function calls is called by double_pendulum.
%
%   ---------------------------------------------------------------------

g=x(5); m1=x(6); m2=x(7); l1=x(8); l2=x(9);

xdot=zeros(9,1);

xdot(1)=x(2);

xdot(2)=-((g*(2*m1+m2)*sin(x(1))+m2*(g*sin(x(1)-2*x(3))+2*(l2*x(4)^2+...
    l1*x(2)^2*cos(x(1)-x(3)))*sin(x(1)-x(3))))/...
    (2*l1*(m1+m2-m2*cos(x(1)-x(3))^2)));

xdot(3)=x(4);

xdot(4)=(((m1+m2)*(l1*x(2)^2+g*cos(x(1)))+l2*m2*x(4)^2*cos(x(1)-x(3)))*...
    sin(x(1)-x(3)))/(l2*(m1+m2-m2*cos(x(1)-x(3))^2));