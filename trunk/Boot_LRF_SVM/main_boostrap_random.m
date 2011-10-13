% cu trash la 0
% before boot 
% percentPed =    0.3060
% percentNonPed =    0.1780

% after bootstraping random
% percentPed =     0.3360        168
% percentNonPed =       0.1260   63

load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;


pedTrain = ped_train_lrf;
nonPedTrain = garb_train_lrf;
nonPedBootTest = garb_bootstrap_lrf(:,2:321);

pedTest = ped_test_lrf(:,2:321);
nonPedTest = garb_test_lrf(:,2:321);

[SOL_init, B_init] = lrf_svm_compute( pedTrain, nonPedTrain );

% test on bostrap data
[missclassifiedData correctData] = testPhaseBoot( SOL_init, B_init, nonPedBootTest);

newDataLen = size(missclassifiedData,1);
if( newDataLen <250)
    nonPedTrain = [nonPedTrain ; missclassifiedData(:,2:322) ]; 
    newTraining = zeros(249-newDataLen,321);
    for i=1:249-newDataLen
         index = random('unid', 249-newDataLen ); % Pick the index at random
         newTraining(i,:) = correctData(index,2:322); % Add random point 
    end
    nonPedTrain = [nonPedTrain ; newTraining ];
else
     newTraining = zeros(250,321);
    for i=1:250
         index = random('unid', 250 ); % Pick the index at random
         newTraining(i,:) = missclassifiedData(index,2:322); % Add random point 
    end
    nonPedTrain = [nonPedTrain ; newTraining ];
end

nonPedTrain = [ nonPedTrain; newTraining];  

[SOL_boot, B_boot] = lrf_svm_compute( pedTrain,nonPedTrain);

hold all; 
for i = -3.6 : 0.2: 4
[percentPed, percentNonPed] = testPhase(i, SOL_init, B_init,pedTest, nonPedTest);
  
    plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);

  [percentPed, percentNonPed] = testPhase(i, SOL_boot, B_boot ,pedTest, nonPedTest);
   plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
  
end

    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;  

 [percentPed, percentNonPed] = testPhase(0, SOL_init, B_init,pedTest, nonPedTest);
 [percentPed, percentNonPed] = testPhase(0, SOL_boot, B_boot ,pedTest, nonPedTest)

 