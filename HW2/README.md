# HW2
###### tags:`Image Processing` `filter` `2D image`

## Introduction
- Task1
我選擇使用Prewitt filter 當作gradient filter 做觀察，再加上contrast adjustment和gamma translation 的前處理，以及LoG method，最後再用threshold 對上述的結果做處理，以此觀察edge points。
- Task2
我實作了canny detector，發現效果比task 1 的好許多。 

## A review of the methods you have used: 
- Task1
    -   Prewitt filter (gradient filter)  
    以下是我採用的filter 
    ![](https://i.imgur.com/ohc6Z46.png)
    - Contrast adjustment 
    公式是先決定一個 C (對比的係數，0 為不變，而我用 C=100)再帶入
    $$F = {259(C+255) \over 255(259-C).}$$ 
    $$R' = {F(R-128)+128.}$$
    -    Gamma translation 
    公式為 s = c*$r^r$，而 c = 1，r = 3.75，而下圖是不同r的公式曲線。
    ![](https://i.imgur.com/moMbAUm.png)
    -    Thresholding 
    根據不同的圖片，我選擇了不同係數做threshold，以達到更好的效果。
    -    LoG method
    以下是我採用的filter
    ![](https://i.imgur.com/9cKYc5k.png)

- Task2
    - Gaussian filter 
    - Sobel filter (two direction) 
    以下是我採用的filter 
    ![](https://i.imgur.com/v93gLQ3.png)
    -    Nonmaxima suppression 
    根據sobel filter 得到的梯度方向，決定該點在正負梯度上是否強度最大，如果是的話就認定是邊緣點。
    -    Double thresholding 
    以第四張圖為例，我設定TL 為10，TH 為25，如果該點強度小於10 認定為非邊界，介於10 到25 則檢測相鄰的點是否有強度大於25 的。 
    
## A explanation of the experiments you have done, and the results: 
-    Task 1 
        - Original images ![](https://i.imgur.com/HHE0baM.png)
        - Prewitt filter![](https://i.imgur.com/tB1oGeI.png)

        - Threshold (no preprocessing) ![](https://i.imgur.com/PCbRjnS.png)
        - Threshold (contrast adjustment)![](https://i.imgur.com/eOseomb.png)
        - Threshold (gamma translation) ![](https://i.imgur.com/zF6IQxo.png)
        - LoG method ![](https://i.imgur.com/pRKaXZr.png)
        - Threshold (no preprocessing) ![](https://i.imgur.com/WJa0gwn.png)
        - Threshold (contrast adjustment) ![](https://i.imgur.com/0QtpG9n.png)

        - Threshold (gamma translation) ![](https://i.imgur.com/HeBhgV1.png)
-    Task2
        - After Gaussian smoothing and first-derivative operator ![](https://i.imgur.com/rV6AGik.png)
        - After nonmaxima suppression ![](https://i.imgur.com/3BrgejD.png)
        - After thresholding ![](https://i.imgur.com/WsTi6G3.png)


## Discussions: Your observations, interpretations of results, and remaining questions. 
- Task1
整體來說，LoG 的效果會比單純的gradient filter 好，gradient filter 雖然能找到較明顯的邊界，但LoG 能找到較多正確的邊緣點且雜訊較少。而threshold 過之後黑白會更明顯，但前提是挑選了適合的數值，我試過多種參數，以上呈現的是我
覺得最適合的結果。而圖片經過調整(我用了contrast adjustment 及gamma 
translation)，發現用contrast adjustment 之後邊緣會更容易被找到，相對的，用gamma translation 之後會大大的干擾gradient filter，找到的邊緣變得相當少。 
- Task 2 
光是第一步驟中，先用Gaussian filter 處理過後再用gradient filter 找邊界，就比task 1 的好上不少，而再經過nonmaxima suppression 之後，邊界變得更明顯，可以說是十分清楚，不過double threshold 要找到適合的參數需要多次的觀察，不然結果可能會差很多。 