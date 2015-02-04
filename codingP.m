clc;
clear;

ptable=[];
fid=fopen('TestBasis.b','r');
name=''; expo=[];radial=[];str='';
type=struct('orbital',str,'expo',expo,'gcc',radial);
element=struct('name',name,'type',type);
dollar_c=0;
typecount=0;
while dollar_c<2
    line=fgets(fid);
    
    if line(1)=='$'
        dollar_c=dollar_c+1;
        name=fgets(fid);
        numElem=1;
    elseif dollar_c==1 && length(line)~=1
        typecount=typecount+1;
        str=line(1);
       
        ntimes=line(5);
        
        expo=[];
        radial=[];
        for j=1:str2num(ntimes)
            fline=fgets(fid);
            fcell=textscan(fline,'%s');
            rex=str2double(fcell{1}(2));
            cof=str2double(fcell{1}(3));
            expo=[expo rex];
            radial=[radial cof];
        end
        type(typecount).orbital=str;
        type(typecount).expo=expo;
        type(typecount).gcc=radial;
        element(numElem).type=type;
        element(numElem).name=name;
    elseif dollar_c==1 && length(line)==1
        name=fgets(fid);
        numElem=numElem+1;
    end
end


