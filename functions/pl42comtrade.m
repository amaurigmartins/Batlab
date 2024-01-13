function [] = pl42comtrade(fname)

load(['.' fname '_postprocdata.mat']);

if ~isfile([fname '.mat'])
    cmd = [pl4bin ' ' fname '.pl4'];
    system(cmd);
end

atp_results=load([fname '.mat']);
Fs = 1/(atp_results.t(2)-atp_results.t(1));

workdir='Z:\Documents\_ResearchProjects\18_ATPBatlab';
outdir = fullfile(workdir,jobid,'COMTRADE');
timestamp = datetime('now');
datetime_struct=fix_datetime(timestamp);
outfname=sprintf('%s%s%s__%s',datetime_struct.yyyy,datetime_struct.mm,datetime_struct.dd,fname);
varnames=fieldnames(atp_results);
c=1;
for k=1:length(varnames)
    thisvar=varnames{k};
    if thisvar(1)=='v' || thisvar(1)=='i' %currently only voltages and currents are supported
        export_var_names{c}=[thisvar(1) '_' upper(strrep(thisvar(2:end),'Terra','GND'))];
        export_var_values(:,c)=atp_results.(thisvar);
        c=c+1;
    end
end


makecomtrade( fullfile(outdir,outfname), Fs, export_var_values, export_var_names, jobid, datetime_struct)

zip(fullfile(outdir,[outfname '.zip']),{fullfile(outdir,[outfname '.cfg']),fullfile(outdir,[outfname '.dat'])})
delete(fullfile(outdir,[outfname '.cfg']))
delete(fullfile(outdir,[outfname '.dat']))

end

function data = fix_datetime(d)

    % day
    data.dd = num2str(day(d));
    if day(d) < 10
        data.dd = strcat('0',data.dd);
    end
    
    % month
    data.mm = num2str(month(d));
    if month(d) < 10
       data.mm = strcat('0',data.mm);
    end    
    
    % year
    data.yyyy = num2str(year(d));

    % hour
    data.hh = num2str(hour(d));
    if hour(d) < 10
        data.hh = strcat('0',data.hh);
    end
    
    % minute
    data.MM = num2str(minute(d));
    if minute(d) < 10
        data.MM = strcat('0',data.MM);
    end    
    
    % second
    data.ss = num2str(floor(second(d)));
    if floor(second(d)) < 10
        data.ss = strcat('0',data.ss);
    end 
    
end