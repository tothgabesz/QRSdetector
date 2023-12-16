function [sens,pospredict]=validation(R_peaks, annotation_name);
TP=0;
FN=0;
FP=0;
s1='N', s2='L', s3='R', s4='B', s5='a', s6='a', s7='J', s8='S', s9='V', s10='r';
s11='F', s12='e', s13='j', s14='n', s15='E', s16='E', s17='/', s18='f', s19='Q', s20='?';
R_peaks.';
fid=fopen(annotation_name);
annot_raw=textscan(fid,'%s %f %s %f %f %f %s', 'headerlines', 2);
annot_raw(1)=[];
annot_raw(3:6)=[];
annot_rpeaks=annot_raw{1,1};
a=annot_raw{1,2};
annot_rpeaksOK=cell2mat(a);



for i=1 : numel(R_peaks)
    isfound=0;
    for j = 1 : numel(annot_rpeaksOK)
        if abs(R_peaks(i)-annot_rpeaks(j))<5 && (strcmp(s1,annot_rpeaksOK(j))==1 || strcmp(s2,annot_rpeaksOK(j))==1 ||...
                strcmp(s3,annot_rpeaksOK(j))==1 || strcmp(s4,annot_rpeaksOK(j))==1 || strcmp(s5,annot_rpeaksOK(j))==1 ||...
                strcmp(s6,annot_rpeaksOK(j))==1 || strcmp(s7,annot_rpeaksOK(j))==1 || strcmp(s8,annot_rpeaksOK(j))==1 ||...
                strcmp(s9,annot_rpeaksOK(j))==1 || strcmp(s10,annot_rpeaksOK(j))==1 || strcmp(s11,annot_rpeaksOK(j))==1 ||...
                strcmp(s12,annot_rpeaksOK(j))==1 || strcmp(s13,annot_rpeaksOK(j))==1 || strcmp(s14,annot_rpeaksOK(j))==1 ||...
                strcmp(s15,annot_rpeaksOK(j))==1 || strcmp(s16,annot_rpeaksOK(j))==1 || strcmp(s17,annot_rpeaksOK(j))==1 ||...
                strcmp(s18,annot_rpeaksOK(j))==1 || strcmp(s19,annot_rpeaksOK(j))==1 || strcmp(s20,annot_rpeaksOK(j))==1)


            isfound=1;

        end
    end

    if isfound==1
        TP=TP+1;
    end

    if isfound==0
        FP=FP+1;
    end


end
for i=1 :numel(annot_rpeaks)
    if  strcmp(s1, annot_rpeaksOK(i))==1
        isfound=0;
        for j=1 :numel(R_peaks)
            if abs(R_peaks(j)-annot_rpeaks(i))<5
                isfound=1;
            end
        end
        if isfound ==0
            FN=FN+1;
        end
    end
end


sens=TP/(TP+FN);
pospredict=TP/(TP+FP);