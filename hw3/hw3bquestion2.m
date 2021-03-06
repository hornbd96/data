clc; clear;

% read in data
bcpTable = readtable('bothwine.xls');
allEverythingTable = table2array(bcpTable(:, 1:12));


for clusts = 3:14
    fprintf('K Means Clustering with %i clusters\n',clusts);
    averageOfAverages = 0;
    
    for run = 1:3
        fprintf('Run %i with %i clusters\n',run, clusts);
        
        [idx,c,sse] = kmeans(allEverythingTable,clusts,'MaxIter',10000,...
    'Display','final','Replicates',10);

        tempSum = 0;
        for i = 1:length(sse)
            tempSum = tempSum + sse(i);
            fprintf('Cluster: %i | SSE: %f\n',i, sse(i));
        end
        avgSse = tempSum/length(sse);
         fprintf('The average SSE/cluster of K Mean w/ %i clusters = %f\n\n', length(sse),avgSse);
        averageOfAverages =  averageOfAverages + avgSse;
    end
    
    fprintf('K Means Clustering with %i clusters Average of Averages = %f\n\n\n',clusts, averageOfAverages/3);
    
end