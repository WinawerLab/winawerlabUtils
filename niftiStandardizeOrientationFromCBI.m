function niftiStandardizeOrientationFromCBI(data_path)
%
% Read in nifti files from a session, apply the vistasoft standard
% orientation for Inplane niftis, and re-save. This way we ensure that the
% orientation of the data matrices are the same for all scans from a
% session (Inplane, functional, field maps). This is important for some
% preprocessing tools that do not make use of header info, such as
% kendrick's preprocessfmri utiltity.
%
% niftiStandardizeOrientationFromCBI(data_path)
%
% Example: 
%   data_path = '/Volumes/server/Projects/Gamma_BOLD/wl_subj002_fieldmaps/raw';
%   niftiStandardizeOrientationFromCBI(data_path)
%
% Dependencies:
%   vistasoft
%   knkutils
%

% Define paths
xformType = 'Inplane';

if ~exist(data_path, 'dir'), mkdir(data_path); end
    
%SIEMENS Field map paths
fm_pths = matchfiles(fullfile(data_path, '*field_mapping*', '*.nii'));
    
%SIEMENS INPLANE paths
ip_pths = matchfiles(fullfile(data_path, '*T1inplane*', '*.nii'));

% CBI EPI paths
epi_pths = matchfiles(fullfile(data_path, '*Single_Shot_epi*', '*.nii'));

ni_pths = [ip_pths epi_pths fm_pths];

%Loop through all the nifti files
for i = 1:length(ni_pths)
    
    % applying xform to nifti:
    ni_pth = ni_pths{i};
    ni = niftiRead(ni_pth);
    ni_std = niftiApplyAndCreateXform(ni,xformType);

    % look at the original and the standard nifti
%     f = figure(101); pos = get(f, 'Position');
%     set(f, 'Position', [pos(1) pos(2) pos(3) pos(3)*2])
%     
%     colormap gray; 
%     
%     subplot(2,1,1)
%     imagesc(makeimagestack(mean(ni.data,4))); title('NIFTI original')
%     axis equal tight
%     
%     subplot(2,1,2)
%     imagesc(makeimagestack(mean(ni_std.data,4))); title('NIFTI standard')
%     axis equal tight
    
    % write out the standard nifti    
    ni_std.fname = strrep(ni_pth, '.nii', '_std.nii.gz');
    disp(ni_std.fname)
    pause(1)
    niftiWrite(ni_std,ni_std.fname);
    
end
