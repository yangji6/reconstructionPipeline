function Ji_disp(data,mask,xbin,xend,ybin,yend,reperf,string_name,caxis_1)

if reperf==1
    figure
    subplot(2,1,1), montage(data(xbin:xend,ybin:yend,1,:,1).*mask(xbin:xend,ybin:yend,1,:,1),'Size',[1 size(mask,4)]); %colormap jet;
    colormap(gca,jet);title(string_name);colorbar;caxis(caxis_1); 
elseif reperf>=2
    figure
    subplot(reperf,1,1), montage(data(xbin:xend,ybin:yend,1,:,1).*mask(xbin:xend,ybin:yend,1,:,1),'Size',[1 size(mask,4)]); %colormap jet;
    colormap(gca,jet);title(string_name);colorbar;caxis(caxis_1); 
    for i=2:reperf
        subplot(reperf,1,i), montage(data(xbin:xend,ybin:yend,1,:,i).*mask(xbin:xend,ybin:yend,1,:,1),'Size',[1 size(mask,4)]); %colormap jet;
        colormap(gca,jet);colorbar;caxis(caxis_1); 
    end
end