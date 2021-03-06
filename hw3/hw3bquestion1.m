clc; clear;

% read in data
bcpTable = readtable('bcp.xlsx');

allEverythingTable = table2array(bcpTable(:, 2:33));
theRorNtable = table2array(bcpTable(:, 1));

[idx,C,sse] = kmeans(allEverythingTable,4);

s = silhouette(allEverythingTable, idx);

sum1 = 0;
count1 = 0;

sum2 = 0;
count2 = 0;

sum3 = 0;
count3 = 0;

sum4 = 0;
count4 = 0;

sumAll = 0;
countAll = 0;

for i = 1:198
    if isnan(idx(i))
    else
        sumAll = sumAll + s(i);
        countAll = countAll + 1;
    end
    
    if idx(i) == 1
        sum1 = sum1 + s(i);
        count1 = count1 + 1;
    elseif idx(i) == 2
        sum2 = sum2 + s(i);
        count2 = count2 + 1;
    elseif idx(i) == 3
        sum3 = sum3 + s(i);
        count3 = count3 + 1;
    elseif idx(i) == 4
        sum4 = sum4 + s(i);
        count4 = count4 + 1;
    end
end

% get main cluster value of each cluster

Rcount1 = 0;
Ncount1 = 0;

Rcount2 = 0;
Ncount2 = 0;

Rcount3 = 0;
Ncount3 = 0;

Rcount4 = 0;
Ncount4 = 0;

for i = 1:198
    
    if idx(i) == 1
        if theRorNtable{i} == 'R'
            Rcount1 = Rcount1 + 1;     
        elseif theRorNtable{i} == 'N'
            Ncount1 = Ncount1 + 1;
        end
    elseif idx(i) == 2
        if theRorNtable{i} == 'R'
            Rcount2 = Rcount2 + 1;     
        elseif theRorNtable{i} == 'N'
            Ncount2 = Ncount2 + 1;
        end
    elseif idx(i) == 3
        if theRorNtable{i} == 'R'
            Rcount3 = Rcount3 + 1;     
        elseif theRorNtable{i} == 'N'
            Ncount3 = Ncount3 + 1;
        end
    elseif idx(i) == 4
        if theRorNtable{i} == 'R'
            Rcount4 = Rcount4 + 1;     
        elseif theRorNtable{i} == 'N'
            Ncount4 = Ncount4 + 1;
        end
    end
end

% classValue1 = '';
% classValue2 = '';
% classValue3 = '';
% classValue4 = '';

if Rcount1 >= Ncount1
    classValue1 = 'R';
else
    classValue1 = 'N';
end

if Rcount2 >= Ncount2
    classValue2 = 'R';
else
    classValue2 = 'N';
end

if Rcount3 >= Ncount3
    classValue3 = 'R';
else
    classValue3 = 'N';
end

if Rcount4 >= Ncount4
    classValue4 = 'R';
else
    classValue4 = 'N';
end

fprintf('\nCluster 1 w/ SSE = %f8 \n', sse(1)); 
fprintf('Cluster 1 average Silhouette coefficient: %f\n',sum1/count1);
fprintf('Cluster R Values: %i\n',Rcount1);
fprintf('Cluster N Values: %i\n',Ncount1);
fprintf('Value for Cluster 1: %s\n\n',classValue1);
fprintf('Cluster 1 Center: ');
disp(C(1,:));

fprintf('\n\nCluster 2 w/ SSE = %f8 \n', sse(2)); 
fprintf('Cluster 2 average Silhouette coefficient: %f\n',sum2/count2);
fprintf('Cluster R Values: %i\n',Rcount2);
fprintf('Cluster N Values: %i\n',Ncount2);
fprintf('Value for Cluster 1: %s\n\n',classValue2);
fprintf('Cluster 2 Center: ');
disp(C(2,:));

fprintf('\n\nCluster 3 w/ SSE = %f8 \n', sse(3)); 
fprintf('Cluster 3 average Silhouette coefficient: %f\n',sum3/count3);
fprintf('Cluster R Values: %i\n',Rcount3);
fprintf('Cluster N Values: %i\n',Ncount3);
fprintf('Value for Cluster 1: %s\n\n',classValue3);
fprintf('Cluster 3 Center: ');
disp(C(3,:));

fprintf('\nCluster 4 w/ SSE = %f8 \n', sse(4));
fprintf('Cluster 4 average Silhouette coefficient: %f\n',sum4/count4);
fprintf('Cluster R Values: %i\n',Rcount4);
fprintf('Cluster N Values: %i\n',Ncount4);
fprintf('Value for Cluster 1: %s\n\n',classValue4);
fprintf('Cluster 4 Center: ');
disp(C(4,:));
TOTAL = sse(1) + sse(2) + sse(3) + sse(4);

fprintf('\nTotal SSE for all clusters: %f\n',TOTAL);

fprintf('Silhoette Coefficient for all Clusters: %f',sumAll/countAll);
silhouette(allEverythingTable, idx)
hold on;

classify = []

classes = [classValue1, classValue2, classValue3, classValue4];

for i = 1:198
    minDist = norm(allEverythingTable(1,:) - C(1,:));
    tempClass = classes(1);
    for j = 1:4
        tempDist = norm(allEverythingTable(i,:) - C(j,:));
        if (tempDist < minDist)
            minDist = tempDist;
            tempClass = classes(j);
        end
    end
    classify = [classify, tempClass];
end

TP = 0;
FP = 0;
TN = 0;
FN = 0;s

for b = 1:198
    if theRorNtable{b} == 'N' && classify(b) == 'N'
        TP = TP + 1;
    end
    if theRorNtable{b} == 'R' && classify(b) == 'N'
        FP = FP + 1;
    end
    if theRorNtable{b} == 'R' && classify(b) == 'R'
        TN = TN + 1;
    end
    if theRorNtable{b} == 'N' && classify(b) == 'R'
        FN = FN + 1;
    end
end

fprintf('True Positives: %i\n',TP);
fprintf('False Positives: %i\n',FP);
fprintf('True Negative: %i\n',TP);
fprintf('True Negative: %i\n',TP);
prec = TP/(TP+FP);
accu = (TP+TN)/(TP+TN+FP+FN);
reca = TP/(TP+FN);
fprintf('\nPrec: %f\n', prec*100);
fprintf('\nAcc: %f\n', accu*100);
fprintf('\nRecall: %f\n', reca*100);



