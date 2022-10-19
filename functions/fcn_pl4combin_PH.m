function fcn_pl4combin_PH(ArqMAT,CASO,dir,struct_data_hora)

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
    fcn_COMTRADE(LEC_SIL_C1,LEC_SIL_C2,"LEC","LEC_SIL",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_LEC_C1,SIL_LEC_C2,"SIL","SIL_LEC",CASO,data_hora,dir);
    fcn_COMTRADE(SIL_ORX_C1,SIL_ORX_C2,"SIL","SIL_ORX",CASO,data_hora,dir);
    fcn_COMTRADE(ORX_SIL_C1,ORX_SIL_C2,"ORX","ORX_SIL",CASO,data_hora,dir);

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
                          strcat("vTp",CIRCUITO,"c"); ...
                          strcat("iTc",CIRCUITO,"a"); ...
                          strcat("iTc",CIRCUITO,"b"); ...
                          strcat("iTc",CIRCUITO,"c"); ...
                          strcat("mDl",CIRCUITO,"a"); ...
                          strcat("mDl",CIRCUITO,"b"); ...
                          strcat("mDl",CIRCUITO,"c"); ...
                          strcat("mDb",CIRCUITO,"a"); ...
                          strcat("mDb",CIRCUITO,"b"); ...
                          strcat("mDb",CIRCUITO,"c"); ...
                          strcat("mGp",CIRCUITO,"a"); ...
                          strcat("mGp",CIRCUITO,"b"); ...
                          strcat("mGp",CIRCUITO,"c") ];

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

        % Correntes
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(4))
            ia = ArqMAT.(NomesVariaveisPL4{k});
        end    
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(5))
            ib = ArqMAT.(NomesVariaveisPL4{k});
        end    
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(6))
            ic = ArqMAT.(NomesVariaveisPL4{k});
        end    

        % Canais Digitais
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(7))
            dig_DLa = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(8))
            dig_DLb = ArqMAT.(NomesVariaveisPL4{k});
        end        
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(9))
            dig_DLc = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(10))
            dig_DBa = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(11))
            dig_DBb = ArqMAT.(NomesVariaveisPL4{k});
        end        
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(12))
            dig_DBc = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(13))
            dig_GPa = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(14))
            dig_GPb = ArqMAT.(NomesVariaveisPL4{k});
        end   
        if strfind(NomesVariaveisPL4{k},VariaveisDesejadas(15))
            dig_GPc = ArqMAT.(NomesVariaveisPL4{k});
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

    %Calculando as tensões e correntes de sequência zero
    v0 = (1/3)*(va+vb+vc);
    i0 = (1/3)*(ia+ib+ic);

    %Criando a variável com os dados dos canais analógicos
    dados_ana=[va vb vc 3*v0 ia ib ic 3*i0];

    %Criando a variável com os dados dos canais digitais
    dados_dig = [falta ...
                 dig_DLa dig_DLb dig_DLc ...
                 dig_DBa dig_DBb dig_DBc ...
                 dig_GPa dig_GPb dig_GPc];

    %Removendo o período de incialização dos sinais         
    T_MAX_INICIALIZACAO = 450e-3;
    IND_T_MAX_INICIALIZACAO = find(t<T_MAX_INICIALIZACAO,1,'last');

    %Criando a estrutura LT que será retornanda na função
    LT.num_canais_ana = size(dados_ana,2);
    LT.num_canais_dig = size(dados_dig,2);
    LT.dados_ana = dados_ana(IND_T_MAX_INICIALIZACAO:end,:);
    LT.dados_dig = dados_dig(IND_T_MAX_INICIALIZACAO:end,:);
    LT.fs = 1/(t(2)-t(1));
    
    %Reamostrando os sinais analógicos e digitais
    [LT.dados_ana, LT.dados_dig, LT.fs]=fcn_ReamostraSinais(LT.dados_ana,LT.dados_dig,LT.fs);    

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
%               Função de Reamostragem dos Sinais           %
%***********************************************************%
function [dados_ana_sampled, dados_dig_sampled, fs]=fcn_ReamostraSinais(dados_ana,dados_dig,fs_ATP)

    %--- Variáveis Auxiliares ---%    
    dt_ATP = 1/fs_ATP;
    N = 256;
    f = 60;
    fs = N*f;
    num_canais_ana = size(dados_ana,2);
    num_canais_dig = size(dados_dig,2);
    
    %--- Dados do Filtro Anti-aliasing ---%
    fc = 0.8*(fs/2);
    ordem = 3;    

    %--- Filtragem dos Sinais ---%
    for k=1:num_canais_ana
        dados_ana_filt(:,k) = fcn_FiltAna(dados_ana(:,k),dt_ATP,fc,ordem);
    end

    %--- Reamostragem dos Sinais Analógicos ---%
    dados_ana_sampled = [];
    for k=1:num_canais_ana
        dados_ana_sampled = [dados_ana_sampled fcn_Sampling(dados_ana_filt(:,k),N,dt_ATP,"ANA")'];
    end

    %--- Reamostragem dos Sinais Digitais ---%
    dados_dig_sampled = [];
    for k=1:num_canais_dig
        dados_dig_sampled = [dados_dig_sampled fcn_Sampling(dados_dig(:,k),N,dt_ATP,"DIG")'];
    end
    
end



%***********************************************************%
%              Função de Filtragem Anti-Aliasing            %
%***********************************************************%
function sigf=fcn_FiltAna(sig,dt,fc,ordem)

    %--------------------------------------------------%
    % Argumentos:                                      % 
    %     - sig:   Sinal vindo do ATP que              %
    %              será filtrado e reamostrado         %
    %     - dt:    Passo de cálculo utilizado          %
    %              na simulação do ATP (valor          %
    %              ajustado na aba SETTINGS)           %
    %     - fc:    (Opcicional) frequência de corte    %
    %              do filtro anti-alaising             %
    %     - ordem: (Opcional) ordem do filtro          %
    %              anti-alaising                       %
    %--------------------------------------------------%

    %-----------------------------------%
    %        Argumentos de Entrada      %
    %-----------------------------------%
    if nargin==2
        %Parâmetros default do filtro anti-aliasing
        fc=120;
        ordem=3;
    end

    %-----------------------------------%
    %        Filtragem Analógica        %
    %-----------------------------------%
    %Filtro Anti-Aliasing
    [z,p,k]=buttap(ordem);
    [num,den]=zp2tf(z,p,k);
    [numwp,denwp]=lp2lp(num,den,2*pi*fc);
    h=tf(numwp,denwp);

    %tempo "contínuo"
    t=[0:length(sig)-1]*dt;

    %sinal filtrado
    sigf=lsim(h,sig,t);
    
end



%***********************************************************%
%               Função de Amostragem dos Sinais             %
%***********************************************************%
function sigd=fcn_Sampling(sigf,N,dt,tipo)

    %--------------------------------------------------%
    % Argumentos:                                      % 
    %     - sig:   Sinal que será filtrado             %
    %              e reamostrado                       %
    %     - N:     Taxa de amostragem (número          %
    %              de amostras por ciclo do 60 Hz)     %
    %--------------------------------------------------%

    
    %-----------------------------------%
    %       Variáveis auxiliares        %
    %-----------------------------------%
    f=60;     %frequência nominal
    fs=N*f;   %frequência de amostragem
    dtd=1/fs; %passo de amostragem
    td=0;     %tempo discretizado
    n=1;      %índice da amostra
    t=[0:length(sigf)-1]*dt; %tempo contínuo
    

    %-----------------------------------%
    %         Laço de Cálculo           %
    %-----------------------------------%
    sigd(1)=sigf(1);
    for k=2:length(sigf)
        if (t(k)+dt)>(td+dtd)
            td=td+dtd;            
            if strcmp(tipo,"ANA")
                a=(sigf(k)-sigf(k-1))/dt;
                sigd(n)=a*(td-t(k))+sigf(k);
            elseif strcmp(tipo,"DIG")
                sigd(n)=sigf(k);
            end
            n=n+1;            
        end    
    end
    
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
function fcn_COMTRADE(LT1,LT2,nome_SE,nome_RDP,CASO,data,dir)

    %Ajustando os canais analógicos, no caso dos dados secundários
    COMTRADE.PS = 'P';
    if COMTRADE.PS == 'S'
        for i = 1:LT1.num_canais_ana
            LT1.dados_ana(:,i) = LT1.dados_ana(:,i)/(LT1.RT_P(i)/LT1.RT_S(i));
        end

        for i = 1:LT2.num_canais_ana
            LT2.dados_ana(:,i) = LT2.dados_ana(:,i)/(LT2.RT_P(i)/LT2.RT_S(i));
        end    
    end


    %Nome dos canais analógicos
    COMTRADE.nomes_canais_ana = [strcat("va_",LT1.NomeLT) ...
                                 strcat("vb_",LT1.NomeLT) ...
                                 strcat("vc_",LT1.NomeLT) ...
                                 strcat("3v0_",LT1.NomeLT) ...
                                 strcat("ia_",LT1.NomeLT) ...
                                 strcat("ib_",LT1.NomeLT) ...
                                 strcat("ic_",LT1.NomeLT) ...
                                 strcat("3i0_",LT1.NomeLT) ...
                                 strcat("va_",LT2.NomeLT) ...
                                 strcat("vb_",LT2.NomeLT) ...
                                 strcat("vc_",LT2.NomeLT) ...
                                 strcat("3v0_",LT2.NomeLT) ...
                                 strcat("ia_",LT2.NomeLT) ...
                                 strcat("ib_",LT2.NomeLT) ...
                                 strcat("ic_",LT2.NomeLT) ...
                                 strcat("3i0_",LT2.NomeLT)];


    %Nome dos canais digitais                         
    COMTRADE.nomes_canais_dig = ["FALTA" ...
                                 strcat("DJLA_",LT1.NomeLT) ...
                                 strcat("DJLB_",LT1.NomeLT) ...
                                 strcat("DJLC_",LT1.NomeLT) ...
                                 strcat("DJBA_",LT1.NomeLT) ...
                                 strcat("DJBB_",LT1.NomeLT) ...
                                 strcat("DJBC_",LT1.NomeLT) ...
                                 strcat("GAPA_",LT1.NomeLT) ...
                                 strcat("GAPB_",LT1.NomeLT) ...
                                 strcat("GAPC_",LT1.NomeLT) ...
                                 strcat("DJLA_",LT2.NomeLT) ...
                                 strcat("DJLB_",LT2.NomeLT) ...
                                 strcat("DJLC_",LT2.NomeLT) ...
                                 strcat("DJBA_",LT2.NomeLT) ...
                                 strcat("DJBB_",LT2.NomeLT) ...
                                 strcat("DJBC_",LT2.NomeLT) ...
                                 strcat("GAPA_",LT2.NomeLT) ...
                                 strcat("GAPB_",LT2.NomeLT) ...
                                 strcat("GAPC_",LT2.NomeLT)];


    %Ajustando os canais analógicos e digitais para criação do registro COMTRADE                    
    COMTRADE.dados_ana = [LT1.dados_ana LT2.dados_ana];
    COMTRADE.dados_dig = [LT1.dados_dig(:,1) LT1.dados_dig(:,2:end) LT2.dados_dig(:,2:end)];


    %Ajustando as unidades dos canais analógicos e o status dos canais digitais
    COMTRADE.unidades_canais_ana = ["V" "V" "V" "V" "A" "A" "A" "A" ...
                                    "V" "V" "V" "V" "A" "A" "A" "A"];
    COMTRADE.status_canais_dig = [0 1 1 1 0 0 0 0 0 0 ...
                                  0 1 1 1 0 0 0 0 0 0 ];


    %Ajustando as variáveis com os RTPs e RTCs                 
    COMTRADE.RT_P = [LT1.RTP_P , LT1.RTC_P , LT2.RTP_P , LT2.RTC_P];
    COMTRADE.RT_S = [LT1.RTP_S , LT1.RTC_S , LT2.RTP_S , LT2.RTC_S];


    %Ajustando demais parâmetros do COMTRADE
    COMTRADE.versao = '1999';                 
    COMTRADE.fs = LT1.fs;


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
                           strcat("RDP_",CASO.IDC),',',...
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
    dir = fullfile(dir,nome_SE,strcat("ATP_",nome_SE),nome_RDP);    
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
    COMTRADE.dados_dig = [COMTRADE.dados_dig zeros(num_amostras,num_bits_canais_dig-num_canais_dig)];

    %Transformando os blocos de 2 bytes de canais digitais em inteiros
    int_canal_dig = zeros(1,num_amostras);
    for k=1:num_amostras
        vet_bits = flip(COMTRADE.dados_dig(k,:));
        b = num_bits_canais_dig-1;
        for n=1:num_bits_canais_dig
            int_canal_dig(k) = int_canal_dig(k) + vet_bits(n)*2^b;
            b = b-1;
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
        if num_bits_canais_dig==16
            fwrite(fid,int_canal_dig(j),'int16');        
        elseif num_bits_canais_dig==32
            fwrite(fid,int_canal_dig(j),'int32');
        elseif num_bits_canais_dig==64
            fwrite(fid,int_canal_dig(j),'int64');
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
    fprintf(fid,'SE %s,%s,%s\r\n',...
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
