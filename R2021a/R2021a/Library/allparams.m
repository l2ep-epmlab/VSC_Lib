function allparams(block)
%ALLPARAMS - Lists the names of all parameters of a Simulink object
%
% allparams(block) % or block diagram, or line, or port
% allparams  % uses gcb (the currently selected block)
%
% The parameters of the object are listed in alphabetical order.  Where possible,
% the value is also shown.  Otherwise, the data type of the value is shown.
% Where parameters are write-only, that is also indicated.
% Copyright 2006-2010 The MathWorks, Inc.
if nargin<1 || isempty(block)
    block = gcb;
end
if isempty(block)
    error('No object specified, and no current block.');
end
% Retrieve the names of the parameters and sort them alphabetically
p = get_param(block,'ObjectParameters');
f = fieldnames(p);
f = sort(f);
% Show the name of the object
if ischar(block)
    fprintf('Parameters for Simulink object %s\n',block);
else
    fprintf('Parameters for Simulink object %s\n',getfullname(block));
end
    
% Now retrieve the value of each parameter and print it.
for i=1:length(f)
    try
        v = get_param(block,f{i});
        if ischar(v)
            if any(v==10)
                % Too many lines of text.
                fprintf('   %s:       <multiline string>\n',f{i});
            elseif numel(v)>100
                % String too long
                fprintf('   %s:       <%d-character string>\n',f{i},numel(v));
            else
                fprintf('   %s:       "%s"\n',f{i},v);
            end
        elseif isnumeric(v) && numel(v)==1
            % A numeric scalar.  Show it.
            fprintf('   %s:       <%d>\n',f{i},v);
        else
            % Just show the data type.
            fprintf('   %s:       <%s>\n',f{i},class(v));
        end
    catch %#ok (identifier supported in recent releases only)
        % Probably the parameter is write-only.
        disp(lasterr); %#ok (lasterr still necessary in older releases)
    end
end