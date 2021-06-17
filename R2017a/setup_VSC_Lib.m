function setup_VSC_Lib
    disp('Installation of VSC4SPS Library...');
    addpath('./Library');
    savepath([matlabroot,'/toolbox/local/pathdef.m']);
    lb = LibraryBrowser.LibraryBrowser2;
    refresh(lb);
    %clear lb;
    disp('VSC4SPS Library installed');
    
    disp('Updating links in Library...');
    list_files = recursiveDir('./Library');
    
    for i_list = 1:length(list_files)
        [folder, baseFileNameNoExt, extension] = fileparts(list_files{i_list});
%         if (isdir(list_files{i}))
%             for j = 1:length(list_release)
%                 mkdir([folder2push,'/',list_release{j},list_files_2_push{i}]);
%             end
%         end
        
        if (strcmp(extension,'.slx'))
            disp(['Updating ', baseFileNameNoExt]);
            model_handle = load_system(list_files{i_list});
            
            set_param(get_param(model_handle,'Name'),'Lock','off');
            link_lib_sps(get_param(model_handle,'Name'));
            set_param(get_param(model_handle,'Name'),'Lock','on');
            save_system(model_handle);
            close_system(list_files{i_list});

        end
    end
    disp('Updating Library Links in models...');
    list_files = recursiveDir('./Examples');
    
    for i_list = 1:length(list_files)
        [folder, baseFileNameNoExt, extension] = fileparts(list_files{i_list});
%         if (isdir(list_files{i}))
%             for j = 1:length(list_release)
%                 mkdir([folder2push,'/',list_release{j},list_files_2_push{i}]);
%             end
%         end
        
        if (strcmp(extension,'.slx'))
            disp(['Updating ', baseFileNameNoExt]);
            model_handle = load_system(list_files{i_list});
            
            %set_param(get_param(model_handle,'Name'),'Lock','off');
            link_lib_sps(get_param(model_handle,'Name'));
            %set_param(get_param(model_handle,'Name'),'Lock','on');
            save_system(model_handle);
            close_system(list_files{i_list});

        end
    end

    function link_lib_sps(system_2_update)
        model_list = libinfo(system_2_update,'IncludeCommented','on');

        find_lib = ["spsUniversalBridgeLib", 
            "spsThreePhaseBreakerLib", 
            "spsThreePhaseVIMeasurementLib", 
            "spsSecondOrderFilterLib",
            "spsSeriesRLCBranchLib",
            "spsGroundLib",
            "spsThreePhaseSeriesRLCBranchLib",
            "spsSourcesModel",
            "spsBreakerModel",
            "spsThreePhaseTransformerTwoWindingsLib",
            "spsThreePhaseSourceLib",
            "spsDCVoltageSourceLib",
            "spsLoadFlowBusLib",
            "spsControlledVoltageSourceLib",
            "spsBreakerLib",
            "spsThreePhaseParallelRLCLoadLib",
            "spspowerguiLib",
            "spsVoltageMeasurementLib",
            "spsPWMGenerator2LevelLib",
            "spsThreePhaseFaultLib",
            "spsThreePhaseDynamicLoadLib",
            "spsAsynchronousMachinepuUnitsLib",
            "spsThreePhasePISectionLineLib",
            "spsThreePhaseSeriesRLCLoadLib",
            "spsGroundingTransformerLib",
            "spsDistributedParametersLineLib",
            "spsSynchronousMachinepuStandardLib",
            "spsHydraulicTurbineandGovernorLib",
            "spsExcitationSystemLib",
            "spsGenericPowerSystemStabilizerLib",
            "spsMultiBandPowerSystemStabilizerLib"];

        replace_lib = ["powerlib/Power Electronics",
            "powerlib/Elements",
            "powerlib/Measurements",
            "powerlib_meascontrol/Filters",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Electrical Sources",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Electrical Sources",
            "powerlib/Electrical Sources",
            "powerlib/Measurements",
            "powerlib/Electrical Sources",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib",
            "powerlib/Measurements",
            "powerlib_meascontrol/Pulse & Signal Generators",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Machines",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Elements",
            "powerlib/Machines",
            "powerlib/Machines",
            "powerlib/Machines",
            "powerlib/Machines",
            "powerlib/Machines"];

        for i=1:length(model_list)
            if contains(model_list(i).LinkStatus,'unresolved')
                for j=1:length(find_lib)
                    if contains(model_list(i).Library,find_lib(j))
                        block_name = model_list(i).Block;
                        str = replace(string(model_list(i).ReferenceBlock),find_lib(j),replace_lib(j));
                        if (j == 25)
                            str = [str + ' '];
                        end
                        set_param(block_name,'SourceBlock',str);
                    end 
                end
            end
        end
    end

    function dd = recursiveDir(path)
        % add a second argument "level" if you want to keep track of how many
        % levels deep it goes
        % pause
        % level = level +1
        d = dir(path);
        j = 2;
        dd = {};
        %if(isdir(path))
            dd = [dd; path];
        %end
        for i=3:1:size(d,1)
            if(isdir(horzcat(path,'/',d(i).name)))
                dd = [dd; recursiveDir(horzcat(path,'/',d(i).name))];
                j = size(dd,1)+1;
            else
                dd{j,1} = horzcat(path,'/',d(i).name);
                j = j+1;
            end
        end
    end
end