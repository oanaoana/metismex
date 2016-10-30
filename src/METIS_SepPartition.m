function [lidx,ridx,sepidx] = METIS_SepPartition(nvtxs, ...
    xadj,adjncy,vwgt,options)
% METIS_SEPPARTITION Matlab interface to the mex file of METIS_SepPartition.
%
%   [lidx,ridx,sepidx] = METIS_SepPartition(nvtxs,xadj,adjncy,vwgt,options)
%
%   This function computes the left graph, right graph and the separator
%   indices. It is actually a wrapper of single level Nested Dissection.
%
%   Parameters are explained in METIS_Parameters and options are explained
%   in METIS_Options.
%
%   See also METIS_PARAMETERS, METIS_OPTIONS.

%   Copyright (c) 2015 Yingzhou Li, Stanford University
singleidx = [];
if nargin < 3
    degree = sum((spones(nvtxs)-speye(size(nvtxs))) > 0);
    singleidx = find(degree == 0);
    idx = degree > 0;
    g = METIS_Graph(nvtxs(idx,idx));
    options = xadj;
    [lidx,ridx,sepidx] = METIS_SepPartition_mex(g.nvtxs, ...
        g.xadj-1,g.adjncy-1,[],options);
else
    xadj = xadj-1;
    adjncy = adjncy-1;
    [lidx,ridx,sepidx] = METIS_SepPartition_mex(nvtxs, ...
        xadj,adjncy,vwgt,options);
end
lidx = lidx+1;
ridx = ridx+1;
sepidx = [sepidx+1 singleidx];

end
