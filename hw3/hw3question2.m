clc;clear;

% read in data
bcpTable = readtable('bcp.xlsx');

% split data into training (2/3rd) and Test (1/3rd)
trainDataTable = table2array(bcpTable(1:132, 4:35));
testDataTable = table2array(bcpTable(133:198, 4:35));
trainClassTable = table2array(bcpTable(1:132, 3));
testClassTable = table2array(bcpTable(133:198, 3));
allDataTable = table2array(bcpTable(1:198, 4:35));
allClassTable = table2array(bcpTable(1:198, 3));


% get all the coefficients based on correlation coefficient
% of individual value as it corresponds to the class table (2/3rd train)
coeffs = [];
for i = 1:32
   temp = corrcoef(trainDataTable(:,i), trainClassTable, 'rows','complete');
   coeffs = [coeffs, temp(2,1)];
end
disp('Calculated Coefficients for each row');
disp(coeffs);



% now predict based off of the above values
answersAll = [];
for i = 1:length(allDataTable)
    allData = allDataTable(i,:);
    allData(isnan(allData))=0;
    tempMultArrayAll = allData.*coeffs;
    answersAll = [answersAll, sum(tempMultArrayAll)];
end
disp('Calculated Test Data Values (1/3rd of the Data Set)');
disp(answersAll);
disp('Dive by 100 and multiply be Negative 1 to normalize the time in years data');
answersAll = answersAll/-100;
disp(answersAll);




% now predict based off of the above values
answersTest = [];
for i = 1:length(testDataTable)
    testData = testDataTable(i,:);
    testData(isnan(testData))=0;
    tempMultArrayTest = testData.*coeffs;
    answersTest = [answersTest, sum(tempMultArrayTest)];
end
disp('Calculated Test Data Values (1/3rd of the Data Set)');
disp(answersTest);
disp('Dive by 100 and multiply be Negative 1 to normalize the time in years data');
answersTest = answersTest/-100;
disp(answersTest);


% now predict based off of the above values
answersTrain = [];
for i = 1:length(trainDataTable)
    trainData = trainDataTable(i,:);
    trainData(isnan(trainData))=0;
    tempMultArrayTrain = trainData.*coeffs;
    answersTrain = [answersTrain, sum(tempMultArrayTrain)];
end
disp('Calculated Test Data Values (1/3rd of the Data Set)');
disp(answersTrain);
disp('Dive by 100 and multiply be Negative 1 to normalize the time in years data');
answersTrain = answersTrain/-100;
disp(answersTrain);

diffsTrain = [];
diffsSquaredTrain = [];
for i = 1:132
    diffTrain = (trainClassTable(i) - answersTrain(i));
    diffsTrain = [diffsTrain, diffTrain];
    diffsSquaredTrain = [ diffsSquaredTrain, diffTrain.^2 ];
end
disp('Get the difference between the regression value and the actual year value');
disp(diffsTrain);
disp('Average Error');
disp(mean(abs(diffsTrain)));

diffsTest = [];
diffsSquaredTest = [];
for i = 1:66
    diffTest = (testClassTable(i) - answersTest(i));
    diffsTest = [diffsTest, diffTest];
    diffsSquaredTest = [ diffsSquaredTest, diffTest.^2];
end
disp('Get the difference between the regression value and the actual year value');
disp(diffsTest);
disp('Average Error');
disp(mean(abs(diffsTest)));


%%%%%%%%%%%%%%%%%%%% Diffs All
diffsAll = [];
diffsSquaredAll = [];
for i = 1:198
    diffAll = (allClassTable(i) - answersAll(i));
    diffsAll = [diffsAll, diffAll];
    diffsSquaredAll = [ diffsSquaredAll, diffAll.^2 ];
end
disp('Get the difference between the regression value and the actual year value');
disp(diffsAll);
disp('Average Error');
disp(mean(abs(diffsAll)));

disp('- - - - - - - - - - - - - - - - - - - -');
disp('TEST SET VALUES');
disp('Average Error');
disp(mean(abs(diffTest)));
disp('Mean Squared Error (MSE)');
testMSE = mean(diffsSquaredTest);
disp(testMSE);
disp('Square Root of MSE');
disp(sqrt(testMSE));

disp('- - - - - - - - - - - - - - - - - - - -');
disp('TRAINING SET VALUES');
disp('Average Error');
disp(mean(abs(diffsTrain)));
disp('Mean Squared Error (MSE)');
trainMSE = mean(diffsSquaredTrain);
disp(trainMSE);
disp('Square Root of MSE');
disp(sqrt(trainMSE));

disp('- - - - - - - - - - - - - - - - - - - -');
disp('All Data VALUES COMBINED');
disp('Average Error');
disp(mean(abs(diffsAll)));
disp('Mean Squared Error (MSE)');
allMSE = mean(diffsSquaredAll);
disp(allMSE);
disp('Square Root of MSE');
disp(sqrt(allMSE));



