clear;
close all;

Tx_ant=4;
Rx_ant=1;
num_path=3;
[H,AoD,AoA,alpha,LoS] = angular_channel(Tx_ant,Rx_ant,num_path);

NumPayload=500;
SNRdB=35;
bitsIn = randi([0 1],NumPayload,1)';
s = map_QPSK(1,bitsIn) ;
noise=10^(-SNRdB/20)*(randn(size(s))+1i*randn(size(s)))/sqrt(2);

% good DBS precoding, pointing to the best path (LoS)
angle=pi/2;
% steering_vector=exp(-1i*pi*sin(AoD_el(LoS))*[1:TX_ant_h]);
steering_vector=exp(-1i*pi*cos(AoD(LoS))*[1:Tx_ant]);
Wdbs=steering_vector'/Tx_ant; 
x_beam=Wdbs*s;
y_beam=H*x_beam+noise;

bitsOut = demap_QPSK(1,y_beam);
[~,ratio] = biterr(bitsIn,bitsOut);
disp(ratio);
figure(1);
plot(s,'.');hold on;
plot(y_beam,'.');hold off;






figure(2);
colorVec = [repmat(linspace(1,0.5,10)',1,1) zeros(10,1) zeros(10,1)];
plot(0,0,'x',10,0,'x'); hold on;
% y=1:1:10;
x=0:1:10;
for i = 1:num_path
    if i == LoS
        Ls='-'; 
    else
        Ls='--'; 
    end

    x_D(i) = 20*cos(pi/2-AoD(i));
    y_D(i) = 20*sin(pi/2-AoD(i));
    a=y_D(i)/x_D(i);
    prod=a*x;
%       y1=a*x
    plot(x,prod);
%     line([0 x_D(i)],[0 y_D(i)],'LineStyle',Ls,'Color','black');
    

    x_A(i) = 20*cos(pi/2-AoA(i));
    y_A(i) = 20*sin(pi/2-AoA(i));
    %y2=-a*x
%     line([10 10-x_A(i)],[0 y_A(i)],'LineStyle',Ls,'Color','black');
    %y2
end
plot(x_D,y_D,'o')
xlim([-1 11]);
ylim([-10 10]);
