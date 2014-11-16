function saida= sa_cav_y_4dof(vetor)
    global dir;
    saida = +inf;

    try      
	  saida = cav_y([vetor(1) vetor(3) vetor(2) vetor(4)]);
	  
    catch error

	saida = +inf;
    end
    
    
    %LOGANDO OS PONTOS VÁLIDOS E A TEMPERATURA
    fid = fopen(strcat(dir,'/log_valid_point_',date,'_.txt'),'a+');
    fprintf(fid,'HL = %.3f | t1//t0 = %.3f | l1//l0 = %.3f | alpha = %.2f | Tmax = %.6f\n ',vetor, saida);
    fclose(fid);
  
end


