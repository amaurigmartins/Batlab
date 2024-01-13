function [data,varnames,miscData] = readPL4(pl4file)

miscData = struct('deltat',0.0,'nvar',0,'pl4size',0,'steps',0,'tmax',0.0);

% open binary file for reading
fid = fopen(pl4file,'r');

% read DELTAT
fseek(fid,40,'bof');
miscData.deltat = fread(fid,1,'float32');

% read number of vars
fseek(fid,48,'bof');
miscData.nvar = floor(fread(fid,1,'uint32')/2);

% read PL4 disk size
fseek(fid,56,'bof');
miscData.pl4size = fread(fid,1,'uint32')-1;

%read variable names
varnames{1,1}='t';
for i = 0:miscData.nvar-1
    pos = 5*16 + i*16;
    fseek(fid,pos,'bof');
    h = fread(fid,[1 16],'*char');
    vartype=str2num(h(4));
    switch vartype
        case 4 %'V-node'
            h(1:4)='Vno_';
        case 7 %'E-bran'
            h(1:4)='Ebr_';
        case 8 % 'V-bran'
            h(1:4)='Vbr_';
        case 9 % 'I-bran'
            h(1:4)='Ibr_';
    end
    varnames{1,i+2}=h;
end


% compute the number of simulation miscData.steps from the PL4's file size
miscData.steps = (miscData.pl4size - 5*16 - miscData.nvar*16) / ...
                 ((miscData.nvar+1)*4)
miscData.tmax = (miscData.steps-1)*miscData.deltat

% Check for unexpected rows of zeros
expsize = (5 + miscData.nvar)*16 + miscData.steps*(miscData.nvar+1)*4;
nullbytes = 0;
if miscData.pl4size > expsize 
    nullbytes = miscData.pl4size-expsize;
end

% close the file
fclose(fid);

% read and store actual data as a matrix
m = memmapfile(pl4file,'Format','single','Writable',false,...
               'Offset',(5 + miscData.nvar)*16 + nullbytes,...
               'Repeat',miscData.steps*(miscData.nvar+1));
% create a Matlab matrix from the memory map data
data = reshape(m.Data,[miscData.nvar+1,miscData.steps])';

end
