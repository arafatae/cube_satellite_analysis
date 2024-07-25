clc, clear
T1=50;
L=10;
x=1:1:10;
y=1:1:10; 
z=1:1:10;
[xx, yy, zz] = meshgrid(x,y,z);
Txyz = zeros(size(zz));
%counters
w=1;
p=1;
q=1;
r=1;
for q=1:length(x) %first loop to go through all X values
    for p=1:length(y) %second loop to go through all Y values for every X value.
        for r=1:length(z)
            %set values for next loop.
            tetatotal=0;
            w=1;
            u=1;
            lamda=0;
            for w=1:100 %third loop to get the summation of all values of the eigen function.
                lamda=w*pi/L;
                beta=0;
                Cmn=0;
                Cnm=0;
                u=0;
                v=0;
                w=0;
                for u=1:100
                    beta=u*pi/L;
                    Cmn=sqrt((lamda^2)+(beta^2));
                    C1=40*((cos(pi*u)-1)*(cos(pi*w)-1))/((pi)*sinh(Cmn*L));
                    C2=5/(sinh(Cmn*L));
                    C3=25/(sinh(Cmn*L));
                    teta1=C1*((sin(lamda*x(q)))*(sinh(Cmn*y(p)))*(sin(beta*z(r))));
                    teta2=C2*((sinh(Cmn*x(q)))*(sin(lamda*y(p)))*(sin(beta*z(r))));
                    teta3=C3*((sin(lamda*x(q)))*(sin(beta*y(p)))*(sinh(Cmn*z(r))));
                    tetatotal = tetatotal+teta1+teta2+teta3;
                end
            end
            %Add T1 to get the Temperature and storage in a matrix to finally
            %plot
            Txyz(q,p,r)=T1+tetatotal;
        end
    end
end
% %plotting 
% Txyz;
% clf
% isosurface(xx, yy, zz, Txyz)
% colorbar
% colormap jet
% [fe, ve, ce] = isocaps(x, y, z, Txyz, length(x));
% p2 = patch('Faces', fe, 'Vertices', ve, 'FaceVertexCData', ce);
% p2.FaceColor = 'interp';
% p2.EdgeColor = 'none' ;
% grid on
% xlabel('X [cm]');
% ylabel('Y [cm]');
% zlabel('Z [cm]');
% title('Temperature distribtion');
% set(gca, 'clim', [50 50+50])
% set(get(colorbar, 'title'), 'string', '[C]', 'FontW', 'bold', 'fontname', 'Times New Roman', 'fontsize',14);
% view(3)
%Plotting
figure;

% T as a function of X and Y
subplot(1,3,1);
plot(x, squeeze(Txyz(:, 1, 1)), '-o');
xlabel('X');
ylabel('Temperature');
title('T(x) at Y=1 and Z=1');

% T as a function of X and Z
subplot(1,3,2);
plot(x, squeeze(Txyz(1, 1, :)), '-o');
xlabel('Z');
ylabel('Temperature');
title('T(z) at Y=1 and X=1');

% T as a function of Y and Z
subplot(1,3,3);
plot(y, squeeze(Txyz(1, :, 1)), '-o');
xlabel('Y');
ylabel('Temperature');
title('T(y) at X=1 and Z=1');