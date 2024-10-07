N = 1:5;
N = N';

%steering factor
v1 = exp(-1i*2*pi/4).^(N-1);
v2 = exp(-1i*2*pi*0).^(N-1);
v3 = exp(1i*2*pi/3).^(N-1);

%covariance matrix and noise space
R = 10*(v1*v1'+v2*v2'+v3*v3')+eye(5);
[V,D] = eig(R);
Un = V(:,1:2);

% find the reciprocal of P and plot
theta = -1/2:0.003:1/2;
Pinv = [];
for k = 1:length(theta)
    v = exp(1i*2*pi*theta(k)).^(N-1);
    Pinv = [Pinv norm(Un'*v).^2];
end
plot(theta,P,"LineWidth",2)
xlabel("\theta")
xticks([-0.25,0,0.33])
ylabel("1/P")
set(gca,"FontSize",16)
grid