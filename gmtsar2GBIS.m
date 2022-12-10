%% gmtsar2GBIS.m
% Loads two .grd file from GMTSAR 
% and outputs a mat file that can be used in GBIS for inversion
% Inputs must share the same grid.
%
% Optional - loads and saves uncertainties associated with velocities.
%
% Yao Yuan     2022-12-04

clc;clear;

load yangbi_unwrap_ll.xyz
M = yangbi_unwrap_ll;
yangbi_unwrap_ll=[];
xmin_1 = 99.9193;
xmax_1 = 99.9797;
xmin_2 = 25.6296;
xmax_2 = 25.6390;
index1 = find(M(:,1)>xmin_1&M(:,1)<xmax_1);
index2 = find(M(:,2)>xmin_2&M(:,2)<xmax_2);
index = intersect(index1,index2);
Lon = []; Lat = []; Phase = [];
for i=1:length(index)
    Lon(i,1) = M(index(i),1);
    Lat(i,1) = M(index(i),2);
    Phase(i,1) = M(index(i),3);
end
Inc = zeros(size(Lon,1),1)+2;
Heading = zeros(size(Lon,1),1)+2;
save('Data1.mat','Lon','Lat','Heading','Inc','Phase');

temp1 = isnan(Phase);

[m,n]=find(isnan(Phase));    % 找出NaN数据位置

temp2 = [Lon,Lat,Phase];

temp2(m,:)=[];
Lon = temp2(:,1);
Lat = temp2(:,2);
Phase = temp2(:,3);
Inc = zeros(size(Lon,1),1)+2;
Heading = zeros(size(Lon,1),1)+2;

save('Data2.mat','Lon','Lat','Heading','Inc','Phase');
