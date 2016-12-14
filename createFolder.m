function createFolder( folderName )
    if ~exist(folderName, 'dir')
        mkdir(folderName);
    end
end

