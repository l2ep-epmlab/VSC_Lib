release_begin = 2015;
release_end = 2017;
folder2deploy = './Dev/VSC_Lib';
folder2push = './VSC_Lib';

list_release = {};

for i=release_begin:release_end
    list_release{end+1} = strcat('R', num2str(i), 'a');
    list_release{end+1} = strcat('R', num2str(i), 'b');
end
%list_release(1) = [];
list_release = list_release{2:end};

for i = 1:length(list_release)
   % mkdir(convertStringsToChars(strcat(folder2push,'/',list_release(i))));
   rmdir([folder2push '/' list_release{i}],'s');
   mkdir([folder2push '/' list_release{i}]);
end

list_files = recursiveDir(folder2deploy);
%list_files_2_push = regexprep(list_files, folder2deploy, '/');
list_files_2_push = erase(list_files, folder2deploy);

for i = 1:length(list_files)
    [folder, baseFileNameNoExt, extension] = fileparts(list_files{i});
    if (isdir(list_files{i}))
        for j = 1:length(list_release)
            mkdir([folder2push,'/',list_release{j},list_files_2_push{i}]);
        end
    end
    if (strcmp(extension,'.m')) || (strcmp(extension,'.md'))
        for j = 1:length(list_release)
            %copyfile(list_files{i},convertStringsToChars(strcat(folder2push,'/',list_release(i),list_files_2_push{i})),'f')
            copyfile(list_files{i}, [folder2push,'/', list_release{j}, list_files_2_push{i}], 'f');
        end
    end
    if (strcmp(extension,'.slx'))
        for j = 1:length(list_release)
            if strcmp(list_release{j},['R' version('-release')])
                copyfile(list_files{i}, [folder2push,'/', list_release{j}, list_files_2_push{i}], 'f');
            else
                open_system(list_files{i},'loadonly');
                Simulink.exportToVersion(bdroot, [folder2push,'/',list_release{j}, list_files_2_push{i}], list_release{j});
                close_system(list_files{i});
            end
        end
    end
end
