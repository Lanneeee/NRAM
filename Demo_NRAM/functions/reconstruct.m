function recImg = reconstruct(patchImg, img, patchSize, slideStep)

% This matlab code implements the reconstruction of target/background
% images.

% Yimian Dai. Questions? yimian.dai@gmail.com
% Copyright: College of Electronic and Information Engineering, 
%            Nanjing University of Aeronautics and Astronautics

[Hei, Wid] = size(img);

rowNum = ceil((Hei - patchSize) / slideStep) + 1;
colNum = ceil((Wid - patchSize) / slideStep) + 1;
rowPosArr = [1 : slideStep : (rowNum - 1) * slideStep, Hei - patchSize + 1];
colPosArr = [1 : slideStep : (colNum - 1) * slideStep, Wid - patchSize + 1];

accImg = zeros(Hei, Wid);
weiImg = zeros(Hei, Wid);
k = 0;
onesMat = ones(patchSize, patchSize);
for col = colPosArr
    for row = rowPosArr
        k = k + 1;
        tmpPatch = reshape(patchImg(:, k), [patchSize, patchSize]);
        accImg(row : row + patchSize - 1, col : col + patchSize - 1) = tmpPatch;
        weiImg(row : row + patchSize - 1, col : col + patchSize - 1) = onesMat;
    end
end

% recImg = accImg ./ weiImg;
recImg = accImg;
