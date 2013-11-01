function startup(s)
% startup file for Jon Winawer's matlab environment.
% This file should be located in the matlab home directory, usually
%   ~/matlab/startup.m
% 
% To startup, we 
%   (1) restore matlab default paths in order to start clean
%   (2) check whether matlab was opened by the sun grid engine (in which
%       case we do not wait for user input)
%   (3) query the user for paths
%   (4) add the requested paths

% % MNE Paths
% mnehome = getenv('MNE_ROOT');
% mnematlab = sprintf('%s/share/matlab',mnehome);
% if exist(mnematlab, 'dir'), path(path,mnematlab); end
% clear mnehome mnematlab;


%% Restore defaults
fprintf('[%s]: Restoring default paths....\n', mfilename);
restoredefaultpath;

if ~isempty(javachk('desktop')), return; end

%% Paths options
myhome = '~/matlab/';
mypaths = {...
    'vistasoft' ...
    'vistaproj' ...
    'vistadisp' ...
    'vistadata' ...
    'isetbio' ...
    'knk' ...
    'ECoG' ...
    'teaching' ... ...
    };

NONE        = length(mypaths) + 1;
FAVORITES   = 0;

%% Get the selected options
str = 'Enter one or more:';


for p = 1:length(mypaths)
    str = sprintf('%s\n(%d) %s', str, p, mypaths{p});
end

str = sprintf('%s\n(%d) none', str, p+1);
str = sprintf('%s\n(%d) favorites (1,2,6)\n\n', str, 0);
drawnow();

if ~exist('s', 'var'), s = input(str,'s'); end
if isnumeric(s), s = num2str(s); end    

%% Parse the options
selectedPaths = cell(1,length(s));
for p = 1:length(s)
    num = str2double(s(p));
    switch num
        case NONE,
            thispath = 'none';
        case FAVORITES,
            thispath = 'favorites';
        otherwise
            thispath = mypaths{num};
    end
    selectedPaths{p} = thispath;
end

%% Specify the paths based on user selections
if any(strcmpi('none', selectedPaths))
    cd ~/matlab; 
    addpath(myhome)
    clear all
    disp(['Current directory: ' pwd])
    return;
end

thepaths = {};
% vistasoft
if any(strcmpi('vistasoft', selectedPaths)) ||...
        any(strcmpi('favorites', selectedPaths)) 
    thepaths = [thepaths {...
        'git/vistasoft/'...
        'git/vistatest'...
        }];
    addpath(fullfile(myhome, 'git', 'spm8'));
end

% vistadisp
if any(strcmpi('vistadisp', selectedPaths)) 

    thepaths = [thepaths {...
        'git/vistadisp/'...
        'svn/Psychtoolbox/'...
        'svn/vistastim/'...
        'svn/vistaproj/runme/'...        
        }];
end

% vistaproj
if any(strcmpi('vistaproj', selectedPaths)) ||...
        any(strcmpi('favorites', selectedPaths)) 

    thepaths = [thepaths {...
        'svn/vistaproj/'...
        }];
end

% vistadata
if any(strcmpi('vistadata', selectedPaths)) 

    thepaths = [thepaths {...
        'svn/vistadata/'...
        }];
end



% iset
if any(strcmpi('isetbio', selectedPaths)) 
    thepaths = [thepaths...
        {...
        'git/isetbio/',...
        }];
end

% knk
if any(strcmpi('knk', selectedPaths)) ||...
        any(strcmpi('favorites', selectedPaths)) 
    thepaths = [thepaths...
        {...
        'git/knkutils/'...
        'git/alignvolumedata/'...
        'git/preprocessfmri/'...                
        }];
end


% teaching
if any(strcmpi('teaching', selectedPaths)) 
    thepaths = [thepaths {'git/mrTutorials-matlab/'}];
    cd ~/matlab/git/mrTutorials-matlab/;
end

if any(strcmpi('ECoG', selectedPaths)) 
    thepaths = [thepaths ...
        {...
        'git/ECoG_pRF/'...
        'svn/kendrick/'...
        }];
    cd ~/matlab/git/ECoG_pRF/;
end


%% Load them
fprintf('[%s]:Loading Jon''s paths....\n', mfilename);
for ii = 1:length(thepaths)
    thispath = [myhome thepaths{ii}];
    addpath(genpath(thispath))
    fprintf('\t%s\n' , thispath);
end
addpath(myhome)

cd ~/projects;

clear all

disp(['Current directory: ' pwd])

%% Neuroimaging tools

%------------ FreeSurfer -----------------------------%
fshome = getenv('FREESURFER_HOME');
fsmatlab = sprintf('%s/matlab',fshome);
if (exist(fsmatlab) == 7)
	path(path,fsmatlab);
end
clear fshome fsmatlab;
%-----------------------------------------------------%

%------------ FreeSurfer FAST ------------------------%
fsfasthome = getenv('FSFAST_HOME');
fsfasttoolbox = sprintf('%s/toolbox',fsfasthome);
if (exist(fsfasttoolbox) == 7)
	path(path,fsfasttoolbox);
end
clear fsfasthome fsfasttoolbox;
%-----------------------------------------------------%

setenv( 'FSLDIR', '/usr/local/fsl' );
fsldir = getenv('FSLDIR');
fsldirmpath = sprintf('%s/etc/matlab',fsldir);
path(path, fsldirmpath);
clear fsldir fsldirmpath;


