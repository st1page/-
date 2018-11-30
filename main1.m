function main
%   Ԫ���Զ���ģ����������·�м��д���ҵ������һһ������·�߷�ʱ��
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Sidex1        Sidex2
%         +---------------+     Sidey = 2
%         |               |
%         |               |
%   ======+===============+==== Mainy 
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   T               ��ģ��ʵ��ʱ��
%   Arrival         �ܳ�����
%   Mainlength      �ɵ���
%   Mainy           �ɵ�������
%   Mainwide        �ɵ���
%   Sidewide        ��·��
%   Sidex1 Sidex2   ��·������
%   Sidey           ��·������
%   Sidelengthh     ��·�ϱ���
%   Sidelengthw     ��·������
%   MP              map����
%              1 �� 2 �� 3 �߽� 
%   lightmp         ���̵�
%   lighttime       ���̵Ƽ��
%   v               ���ٶȾ���
%   vmainmax        �ɵ������ 
%   vsidemax        ��·�����
%   time            ������ʱ�����
%   dt              ��λʱ��
%   tt              ͼ��ˢ��ʱ��
%   h               handle
%   sumtime         ����ʱ��
%   alltime         ���ܻ���ʱ��
%   changepro       �Ҳ೵��������·����
clear;clc
T = 3000; 
Mainlength = 200; Mainwide = 3; vmainmax = 6;
%Sidelengthh = 25; Sidelengthw = 100; Sidewide = 1; 
changepro = 0;
vsidemax = 4;
Sidex1 = 30; Sidex2 = 150; Sidey = 2; Mainy = 26;
[mp, v, time,lightmp] = init_mp(Sidex1,Sidex2,Sidey,Mainy,Mainlength,Mainwide);

h = print_mp(mp, NaN, 0.1);
dt = 1.2; tt=0.1;
sumtime = 0; sumpassed =0;
lighttime = 20;


alltime=0;
%mp(25,comy)=2;
cy2=130;
mp(25,cy2)=2;
for i = 1:T
    sumtime=sumtime+dt;
%   ˢ��
    if(rem(i,2)&(mp(27,8)~=2||v(27,8)~=0))[mp, v] = new_cars(dt,mp,v,vmainmax); end;
%   ���԰
    if(rem(i,2))mp(24,cy2)=1;else mp(24,cy2)=2;end;
    mp(26,cy2)=2;v(26,cy2)=0;

%   ��� chos_road2 ���� chos_road ����
    [mp, v, time] = chos_road(mp,v,time);
%   ����
    [mp, v, time] = change_speed(mp,v,time,vmainmax);
    flag = (mp(Mainy,Sidex2)==0)
%   ����    
    if(flag) 
        [mp, v, time] = fulu(mp,v,time,vsidemax,Sidex1,Sidex2,Sidey,changepro);
    end;
%   λ��&����
    [alltime, mp, v, time , sumpassed ] = move(alltime,sumpassed,mp,v,time,dt);
%   ���� 
    if(~flag)
        [mp, v, time] = fulu(mp,v,time,vsidemax,Sidex1,Sidex2,Sidey,changepro);
    end;
%   ���
    h = print_mp(mp,h,tt);
    xlabel({strcat(strcat('time = ',num2str(sumtime,'%.1f')),'s'),
            strcat('total number of vehicles =',num2str(sumpassed)),
            strcat('average passing time =',num2str(alltime/sumpassed,'%.4f'))
            ,'�����Ÿ�·�����԰Ӱ�죬���ز���'});
%     w= getframe;
%     imind  =frame2im(w);
%     [imind ,cm]=rgb2ind(imind,256);
%     if(i~=1)
%         imwrite(imind, cm, 'example2.gif','gif','WriteMode','append','DelayTime',0.01);
%     else
%         imwrite(imind, cm, 'example2.gif','gif','Loopcount',inf,'DelayTime',0.01);
%     end;
end

