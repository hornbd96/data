clc; clear;

disp('HW3 Question2 Part B');

% read in data
bcpTable = readtable('bcp.xlsx');

% split data into training (2/3rd) and Test (1/3rd)
trainDataTable = table2array(bcpTable(1:132, 4:35));
testDataTable = table2array(bcpTable(133:198, 4:35));
trainClassTable = table2array(bcpTable(1:132, 3));
testClassTable = table2array(bcpTable(133:198, 3));
allDataTable = table2array(bcpTable(1:198, 4:35));
allClassTable = table2array(bcpTable(1:198, 3));

coeffs = [];
for i = 1:32
   temp = corrcoef(trainDataTable(:,i), trainClassTable, 'rows','complete');
   coeffs = [coeffs, temp(2,1)];
end
% disp('Calculated Coefficients for each row');
% disp(coeffs);
coeffs = abs(coeffs);
disp('Best Coefficient Found');
best = max(coeffs)
disp('Best Coefficient Index in Table');
bestIndex = find(coeffs == best)

sortDataSetOnAttribute = sortrows(allDataTable, bestIndex);
dataSetLen = length(sortDataSetOnAttribute);
part1 = sortDataSetOnAttribute(1:ceil(dataSetLen/2), :);
part2 = sortDataSetOnAttribute(ceil(dataSetLen)/2+1:end,:);

