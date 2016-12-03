function pendubot(xinit, duration, fps, mov)
% pendubot animates the pendubot for the given input
%
%   author  :   Rahul Moghe (rahulmoghe93@gmail.com)
%   date    :   Nov 23, 2016
%
%   parameters:
%   
%   xinit=[th1; th1dot; th2; th2dot; g; m1; m2; l1; l2;...
%          lc1; lc2; I1; I2];
%
%                               Initial value problem. th1 and th1dot are
%                               the initial angle and anglular velocity. g
%                               is gravity, m1 and l1 mass and rod length.
%                               For an explaining picture, see
%                               documentation file in same folder.
%  
%   duration                    The time interval on which the ode is
%                               solved spans from 0 to duration (in sec).
%
%   fps                         Frames Per Second. The framerate is
%                               relevant both for normal (realtime)
%                               animation and movie recording.
%
%   mov                       If false, a normal realtime animation of
%                               the motion of the double pendulum (the 
%                               framerate being fps) is shown.
%                               If true, a movie (.avi) is recorded. The
%                               filename is 'doublePendulumAnimation.avi'
%                               and the folder into which it is saved is
%                               the current working directory.
%
%   This function calls pendubot_ode and is, in turn, called by
%   main.
%
%   Example call:    >> pendubot([pi;0;pi;5;9.81;1;1;2;1],100,10,false)
%   Or, simply call  >> main
%
%   ---------------------------------------------------------------------

clear All; clf;

nframes=duration*fps;
sol=ode23s(@(t,x) pendubot_ode(t,x,0),[0 duration], xinit);
t = linspace(0,duration,nframes);
y=deval(sol,t);

th1=y(1,:)'; th1dot=y(2,:)';
th2=y(3,:)'; th2dot=y(4,:)';
l1=xinit(8); l2=xinit(9);

fig = figure(1);
fig.Position = [1000 100 1049 895];
h=plot(0,0,'MarkerSize',30,'Marker','.','LineWidth',2);
range=1.1*(l1+l2);
axis([-range range -range range]);
axis square
set(gca,'nextplot','replacechildren');
	if mov
		v = VideoWriter('mov/pendubot.avi');
		open(v);
	end

    for i=1:length(th1)-1
        if ishandle(h)
            Xcoord=[0,l1*sin(th1(i)),l1*sin(th1(i))+l2*sin(th2(i))];
            Ycoord=[0,-l1*cos(th1(i)),-l1*cos(th1(i))-l2*cos(th2(i))];
            set(h,'XData',Xcoord,'YData',Ycoord,'Color','black');
            drawnow;
            F(i) = getframe;
            if mov
	        	writeVideo(v,F(i));
		    end
        end
    end
    if mov
        close(v);
    end

phaseplot = figure(2);
subplot(2,1,1)
plot(th1,th1dot,'r','LineWidth',2)
title('$\theta_1$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$\theta_1$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(2,1,2)
plot(th2,th2dot,'r','LineWidth',2)
title('$\theta_2$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$\theta_2$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_2$','Interpreter','latex','Fontsize',18)

states = figure(3);
subplot(2,2,1)
plot(t,th1,'b','LineWidth',2)
title('$\theta_1$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(2,2,2)
plot(t,th2,'b','LineWidth',2)
title('$\theta_2$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\theta_2$','Interpreter','latex','Fontsize',18)
subplot(2,2,3)
plot(t,th1dot,'b','LineWidth',2)
title('$\dot{\theta}_1$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(2,2,4)
plot(t,th2dot,'b','LineWidth',2)
title('$\dot{\theta}_2$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_2$','Interpreter','latex','Fontsize',18)