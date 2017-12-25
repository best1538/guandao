function out=cut_wave(data)
data=double(data);
[c,l]=wavedec (data,4,'db3');
a4=wrcoef('a',c,l,'db3',4);
d4=wrcoef('d',c,l,'db3',4);
d3=wrcoef('d',c,l,'db3',3);
d2=wrcoef('d',c,l,'db3',2);
d1=wrcoef('d',c,l,'db3',1);
out=d2+d3+d4;
end