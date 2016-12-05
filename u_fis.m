function u = u_fis(t,x)

q1 = x(1); dq1 = x(2); q2 = x(3); dq2 = x(4);

global changeFlag;
global tChange;

if abs(q1) <= 0.2 && (pi - abs(q2)) <= 0.2 && changeFlag == 0
    tChange = t;
    changeFlag = 1;
end

if changeFlag == 1
    K = max(1.4 - 4*(t-tChange),0.35);
    u = -[2 2 0 K]*[q1;tanh((q2-pi)*100);dq1;dq2]; % - 2*(pi-(q2-q1)) - 2*(dq2-dq1);
%     angle1 = q2 - pi;
%     angle2 = q1;
%     if angle1 > 0 && angle2 < 0
%         u = -10*(angle1 - angle2) ;
%     end
%     if angle1 < 0 && angle2 < 0
%         u = -10*(abs(angle2) - abs(angle1)) ;
%     end
%     if angle1 < 0 && angle2 > 0
%         u = -10*(angle1 - angle2);
%     end
%     if angle1 > 0 && angle2 > 0
%         u = -10*(abs(angle2) - abs(angle1));
%     end
else
    fismat = readfis('pendubotFIS');
    u = evalfis([q1; dq1; q2; dq2],fismat);
end
% if abs(u) > 2
%     u = 2*sign(u);
% end
end