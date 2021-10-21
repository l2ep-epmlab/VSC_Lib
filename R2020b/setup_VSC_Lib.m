function setup_VSC_Lib
    disp('Installation of VSC4SPS Library...');
    addpath('./Library');
    savepath([matlabroot,'/toolbox/local/pathdef.m']);
    lb = LibraryBrowser.LibraryBrowser2;
    refresh(lb);
    %clear lb;
    disp('VSC4SPS Library installed');
end