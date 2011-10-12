% cu trash la 0
% before boot 
% percentPed =    0.3060
% percentNonPed =    0.1780

% after bootstraping 
% percentPed =     0.3320
% percentNonPed =       0.1340


load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;


pedTrain = ped_train_lrf(:,2:321);
nonPedTrain = garb_train_lrf(:,2:321);
nonPedBootTest = garb_bootstrap_lrf(:,2:321);

pedTest = ped_test_lrf(:,2:321);
nonPedTest = garb_test_lrf(:,2:321);

[SOL_init, B_init] = lrf_svm_compute( [pedTrain; nonPedTrain] );


% test on bostrap data
[missclassifiedData correctData] = testPhaseBoot( SOL_init, B_init, nonPedBootTest);

%  newDataLen = size(missclassifiedData,1)
newTraining = zeros(250,321);
for i=1:250 
     index = random('unid', 1000 ); % Pick the index at random.
     newTraining(i,:) = garb_bootstrap_lrf(index,:); % Add random point. 
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
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
  
end

    ylabel('Pedestrian detection rate');
    xlabel('Non-pedestrians detected as pedestrians') ;  

%  [percentPed, percentNonPed] = testPhase(0, SOL_init, B_init,pedTest, nonPedTest)
%  [percentPed, percentNonPed] = testPhase(0, SOL_boot, B_boot ,pedTest, nonPedTest)

 