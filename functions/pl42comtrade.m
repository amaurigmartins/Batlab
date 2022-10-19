function [] = pl42comtrade(fname)


%**************************************************************%
%                  Variáveis Setadas pela GUI                  %
%**************************************************************%

%Nome do arquivo .pl4
NomeArq = fname; 

%Estrutura com os parâmetros do nome do registro COMTRADE
load([fname '_casedata.mat']);

% extraindo o tipo de falta a partir dos parâmetros do caso
ftypes={'AT';'BT';'CT';'AB';'BC';'CA';'ABT';'BCT';'CAT';'ABC';'ABCT'};
tpidx=findInStruct(vars,'TIPO');
tpfal=cell2mat(thiscasedata(tpidx));
tpfal=ftypes(tpfal);

%encontrando a localização da falta a partir do nome do nó
faidx=findInStruct(vars,'FALTA');
fanam=cell2mat(thiscasedata(faidx));
distAlong=findNodeDist(linecir,templatedir,fanam);

%agora as resistências de falta conforme o tipo
if strcmp(fmodel,'FTR')
    idx=findInStruct(vars,'RT');
    R1=cell2mat(thiscasedata(idx));
    idx=findInStruct(vars,'RFF');
    R2=cell2mat(thiscasedata(idx));
    CTAU="";
elseif strcmp(fmodel,'FAI')
    idx=findInStruct(vars,'RFINI');
    R1=cell2mat(thiscasedata(idx));
    idx=findInStruct(vars,'RFFIM');
    R2=cell2mat(thiscasedata(idx));
    idx=findInStruct(vars,'TAU');
    CTAU=cell2mat(thiscasedata(idx));
elseif strcmp(fmodel,'FIN')
    idx=findInStruct(vars,'RFF');
    R1=cell2mat(thiscasedata(idx));
    R2="";
    CTAU="";
end

%angulo de incidencia
idx=findInStruct(vars,'ANG');
ang=cell2mat(thiscasedata(idx));


%duracao
idx=findInStruct(vars,'DURAC');
dur=cell2mat(thiscasedata(idx));


CASO.DataHora = "";
CASO.SE = "";
CASO.RDP = "";
CASO.IDC = string(jobid);
CASO.IDF = string(fmodel);
CASO.TI = string(tpfal);
CASO.D_perc = "";
CASO.D_m = string(distAlong);
CASO.R1 = string(R1);
CASO.R2 = string(R2);
CASO.CTAU = string(CTAU);
CASO.ANGI = string(ang);
CASO.DUR = string(dur);

%Diretório onde os registros COMTRADE serão salvos
dir = fullfile(workdir,jobid,'Evoltz');

%Pegando a data e horário atual
struct_data_hora = datetime('now');   



%**************************************************************%
%                    Leitura do Arquivo .PL4                   %
%**************************************************************%
%Definindo o nome do arquivo .MAT
NomeArqMAT = strcat(NomeArq,".mat");

%Verificando se já existe um arquivo .MAT
if ~isfile(NomeArqMAT)
    comando = strcat(pl4bin,{' '},NomeArq,'.pl4');
    dos(char(comando));    
end

%Carregando o arquivo .MAT
ArqMAT = load(NomeArqMAT);



%**************************************************************%
%  Escrevendo os Registros COMTRADE para Algoritmos Fasoriais  %
%**************************************************************%
fcn_pl4combin_PH(ArqMAT,CASO,dir,struct_data_hora);



%**************************************************************%
%      Escrevendo os Registros COMTRADE para Algoritmos TW     %
%**************************************************************%
fcn_pl4combin_TW(ArqMAT,CASO,dir,struct_data_hora);

if purgepl4
    delete([NomeArq '.pl4']);
end

if ~keepmatfiles
    delete([NomeArq '.MAT']);
end

end

