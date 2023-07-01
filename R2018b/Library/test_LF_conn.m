function out = test_LF_conn(block)
connected_to = get_param(block,'PortConnectivity');

% for i=1:length(connected_to)
%     is_connected_2_LFbus(i) = 0;
%     dst_block = get_param(connected_to(i).DstBlock,'ReferenceBlock');
%     if isempty(dst_block) == 0
%         if isa(dst_block,'cell')
%             for j=1:length(dst_block)
%                 if strcmp(dst_block{j},'spsLoadFlowBusLib/Load Flow Bus')
%                     if strcmp(get_param(dst_block{j},'Commented'),'off')
%                         is_connected_2_LFbus(i) = 1;
%                     end
%                 end
%             end
%         else
%             if strcmp(dst_block,'spsLoadFlowBusLib/Load Flow Bus')
%                     if strcmp(get_param(dst_block,'Commented'),'off')
%                         is_connected_2_LFbus(i) = 1;
%                     end
%             end
%         end
%     end       
% end

for i=1:length(connected_to)
    is_connected_2_LFbus(i) = 0;
    dst_block = get_param(connected_to(i).DstBlock,'handle');
    if isempty(dst_block) == 0
        if isa(dst_block,'cell')
            for j=1:length(dst_block)
                if (strcmp(get_param(dst_block{j},'ReferenceBlock'),'spsLoadFlowBusLib/Load Flow Bus') || strcmp(get_param(dst_block{j},'ReferenceBlock'),'powerlib/Measurements/Load Flow Bus'))
                    if strcmp(get_param(dst_block{j},'Commented'),'off')
                        is_connected_2_LFbus(i) = 1;
                    end
                end
            end
        else
            if (strcmp(get_param(dst_block,'ReferenceBlock'),'spsLoadFlowBusLib/Load Flow Bus') || strcmp(get_param(dst_block,'ReferenceBlock'),'powerlib/Measurements/Load Flow Bus'))
                    if strcmp(get_param(dst_block,'Commented'),'off')
                        is_connected_2_LFbus(i) = 1;
                    end
            end
        end
    end       
end

out = any(is_connected_2_LFbus == 1);

