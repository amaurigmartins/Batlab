function [] = makecomtrade( file, Fs, var_values, var_names, jobID, datetime_struct)
% Writes data from ATP into ASCII COMTRADE file.

FREQ = 60; %default value, change as needed
f = 0;
v = 0;
[fpath, fname, ~]=fileparts(file);

% if nargout<1 % will write into file

% prepare data for writing
[L C] = size(var_values);
if L>C
    var_values = var_values';
end
a = max([L C]);
L = min([L C]);
C = a;
G = max(var_values');
minVal = min(var_values');
G = max(abs(G),abs(minVal));
[a,t]=min(G);
while a==0
    G(t)=1;
    [a,t]=min(G);
end
G = G/32767;
var_values = diag(1./G) * var_values;
% COMTRADE fields
a=(1:C);
t=(0:C-1)*1E6/Fs;
string = '%010.0f,%010.0f';
dad = [a;t];
for i=1:L
    string = [string ',%06.0f'];
    dad = [dad;var_values(i,:)];
end
string = [string '\r\n'];
% write datafile
a=findstr(fname,'.');
if ~isempty(a)
    fname = [fname(1:(a-1)) '.dat'];
else
    fname = [fname '.dat'];
end
if ~exist('COMTRADE', 'dir')
    mkdir('COMTRADE');
end
fid = fopen(fullfile(fpath,fname),'w');
fprintf( fid, string, dad);
fprintf( fid,'\r\n');
fclose(fid);

% write config file
a=findstr(fname,'.');
fname = [fname(1:(a-1)) '.cfg'];
fid = fopen(fullfile(fpath,fname),'w');
fprintf( fid,'%s,ATP-Batlab JobID: %s\r\n', fname(1:(a-1)),jobID);
t = int2str(L);
fprintf( fid,'%d,%dA,0D\r\n', L, L); % num channels
for i=1:L   % channel data
    fprintf(fid,'%d,Channel %d: %s,,,V,%G,0,0,-32767,32767\r\n',i,i, var_names{i},G(i));
end
fprintf( fid,'%d\r\n',FREQ);
fprintf( fid,'1\r\n'); %number of sampling rates
fprintf( fid,'%G,%d\r\n', Fs, C);  % sampling rate values
fprintf(fid,'%s/%s/%s,%s:%s:%s.000000\r\n',...
    datetime_struct.mm,...
    datetime_struct.dd,...
    datetime_struct.yyyy,...
    datetime_struct.hh,...
    datetime_struct.MM,...
    datetime_struct.ss);
fprintf(fid,'%s/%s/%s,%s:%s:%s.000000\r\n',...
    datetime_struct.mm,...
    datetime_struct.dd,...
    datetime_struct.yyyy,...
    datetime_struct.hh,...
    datetime_struct.MM,...
    datetime_struct.ss);

fprintf( fid,'ASCII\r\n\r\n');
fclose(fid);

end