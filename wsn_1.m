img1=imread('IISc_disp1.jpg');
img01=((img1(:,:,1)>250) & (img1(:,:,2)>230) & (img1(:,:,3)<10));
se=strel('disk',2,8);
img02=imdilate(img01,se);
L=bwlabel(img02);
%
for a=1:10
    r=regionprops(L==a,'Centroid');
    x(a)=r.Centroid(1);
    y(a)=r.Centroid(2);
end
%
for a=1:9
    for b=a+1:10
        X=[x(a),y(a);x(b),y(b)];
        D=pdist(X,'euclidean');
        if a==1 && b==2
            z=[a,b,D];
        else
            z=[z;a,b,D];
        end
    end    
end
Z=sortrows(z,3);
%
m=zeros(10);
c=0;
A=zeros(9,2);
k=zeros(10,1);
for a=1:10;
    m(1,a)=a;
end
for a=1:45
    u=Z(a,1);
    v=Z(a,2);
    [g1,g2]=find(m==u);
    [h1,h2]=find(m==v);
    if g2==h2
        continue;
    end
    if m(1,u)==u
        if m(1,v)==v
            c=c+1;
            m(1,v)=0;
            m(v,u)=v;
            k=find(m(:,v));
            for b=1:size(k,1)
                m(k(b),u)=k(b);
                m(k(b),v)=0;
            end
        else
            c=c+1;
            [q,w]=find(m==v);
            k=find(m(:,w));
            m(w,u)=w;
            m(1,w)=0;
            if(size(k,1)>1)
                for b=2:size(k,1)
                    m(k(b),u)=k(b);
                    m(k(b),w)=0;
                end
            end
        end
    else
        c=c+1;
        [o,p]=find(m==u);
        t=find(m(:,p));
        [q,w]=find(m==v);
        k=find(m(:,w));
        m(w,p)=w;
        m(1,w)=0;
            if(size(k,1)>1)
                for b=2:size(k,1)
                    m(k(b),p)=k(b);
                    m(k(b),w)=0;
                end
            end
    end
    if c==10
        break;
    end
    %m
    %c
    A(c,1)=u;
    A(c,2)=v;
end
%
im=imread('IISc_disp1.jpg');
%figure;
hold on;
imshow(im);
for a=1:9
    u1=A(a,1);
    v1=A(a,2);
    line([x(u1),x(v1)],[y(u1),y(v1)],'Color','w','LineWidth',2)
end
hold off

        
            
                
                
                
            
            
                
     