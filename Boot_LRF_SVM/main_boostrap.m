% before boot 
% percentPed =    0.3060
% percentNonPed =    0.1780
% 
% after boot = 150 iterations
% percentPed =    0.3400
% percentNonPed =    0.1480


load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;


pedTrain = ped_train_lrf;
nonPedTrain = garb_train_lrf;
nonPedBootTest = garb_bootstrap_lrf(:,2:321);

[SOL_init, B_init] = lrf_svm_compute( pedTrain,nonPedTrain);

% set for the algorithm
nrIteration = 150;
maxError= 20;
thresh = 0;


error = maxError + 1;

while nrIteration > 0 && error > maxError
[SOL, B] = lrf_svm_compute( pedTrain,nonPedTrain);
 
% test on bostrap data
 missclassifiedData = testPhaseBoot(thresh, SOL, B, [garb_train_lrf(:,2:321);nonPedBootTest]);
 
 nrIteration 
 
 newDataLen = max(size(missclassifiedData, 250));
 sortedData = sortrows(missclassifiedData,1);
 nonPedTrain = [nonPedTrain ; sortedData(1:newDataLen,2:322) ]; 
 error = size(missclassifiedData,1); % to update
 nrIteration = nrIteration - 1;
end

  pedTest = ped_test_lrf(:,2:321);
  nonPedTest = garb_test_lrf(:,2:321);
hold all; 
for i = -3.6 : 0.2: 4
  [percentPed, percentNonPed] = testPhase(i, SOL_init, B_init,pedTest, nonPedTest);
  
    plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);

  [percentPed, percentNonPed] = testPhase(i, SOL, B,pedTest, nonPedTest);
   plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
  
end


    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;   