function saveGraph( folderNamem, res, model_num, size)
    f = figure('visible','off');
    hist(res(:,model_num), 20)
    title(sprintf('Distribución simulada (Modelo %s con N = %i)', char(64 + model_num), size));
    saveas(f, sprintf('%s/Graph (M=%s, N=%i).png', folderNamem, char(64 + model_num), size)); %Guarda gráfico en carpeta graphs
end

