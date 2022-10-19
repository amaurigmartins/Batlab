function fcn_pl4combin_TW(ArqMAT,CASO,dir,struct_data_hora)

    %Separando e Ajustando as Variáveis
    LEC_SIL_C1 = fcn_OrganizarVariaveis(ArqMAT,"ls1");
    LEC_SIL_C2 = fcn_OrganizarVariaveis(ArqMAT,"ls2");
    SIL_LEC_C1 = fcn_OrganizarVariaveis(ArqMAT,"sl1");    
    SIL_LEC_C2 = fcn_OrganizarVariaveis(ArqMAT,"sl2");
    SIL_ORX_C1 = fcn_OrganizarVariaveis(ArqMAT,"so1");    
    SIL_ORX_C2 = fcn_OrganizarVariaveis(ArqMAT,"so2");
    ORX_SIL_C1 = fcn_OrganizarVariaveis(ArqMAT,"os1");        
    ORX_SIL_C2 = fcn_OrganizarVariaveis(ArqMAT,"os2");  


    %Salvando as variáveis de interesse no COMTRADE Binário
    data_hora = fcn_DataHora(struct_data_hora);     
    fcn_COMTRADE(LEC_SIL_C1,"LEC","LEC_SIL_C1",CASO,data_hora,dir);
    fcn_COMTRADE(LEC_SIL_C2,"LEC","LEC_SIL_C2",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_LEC_C1,"SIL","SIL_LEC_C1",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_LEC_C2,"SIL","SIL_LEC_C2",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_ORX_C1,"SIL","SIL_ORX_C1",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_ORX_C2,"SIL","SIL_ORX_C2",CASO,data_hora,dir);
    fcn_COMTRADE(ORX_SIL_C1,"ORX","ORX_SIL_C1",CASO,data_hora,dir);
    fcn_COMTRADE(ORX_SIL_C2,"ORX","ORX_SIL_C2",CASO,data_hora,dir);

end


%***********************************************************%
%   Função de Organização e Separação das Variáveis do PL4  %
%***********************************************************%
function LT = fcn_OrganizarVariaveis(ArqMAT,CIRCUITO)

    %Nomes de todas as variáveis que estão no arquivo .PL4     
    NomesVariaveisPL4 = fieldnames(ArqMAT);

    %Nomes das variáveis de interesse no arquivo .PL4 
    VariaveisDesejadas = [strcat("vTp",CIRCUITO,"a"); ...
                          strcat("vTp",CIRCUITO,"b"); ...
                          strcat("vTp",CIRCUITO,"c") ];

    %Fazendo a seleção das variáveis de interesse dentre as do arquivo .PL4     
    for k=1:numel(NomesVariaveisPL4)

        %Variável tempo vinda do PL4 original
        if strcmp(NomesVariaveisPL4{k},'t')
            t = ArqMAT.(NomesVariaveisPL4{k});        
        end        

        % Tensões
        if strcmp(NomesVariaveisPL4{k},VariaveisDesejadas(1))
            va = ArqMAT.(NomesVariaveisPL4{k});
        end    
        if strcmp(NomesVariaveisPL4{k},VariaveisDesejadas(2))
            vb = ArqMAT.(NomesVariaveisPL4{k});
        end    
        if strcmp(NomesVariaveisPL4{k},VariaveisDesejadas(3))
            vc = ArqMAT.(NomesVariaveisPL4{k});
        end    

        % Variáveis dos Blocos de Falta
        if strfind(NomesVariaveisPL4{k},"mFltls1")
            FLTLS1 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltls2")
            FLTLS2 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltsl1")
            FLTSL1 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltsl2")
            FLTSL2 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltso1")
            FLTSO1 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltso2")
            FLTSO2 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltos1")
            FLTOS1 = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},"mFltos2")
            FLTOS2 = ArqMAT.(NomesVariaveisPL4{k});
        end   

    end

    %Agregando todas as variáveis dos blocos de falta em uma única variável
    ind = find((FLTLS1+FLTLS2+FLTSL1+FLTSL2+FLTSO1+FLTSO2+FLTOS1+FLTOS2)>1);
    falta=zeros(size(t));
    falta(ind)=1;

    %Criando a variável com os dados dos canais analógicos
    dados_ana=[va vb vc];

    %Criando a variável com os dados dos canais digitais
    dados_dig = falta;

    %Removendo o período de incialização dos sinais         
    T_MAX_INICIALIZACAO_1 = 440e-3;
    IND_T_MAX_INICIALIZACAO_1 = find(t<T_MAX_INICIALIZACAO_1,1,'last');

    %Criando a estrutura LT que será retornanda na função
    LT.num_canais_ana = size(dados_ana,2);
    LT.num_canais_dig = size(dados_dig,2);    
    t = t(IND_T_MAX_INICIALIZACAO_1:end)-t(IND_T_MAX_INICIALIZACAO_1);
    LT.dados_ana = dados_ana(IND_T_MAX_INICIALIZACAO_1:end,:);
    LT.dados_dig = dados_dig(IND_T_MAX_INICIALIZACAO_1:end,:);
    
    %Aplicando a interpolação e o filtro do RPV311
    fs_old = 1/(t(2)-t(1));
    fs_new = 4992000;
    Ganho = 50;
    fcPA = 7e3;
    fcPB = 1E6;
    RTP = 1;
    [LT.dados_ana, LT.dados_dig, LT.fs] = fcn_filtroRPV311(LT.dados_ana,...
                                                           LT.dados_dig,...
                                                           fs_old,...
                                                           fs_new,...
                                                           Ganho,...
                                                           fcPA,...
                                                           fcPB,...
                                                           RTP);

    %Removendo o período de incialização dos sinais         
    dt = 1/LT.fs;
    t = [0:size(LT.dados_ana,1)-1]*dt;
    T_MAX_INICIALIZACAO_2 = 10e-3;
    IND_T_MAX_INICIALIZACAO_2 = find(t<T_MAX_INICIALIZACAO_2,1,'last');
    LT.dados_ana = LT.dados_ana(IND_T_MAX_INICIALIZACAO_2:end,:);
    LT.dados_dig = LT.dados_dig(IND_T_MAX_INICIALIZACAO_2:end,:);
    
                                                       

    %Atribuindo o nome da Linha
    switch CIRCUITO
        case 'ls1'
            LT.NomeLT = "LEC_SIL_C1";
        case 'ls2'
            LT.NomeLT = "LEC_SIL_C2";
        case 'sl1'
            LT.NomeLT = "SIL_LEC_C1";
        case 'sl2'
            LT.NomeLT = "SIL_LEC_C2";
        case 'so1'
            LT.NomeLT = "SIL_ORX_C1";
        case 'so2'
            LT.NomeLT = "SIL_ORX_C2";
        case 'os1'
            LT.NomeLT = "ORX_SIL_C1";
        case 'os2'
            LT.NomeLT = "ORX_SIL_C2";        
    end

    %Atribuindo parâmetros das medições usados no COMTRADE
    LT.RTP_P = [4500,4500,4500,4500];
    LT.RTP_S = [1,1,1,1];
    LT.RTC_P = [1500,1500,1500,1500];
    LT.RTC_S = [1,1,1,1];
end



%***********************************************************%
%               Função de Filtragem dos Sinais              %
%***********************************************************%
function [dados_ana_TW, dados_dig_TW, fs_new] = fcn_filtroRPV311(dados_ana,...
                                                                 dados_dig,...
                                                                 fs_old,...
                                                                 fs_new,...
                                                                 Ganho,...
                                                                 fcPA,...
                                                                 fcPB,...
                                                                 RTP)

	%Variáveis auxiliares
    Vnom = 500e3*sqrt(2)/sqrt(3)/RTP;
    ordemPB=5;
    ordemPA=5;
    
    %Número de canais analógicos e digitais
    num_canais_ana = size(dados_ana,2);
    num_canais_dig = size(dados_dig,2);
    
	%Número de amostras dos sinais considerando a fs original
    num_amostras_old = size(dados_ana,1);
    
    %Criando o vetor de tempo com a fs original                                                             
    dt_old = 1/fs_old; 
    t_old = [0:num_amostras_old-1]*dt_old;

    %Criando o vetor de tempo com a nova fs
    dt_new = 1/fs_new; 
    t_new = [0:dt_new:t_old(end)];

    %Interpolando os canais analógicos para a nova fs
    dados_ana_new = [];
    for k=1:num_canais_ana
        dados_ana_new = [dados_ana_new interp1(t_old,dados_ana(:,k),t_new)'];
    end
    
    %Número de amostras dos sinais considerando a nova fs
    num_amostras_new = size(dados_ana_new,1);
    
    %Interpolando os canais digitais para a nova fs
    %OBS: Importante para deixar o sinal de falta na mesma base de tempo
    dados_dig_new = [];
    for k=1:num_canais_dig
        dados_dig_new = [dados_dig_new interp1(t_old,dados_dig(:,k),t_new)'];
    end

    %Projetando o filtro PB e adequando a sua fc 
    [zerosNormPB,polosNormPB,ganhoNormPB] = buttap(ordemPB);
    [numNormPB,denNormPB]=zp2tf(zerosNormPB,polosNormPB,ganhoNormPB);
    [numPB,denPB]=lp2lp(numNormPB,denNormPB,2*pi*fcPB);

    %Filtragem PB dos sinais analógicos
    dados_ana_new_PB = [];
    for k=1:num_canais_ana
        dados_ana_new_PB = [dados_ana_new_PB lsim(tf(numPB,denPB),dados_ana_new(:,k),t_new);];
    end

    %Filtragem PB dos sinais digitais
    %OBS: Importante para deixar o sinal de falta na mesma base de tempo
    dados_dig_new_PB = [];
    for k=1:num_canais_dig
        dados_dig_new_PB = [dados_dig_new_PB lsim(tf(numPB,denPB),dados_dig_new(:,k),t_new);];
    end
    
    %Projetando o filtro PA
    Wn = fcPA/(fs_new/2);                       % Normalized cutoff frequency 
    [numPA,denPA] = butter(ordemPA,Wn,'high');  % Butterworth filter

    %Filtragem PA dos sinais analógicos
    dados_ana_TW = [];
    for k=1:num_canais_ana
        dados_ana_TW = [dados_ana_TW (Ganho/Vnom)*filter(numPA,denPA,dados_ana_new_PB(:,k))];
    end

    %Filtragem PA dos sinais analógicos    
    %OBS: Importante para deixar o sinal de falta na mesma base de tempo
    dados_dig_TW = [];
    for k=1:num_canais_dig
        dados_dig_TW = [dados_dig_TW (Ganho/Vnom)*filter(numPA,denPA,dados_dig_new_PB(:,k))];
    end   
    
    %Normalizando os canais analógicos
    for k=1:num_amostras_new
        for l=1:num_canais_ana
            if dados_ana_TW(k,l)>1
                dados_ana_TW(k,l)=1;
            elseif dados_ana_TW(k,l)<-1
                dados_ana_TW(k,l)=-1;
            end
        end
    end

    %Normalizando os canais digitais
    %OBS: Importante para deixar o sinal de falta na mesma base de tempo
    ind = find(abs(dados_dig_TW)>0);
    dados_dig_TW = zeros(num_amostras_new,1);
    dados_dig_TW(ind) = 1;
    
end



%***********************************************************%
%          Função de Leitura da Data e Horário Atual        %
%***********************************************************%
function data = fcn_DataHora(d)

    %Ajustando a informação do dia
    data.dia = num2str(day(d));
    if day(d) < 10
        data.dia = strcat('0',data.dia);
    end
    
    %Ajustando a informação do mês
    data.mes = num2str(month(d));
    if month(d) < 10
       data.mes = strcat('0',data.mes);
    end    
    
    %Pegando a informação do ano
    data.ano = num2str(year(d));

    %Ajustando a informação da hora
    data.hora = num2str(hour(d));
    if hour(d) < 10
        data.hora = strcat('0',data.hora);
    end
    
    %Ajustando a informação dos minutos
    data.minutos = num2str(minute(d));
    if minute(d) < 10
        data.minutos = strcat('0',data.minutos);
    end    
    
    %Ajustando a informação dos segundos
    data.segundos = num2str(floor(second(d)));
    if floor(second(d)) < 10
        data.segundos = strcat('0',data.segundos);
    end 
    
end



%***********************************************************%
%   Função de Preparção dos Dados para Escrita do COMTRADE  %
%***********************************************************%
function fcn_COMTRADE(LT,nome_SE,nome_RDP,CASO,data,dir)

    %Ajustando os canais analógicos, no caso dos dados secundários
    COMTRADE.PS = 'P';
    if COMTRADE.PS == 'S'
        for i = 1:LT.num_canais_ana
            LT.dados_ana(:,i) = LT.dados_ana(:,i)/(LT.RT_P(i)/LT.RT_S(i));
        end 
    end


    %Nome dos canais analógicos
    COMTRADE.nomes_canais_ana = [strcat("TWA_",LT.NomeLT) ...
                                 strcat("TWB_",LT.NomeLT) ...
                                 strcat("TWC_",LT.NomeLT) ];


    %Nome dos canais digitais                         
    COMTRADE.nomes_canais_dig = "FALTA";


    %Ajustando os canais analógicos e digitais para criação do registro COMTRADE                    
    COMTRADE.dados_ana = LT.dados_ana;
    COMTRADE.dados_dig = LT.dados_dig;


    %Ajustando as unidades dos canais analógicos e o status dos canais digitais
    COMTRADE.unidades_canais_ana = ["pu" "pu" "pu"];
    COMTRADE.status_canais_dig = 0;


    %Ajustando as variáveis com os RTPs e RTCs                 
    COMTRADE.RT_P = [LT.RTP_P , LT.RTC_P];
    COMTRADE.RT_S = [LT.RTP_S , LT.RTC_S];


    %Ajustando demais parâmetros do COMTRADE
    COMTRADE.versao = '1999';                 
    COMTRADE.fs = LT.fs;


    %Ajustando a data e o horário do registro COMTRADE
    COMTRADE.dia = data.dia;
    COMTRADE.mes = data.mes;
    COMTRADE.ano = data.ano;
    COMTRADE.hora = data.hora;
    COMTRADE.minutos = data.minutos;
    COMTRADE.segundos = data.segundos;


    %Nome do registro COMTRADE, do RDP e da SE
    CASO.DataHora = strcat(data.ano(3:4),data.mes,data.dia,'_',data.hora,'h',data.minutos,'min');
    CASO.SE = nome_SE;
    CASO.RDP = nome_RDP;
    nome_COMTRADE = strcat(CASO.DataHora,',',...
                           CASO.SE,',',...
                           CASO.RDP,',',...
                           strcat("TW_",CASO.IDC),',',...
                           CASO.IDF,',',...
                           CASO.TI,',',...
                           CASO.D_perc,',',...
                           CASO.D_m,',',...
                           CASO.R1,',',...
                           CASO.R2,',',...
                           CASO.CTAU,',',...
                           CASO.ANGI,',',...
                           CASO.DUR);
    COMTRADE.nome = nome_COMTRADE;
    COMTRADE.RDP = nome_RDP;
    COMTRADE.SE = nome_SE;

    %Criando as pastas
    dir = fullfile(dir,nome_SE,strcat("ATP_",nome_SE),strcat(nome_RDP,"_TW"));    
    if ~exist(dir, 'dir')
        mkdir(dir);
    end    

    %Escrevendo o COMTRADE binário
    fcn_comtrade_bin(COMTRADE,dir);
    
end



%***********************************************************%
%          Função de Escrita do Registro COMTRADE           %
%***********************************************************%
function fcn_comtrade_bin(COMTRADE,dir)

    dir_orig = pwd;
    cd(dir);

    %=====================================================================%
    %            PREPARANDO OS DADOS PARA A ESCRITA DO COMTRADE           %
    %=====================================================================%
    %Normalizando os dados analógicos 
    %OBS: essa partes está igual ao código do Marco
    [L C] = size(COMTRADE.dados_ana);
    if L > C
        COMTRADE.dados_ana = COMTRADE.dados_ana';
    end
    a = max([L C]);
    L = min([L C]);
    C = a;
    ganho = max(COMTRADE.dados_ana');
    minimo = min(COMTRADE.dados_ana');
    ganho = max(abs(ganho),abs(minimo));
    [a,t] = min(ganho);
    while a == 0
        ganho(t) = 1;
        [a,t] = min(ganho);
    end
    ganho = ganho / 32767;
    COMTRADE.dados_ana = (diag(1 ./ ganho) * COMTRADE.dados_ana)';

    %Número de amostras
    num_amostras = size(COMTRADE.dados_ana,1);

    %Ajustando os dados analógicos
    n = [1:num_amostras]';
    t = [0:num_amostras-1]'*1E6/COMTRADE.fs;
    COMTRADE.dados_ana = [n t COMTRADE.dados_ana];

    %Número de canais anlógicos e digitais
    num_canais_ana = size(COMTRADE.dados_ana,2)-2;
    num_canais_dig = size(COMTRADE.dados_dig,2);

    %Ajustando os canais digitais
    num_bits_canais_dig = ceil(num_canais_dig/16)*16;
    num_2bytes_canais_dig = ceil(num_bits_canais_dig/16);
    COMTRADE.dados_dig = [COMTRADE.dados_dig ...
                          zeros(num_amostras,num_bits_canais_dig-num_canais_dig)];

    %Transformando os blocos de 2 bytes de canais digitais em inteiros
    for k=1:num_amostras
        for l=1:num_2bytes_canais_dig
            int_canal_dig(k,l) = 0;
            m = 16;
            for n=16:-1:1
                int_canal_dig(k,l) = int_canal_dig(k,l) + ...
                                     COMTRADE.dados_dig(k,l*n)*2^(m-1);
                m = m-1;
            end
        end
    end    

    %=====================================================================%
    %                      ESCREVENDO O ARQUIVO DAT                       %
    %=====================================================================%
    %Abrindo a escrita do arquivo
    fid = fopen(strcat(COMTRADE.nome,'.dat'),'w');    

    %Escrevendo os dados em binário
    for j=1:num_amostras    
        %Número da amostra j
        fwrite(fid,COMTRADE.dados_ana(j,1),'int32');

        %Instante da amostra j
        fwrite(fid,COMTRADE.dados_ana(j,2),'int32');

        %Dados dos canais analógicos na amostra j
        for k=1:num_canais_ana
            fwrite(fid,COMTRADE.dados_ana(j,k+2),'int16');
        end

        %Dados dos canais digitais na amostra j
        for k=1:num_2bytes_canais_dig
            fwrite(fid,int_canal_dig(j,k),'int16');        
        end
    end       

    %Fechando a escrita do arquivo
    fclose(fid);


    %=====================================================================%
    %                     ESCREVENDO O ARQUIVO CFG                        %
    %=====================================================================%
    %Abrindo a escrita do arquivo
    fid = fopen(strcat(COMTRADE.nome,'.cfg'),'w');

    %Subestacao,RDP e versão
    fprintf(fid,'SE %s,%s_TW,%s\r\n',...
            COMTRADE.SE,...
            COMTRADE.RDP,...
            COMTRADE.versao); 

    %Número de canais
    fprintf(fid,'%d,%dA,%dD\r\n',...
            num_canais_ana+num_canais_dig,...
            num_canais_ana,...
            num_canais_dig);

    %Informações dos canais analógicos
    for i=1:num_canais_ana   
        fprintf(fid,'%d,%s,,,%s,%G,0,0,-32767,32767,%.2f,%.1f,%s\r\n',...
                i,...
                COMTRADE.nomes_canais_ana(i),...
                COMTRADE.unidades_canais_ana(i),...
                ganho(i),...
                COMTRADE.RT_P(i),...
                COMTRADE.RT_S(i),...
                COMTRADE.PS);
    end

    %Informações dos canais digitais
    for i=1:num_canais_dig
        fprintf(fid,'%d,%s,,,%d\r\n',...
                i,...
                COMTRADE.nomes_canais_dig(i),...
                COMTRADE.status_canais_dig(i));
    end

    %Frequência da rede
    fprintf(fid,'60\r\n'); 

    %Número de taxas de amostragem
    fprintf(fid,'1\r\n'); 

    %Taxas de amostragem e número de amostras
    fprintf(fid,'%d,%d\r\n',...
            COMTRADE.fs,...
            num_amostras);

    %Data e horário de início do registro
    fprintf(fid,'%s/%s/%s,%s:%s:%s.000000\r\n',...
            COMTRADE.mes,...
            COMTRADE.dia,...
            COMTRADE.ano,...
            COMTRADE.hora,...
            COMTRADE.minutos,...
            COMTRADE.segundos);

    %Data e horário do fim do registro
    fprintf(fid,'%s/%s/%s,%s:%s:%s.200000\r\n',...
            COMTRADE.mes,...
            COMTRADE.dia,...
            COMTRADE.ano,...
            COMTRADE.hora,...
            COMTRADE.minutos,...
            COMTRADE.segundos);

    %Tipo do arquivo .dat
    fprintf(fid,'BINARY\r\n');

    %Argumento padrão
    fprintf(fid,'1');

    %Fechando a escrita do arquivo
    fclose(fid);

    cd(dir_orig);
    
end
