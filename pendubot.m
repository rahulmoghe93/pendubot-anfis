% function pendubot(xinit, duration, fps, mov)
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

global      k   xG  EG

clear All; clf;
upass = []; V=[];   Ebar = [];
nframes=duration*fps;
sol=ode23s(@(t,x) pendubot_ode(t,x,u_pass(t,x)),[0 duration], xinit);
t = linspace(0,duration,nframes);
y=deval(sol,t);

th1=y(1,:)'; th1dot=y(2,:)';
th2=y(3,:)'; th2dot=y(4,:)';
l1=xinit(8); l2=xinit(9);

fig = figure(1);
fig.Position = [2000 0 1049 895];
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
        upass = [upass; u_pass(t(i),y(:,i))];
        V = [V; 0.5*(k.ke*(E(t(i),y(:,i))-EG).^2+k.kd*y(2,i)^2 + k.kp*(y(1,i)-xG(1)).^2)];
        Ebar = [Ebar E(t(i),y(:,i))-EG];
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
upass = [upass;u_pass(t(end),y(:,end))];
V = [V; 0.5*(k.ke*(E(t(end),y(:,end))-EG).^2+k.kd*y(2,end)^2 + k.kp*(y(1,end)-xG(1)).^2)];
Ebar = [Ebar E(t(end),y(:,end))-EG];
close(fig);

phaseplotLyap = figure(2);
phaseplotLyap.Position = [2500 400 800 800];
subplot(2,2,1)
plot(th1,th1dot,'r','LineWidth',2)
title('$\theta_1$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$\theta_1$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(2,2,2)
plot(th2,th2dot,'r','LineWidth',2)
title('$\theta_2$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$\theta_2$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_2$','Interpreter','latex','Fontsize',18)
subplot(2,2,3)
plot(t,V,'g','LineWidth',2)
title('Lyapunov Function V(t)','Fontsize',11.5)
xlabel('time [s]','Fontsize',14.5)
ylabel('V(t)','Fontsize',14.5)
subplot(2,2,4)
plot(t,Ebar,'m','LineWidth',2)
title('Energy difference between desired state','Fontsize',11.5)
xlabel('time [s]','Fontsize',14.5)
ylabel('$\tilde{E}$(t)','Interpreter','latex','Fontsize',18)

states = figure(3);
states.Position = [2700 400 800 800];
subplot(3,2,1)
plot(t,th1./pi,'k','LineWidth',2)
title('$\theta_1$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(3,2,2)
plot(t,th2./pi,'k','LineWidth',2)
title('$\theta_2$ Phase Plot','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\theta_2$','Interpreter','latex','Fontsize',18)
subplot(3,2,3)
plot(t,th1dot,'k','LineWidth',2)
title('$\dot{\theta}_1$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_1$','Interpreter','latex','Fontsize',18)
subplot(3,2,4)
plot(t,th2dot,'k','LineWidth',2)
title('$\dot{\theta}_2$ vs. time','Interpreter','latex','Fontsize',18)
xlabel('$time$ [s]','Interpreter','latex','Fontsize',18)
ylabel('$\dot{\theta}_2$','Interpreter','latex','Fontsize',18)
subplot(3,2,[5,6])
plot(t,upass,'r','LineWidth',2)
title('Control Input','Fontsize',14.5)
xlabel('time [s]','Fontsize',14.5)
ylabel('u(t)','Fontsize',14.5)