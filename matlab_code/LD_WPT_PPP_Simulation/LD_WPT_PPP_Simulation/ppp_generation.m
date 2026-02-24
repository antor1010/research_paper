function r = ppp_generation(lambda, R)

N = poissrnd(lambda * pi * R^2);

theta = 2*pi*rand(N,1);
r = R * sqrt(rand(N,1));

end