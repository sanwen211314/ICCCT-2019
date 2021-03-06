function [cov_ED]=spearman(Y,n)

% Cite this paper as:
% Shah D., Zaveri T. (2021) Hyperspectral Endmember Extraction Algorithm Using Spearman’s Rank Correlation. 
% Proceedings of International Conference on Communication and Computational Technologies. Algorithms for Intelligent Systems. Springer, Singapore. 
% https://doi.org/10.1007/978-981-15-5077-5_27

Y1=Y;
[Bands,num] = size(Y);
for i=1:1:Bands
    R=Y1(i,:);
    meanr=mean(R);
    stdr=std(R);
    R1=(R-meanr)/stdr;
    Y(i,:)=R1;
end
Y1=Y';
R1 = corr(Y1,'Type','spearman');
figure, imagesc(R1);
[q1,q2]=min(R1);
[q3,q4]=min(q1);
n_y1=q2(q4);
n_x1=q4;
band_x1=Y(n_x1,:)';
band_y1=Y(n_y1,:)';
p11=[band_x1,band_y1];
for i=0:0.001:1
    conv_points = boundary(p11,i);
    [m1,n1]=size(conv_points);
    if(m1>n)
        break
    end
end
cov_ED=conv_points;
z=(size(cov_ED)-1);
for i=1:z(1)
    [t1]=p11(cov_ED(i),:);
    [t2]=p11(cov_ED(i+1),:);
    dist(i,1)=sqrt(sum((t1-t2).^2));
end
e=[p11(cov_ED),p11(cov_ED,2)];
e(end,:)=[];
cov_ED(end,:)=[];

for k=1:1:(m1-n-1)
    [d1,d2]=min(dist);
    e(d2,:)=[];
    dist(d2,:)=[];
    cov_ED(d2,:)=[];
end
end