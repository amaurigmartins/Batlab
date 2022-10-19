function [nodes,dist] = getNodeNames(app,nodeidx)

fpath=fileparts(app.TemplateATPfileatpEditField.Value);
linecirc=app.LineCircuitDropDown.Value;
fname=[linecirc '.mat'];

load(fullfile(fpath,fname));

tmpnod=node_names(nodeidx,1);
if ~isempty(tmpnod)
    for k=1:length(tmpnod)
        nodes{k}=char(tmpnod{k});
    end
    
    dist=cell2mat(node_names(nodeidx,2));
    
else
    nodes='NULL';
    dist = 0;
    f = msgbox('Could not find any suitable node names. ','You lose, fella!','error');
end

end

