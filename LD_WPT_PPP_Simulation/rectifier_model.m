function Pdc = rectifier_model(Pr, Pmax, a, b)

Pdc = Pmax ./ (1 + exp(-a * (Pr - b)));

end