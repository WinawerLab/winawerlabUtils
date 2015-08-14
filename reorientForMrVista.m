function dataOut = reorientForMrVista(dataIn, niftiFileName)

nii         = niftiRead(niftiFileName);
xform       = niftiCreateXform(nii,'inplane');

xform = xform(1:3, 1:3);

xdim = find(abs(xform(1,:))==1);
ydim = find(abs(xform(2,:))==1);
zdim = find(abs(xform(3,:))==1);
dimOrder = [xdim, ydim, zdim];

dataOut = permute(dataIn,[dimOrder,4,5, 6, 7, 8]);

if (xform(1,xdim)<0), dataOut = flip(dataOut,1); end

if (xform(2,ydim)<0), dataOut = flip(dataOut,2); end

if (xform(3,zdim)<0), dataOut = flip(dataOut,3); end

return