% cu trash la 0
% before boot 
% percentPed =    0.3060
% percentNonPed =    0.1780

% after bootstraping 
% percentPed =     0.3320  166
% percentNonPed =       0.1340  67



load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;


pedTrain = ped_train_lrf;
nonPedTrain = garb_train_lrf;
nonPedBootTest = garb_bootstrap_lrf(:,2:321);

pedTest = ped_test_lrf(:,2:321);
nonPedTest = garb_test_lrf(:,2:321);

[SOL_init, B_init] = lrf_svm_compute( pedTrain, nonPedTrain );

save('..\lrfSVM.mat','SOL_init', 'B_init');

% test on bostrap data
[missclassifiedData correctData] = testPhaseBoot( SOL_init, B_init, nonPedBootTest);
 
%  size(correctData)
newDataLen = size(missclassifiedData,1)

 if( newDataLen <250)
    nonPedTrain = [nonPedTrain ; missclassifiedData(:,2:322) ]; 
    sortedData = sortrows(correctData,1);
    nonPedTrain = [nonPedTrain ; sortedData(1:249- newDataLen,2:322) ]; 
 else
     sortedData = sortrows(missclassifiedData,1);
     nonPedTrain = [ nonPedTrain; missclassifiedData(newDataLen -250:newDataLen, 2:322)];  
 end

[SOL_boot, B_boot] = lrf_svm_compute( pedTrain,nonPedTrain);
 save('..\lrfSVM.mat','SOL_boot', 'B_boot','-append');

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

%  [percentPed, percentNonPed] = testPhase(0, SOL_init, B_init,pedTest, nonPedTest)
%  [percentPed, percentNonPed] = testPhase(0, SOL_boot, B_boot ,pedTest, nonPedTest)

 