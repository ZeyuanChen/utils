%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function processImageDatabaseFiles(basePath, files, outputBasePath, dbFn, parallelized, randomized, varargin)
%  Goes over the entire database (specified as input), and performs some
%  processing on each image found. 
% 
% Input parameters:
%   - basePath: base path of the image database
%   - files: list of files to process
%   - outputBasePath: location of the top-level results directory. 
%     Will automatically create subdirectories at that location.
%   - dbFn: function to be executed on each image. Must take care of saving
%     whatever results it wants.
%   - parallelized: whether to parallelize the process or not
%   - randomized: whether to randomize the order or not
%   - extension: filename extension (e.g.: jpg) of the type of files to look for
%   - varargin: additional parameters to dbFn (application-specific)
%
% Output parameters:
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function processImageDatabaseFiles(basePath, files, outputBasePath, dbFn, ...
    parallelized, randomized, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2006-2007 Jean-Francois Lalonde
% Carnegie Mellon University
% Do not distribute
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prepare the log file, using the caller's function name
logFileId = getLogFile(2);
[r,hostname] = system('hostname -s'); hostname = hostname(1:end-1);
logAndDisplay(logFileId, 'Experiment started on %s: %s\n', hostname, datestr(now)); 

nbErrors = processDatabaseRecursiveFiles(basePath, '.', files, outputBasePath, dbFn, ...
    parallelized, randomized, logFileId, varargin{:});

logAndDisplay(logFileId, 'Experiment ended at %s with %d errors\n', datestr(now), nbErrors);
fclose(logFileId);

