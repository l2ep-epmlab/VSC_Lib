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
        "spsMultiBandPowerSystemStabilizerLib",
        "spsCurrentMeasurementLib",
        "spsControlledCurrentSourceLib"];

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
        "powerlib/Machines",
        "powerlib/Measurements",
        "powerlib/Electrical Sources"];

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