function [KEEL_mortgage,KEEL_treasury,KEEL_wankara,KEEL_wizmir,KEEL_ele_2,KEEL_stock,KEEL_concrete,KEEL_compactiv,KEEL_machineCPU,UCI_day,UCI_RBDS,UCI_airquality,UCI_Processed_DJI,KEEL_mv,UCI_Facebook,KEEL_friedman,UCI_music,KEEL_autompg8,UCI_Steelindustry,KEEL_forestfires,KEEL_laser,UCI_gt1] = loaddata1()

KEEL_mortgage=xlsread('mortgage.xlsx');
KEEL_treasury=xlsread('treasury.xlsx');
KEEL_wankara=xlsread('wankara.xlsx');
KEEL_wizmir=xlsread('wizmir.xlsx');
KEEL_ele_2=xlsread('ele_2.xlsx');
KEEL_stock=xlsread('stock.xlsx');
KEEL_laser=xlsread('laser.xlsx');
KEEL_compactiv=xlsread('compactiv.xlsx');
KEEL_compactiv=KEEL_compactiv(1:1:1638,:);
KEEL_machineCPU=xlsread('machineCPU.xlsx');
UCI_day=xlsread('day.xlsx');
UCI_RBDS=xlsread('RBDS.xlsx');
AirQualityUCI=load('AirQualityUCI.mat');
AirQualityUCI=AirQualityUCI.AirQualityUCI;
UCI_airquality=[AirQualityUCI(:,1:1:11) AirQualityUCI(:,13) AirQualityUCI(:,12)];
UCI_Processed_DJI=xlsread('Processed_DJI.xlsx');
UCI_Facebook=xlsread('Facebook.xlsx');
gt_2011=xlsread('gt_2011.xlsx');
UCI_gt1=gt_2011(1:1:741,1:1:10);
music=xlsread('music.xlsx');
UCI_music=music(:,[1:1:66 68]);
Steel_industry_data=xlsread('Steel_industry_data.xlsx');
UCI_Steelindustry=Steel_industry_data(1:1:3504,:);
KEEL_autompg8=xlsread('autompg8.xlsx');
KEEL_forestfires=xlsread('forestfires.xlsx');
KEEL_friedman=xlsread('friedman.xlsx');
KEEL_concrete=xlsread('concrete.xlsx');
KEEL_mv=xlsread('mv.xlsx');
KEEL_mv=KEEL_mv(1:1:4076,:);


end

