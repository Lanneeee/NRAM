function patchImg = construct(img, patchSize, slideStep)

% This matlab code generates the patch-image for infrared 
% patch-image model.
%
% Yimian Dai. Questions? yimian.dai@gmail.com
% Copyright: College of Electronic and Information Engineering, 
%            Nanjing University of Aeronautics and Astronautics


[m, n] = size(img);

rowNum = ceil((m - patchSize) / slideStep) + 1;
colNum = ceil((n - patchSize) / slideStep) + 1;
rowPosArr = [1 : slideStep : (rowNum - 1) * slideStep, m - patchSize + 1];
colPosArr = [1 : slideStep : (colNum - 1) * slideStep, n - patchSize + 1];

patchImg = zeros(patchSize * patchSize, rowNum * colNum);

k = 0;
for col = colPosArr
    for row = rowPosArr
        k = k + 1;
        tmp_patch = img(row : row + patchSize - 1, col : col + patchSize - 1);
        patchImg(:, k) = tmp_patch(:);
    end
end
