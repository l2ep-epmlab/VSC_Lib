addpath('./Library');
savepath([matlabroot,'/toolbox/local/pathdef.m']);
lb = LibraryBrowser.LibraryBrowser2;
refresh(lb);
clear lb;