function new_point = rand_vet(vet)

  s_space = length(vet);
  new_point = vet((((s_space-1)-floor(rand()*s_space))^2)^(1/2)+1);

end
