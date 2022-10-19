function [out] = findNodeDist(linecirc,path,name)
 fname=[linecirc '.mat'];
 load(fullfile(path,fname));
 
 idx=find(contains(cellstr(node_names(:,1)),name));

 out=cell2mat(node_names(idx,2));

 
end

