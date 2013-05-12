% MOMb
constants;
M = 160;
ka = 4;
a = ka/(2*pi);
ko = 2*pi;
N = M;
dp = (2*pi)/N;
p = @(x) x*dp;
pc = @(x) p(x)+dp/2;
nc = @(x) [cos(pc(x)); sin(pc(x)); 0];
tc = @(x) [-sin(pc(x)); cos(pc(x)); 0];
rc = @(x) nc(x)*a;
rp = @(x,y) rc(x) + tc(x)*(y-0.5)*dl;
rhp = @(x,y) rc(x) + tc(x)*y*dl/2;
rhpm = @(x,y) rc(x) - tc(x)*(1-y)*dl/2;
dl = a*dp;
K1 = ko*eta*dl/4;
K2 = eta/(4*ko);
kv = [ko; 0; 0];
Einc = @(x)[0; 1; 0]*exp(-1j*kv'*rp(x,0));
Z = zeros(N,N);
V = zeros(N,1);
for j=0:N-1
    for i=0:N-1
        Av = K1*(intAm(j,i, N,dl,rc,tc, rp, rhp, ko) ... 
               + intAp(j,i, N,dl,rc,tc, rp, rhpm, ko));
        Phie = K2*(intP(j, i-1, N, dl, rc, tc, rp, ko) ...
               - intP(j-1, i-1, N, dl, rc, tc, rp, ko) ... 
               - intP(j, i, N, dl, rc, tc, rp, ko) ...
               + intP(j-1, i, N, dl, rc, tc, rp, ko));    
         Z(i+1,j+1) = Av + Phie;
    end
end

for j = 0:N-1;
    jm1 = mom_cycle(j-1,N);
    V(j+1) = (rc(j)-rc(jm1))'*Einc(j);
end

I = gmres(Z,V,M,tol,M);
theta = arrayfun(pc,i);
plot(theta*180/pi,abs(I));


