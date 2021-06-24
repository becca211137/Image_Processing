# HW1
###### tags:`Image Processing` `filter` `2D image`

### Introduction / Objectives : 
 我用matlab 實作了六種不同的image enhancement 的方法，針對每張圖片我用了不同的調整方式，也換了許多參數，找到我認為最適合的為止。以下將分成各圖片來說明。
 
#### Picture 1:
![](https://i.imgur.com/bQDwOan.png)

因為圖一看起來小細節的地方蠻模糊的，所以我用了laplacian 的銳化處理，是取圖片的二階導數再加到原有的圖片上，加強細節的部份。結果道路(褐色部分)
蠻成功的，可以看到兩圖有明顯差異，而圖片右邊(綠色部分)的差異較沒那麼明顯。 

#### Picture 2:
![](https://i.imgur.com/jDDC6TX.png)

因為原圖普遍偏亮，所以我用了gamma transformation，使亮處的對比增加，公
式為s = c*$r^r$，而c=1，r=3.75，效果相當不錯，圖片的細節都有大幅的顯示出來，而下圖是不同的r 會有的不同公式曲線。 

![](https://i.imgur.com/dnAhB7m.png)

#### Picture 3: 
![](https://i.imgur.com/9eDgIfS.png)

因為這張圖較圖二暗，所以我改採用log transformation，對於較陰暗的影像有
比較強的轉換力，可增強對比，公式為s=c*log(1+r)，c=2，可以看到圖片整體
有變亮的感覺，而且顏色較為豐富，而下圖是公式曲線。 

![](https://i.imgur.com/bEdYeUC.png)

#### Picture 4:
![](https://i.imgur.com/RVfR7Aa.png)

因為原圖整張都偏暗，想要加強字的部分，所以用了gaussian high pass filter 找high frequency 的部分，再加上原圖強調重點，整張圖有變的比較銳利，但原本以為字的白色邊緣會被強調的很明顯，結果路牌的外圍才比較明顯。 

#### Picture 5:
![](https://i.imgur.com/l5WT0fY.png)

原圖整張都灰灰的，所以我決定大幅調整對比，而我這裡採用的公式是先決定一個C(對比的係數，0 為不變，而我用C=100)
$$F = {259(C+255) \over 255(259-C).}$$ 
$$R' = F(R-128)+128$$
整張圖片變的鮮豔許多，效果比預期的還好。

#### Picture 6:
![](https://i.imgur.com/TuyS96I.png)

我先選用最常用的mean filter 處理圖片(下圖) 

![](https://i.imgur.com/NJtv1qC.png)

結果發現好像沒什麼差別，所以就用了adaptive filter(上面右圖)，原理是分別算出整張圖的變異數及window(我採用3x3)裡的變異數，如果window 裡的變異數大，通常就是邊界，所以filter 會保留原值，如果不是的話就會採用window 的平均值，原本以為用了這個需要較長時間計算的filter 效果會好很多，結果也沒有顯著到哪裡去。 
