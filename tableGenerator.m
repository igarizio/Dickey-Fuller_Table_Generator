clc; clear all; close all; tic;

sizes = 20:5:100; %Tamaños a usar
reps = 20000; %Repeticiones
alphas = [0.01, 0.05, 0.1]; %Significancias

g = DataGenerator();
fileID = fopen('Table.csv','w');
createFolder('graphs');

fprintf(fileID, 'N, Model, Alpha, tStat\n'); %Usar: http://www.convertcsv.com/pivot-csv.htm
for size = sizes
    res =  zeros(size, 3);
    
    for rep = 1:reps
        %Para gen_ar: y_t = [cte + coef1*y_t-1 + coef2*y_t-2 + ...] (En ese orden los coeficientes)
        ar = g.gen_ar(size, [0, 1]);
        delta_y = diff(ar);

        lm1 = fitlm(ar(1:end-1), delta_y, 'Intercept', false);
        lm2 = fitlm(ar(1:end-1), delta_y);
        lm3 = fitlm([ar(1:end-1) (1:size-1)'], delta_y);
        res(rep,:) = [lm1.Coefficients.tStat(1) lm2.Coefficients.tStat(2) lm3.Coefficients.tStat(2)];
    end
    
    for model_num = 1:3
        for alpha = alphas
            v_crit = prctile(res(:,model_num), alpha*100);
            fprintf(fileID, '%d, %s, %f, %f\r\n', size, char(64 + model_num), alpha, v_crit); % Generamos archivo CSV
        end
        saveGraph('graphs', res, model_num, size);
    end
end
fclose(fileID);
toc;
