function out = findInStruct(struc,what)

n=length(struc);
out=[];
for k=1:n
    if startsWith(struc(k).param,what)
        out=k;
    end
end

end