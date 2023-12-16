parent_folder='C:\Users\User\Documents\Temalabjelek\';
ECG_sample=dir('C:\Users\User\Documents\Temalabjelek\*m.mat');
parent_folder2='C:\Users\User\Documents\Temalabannotacio\';
ANNOT_sample=dir('C:\Users\User\Documents\Temalabannotacio\*.txt');
sens_array=nan(numel(ECG_sample),1);
pospred_array=nan(numel(ECG_sample),1);
for i=1 : numel(ECG_sample)
    nameundertest=ECG_sample(i).name;
    annotundertest=ANNOT_sample(i).name;
    fullpathundertest = [parent_folder nameundertest];
    fullpathunderreview =[parent_folder2 annotundertest];
    [sens_array(i),pospred_array(i)]=validation(QRSdetector(fullpathundertest, 128),fullpathunderreview );


end