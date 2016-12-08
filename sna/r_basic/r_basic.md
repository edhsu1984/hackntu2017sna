r_basic
========================================================
author: 
date: 
autosize: true



First Slide
========================================================

For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.

- 讀取資料
- Bullet 2
- Bullet 3



用 read.table() 載入些資料小試牛刀吧
========================================================

read.table('path/to/file') 可以從網路或本機載入資料


```r
# 設定檔案所在路徑之檔案夾
setwd('~/hackntu2016/sna/r_basic')

advice_data_frame <- read.table('Krack-High-Tec-edgelist-Advice.txt')

friendship_data_frame <- read.table('Krack-High-Tec-edgelist-Friendship.txt')

reports_to_data_frame <- read.table('https://goo.gl/W1YP8P')
```



可以用 head()、tail() 觀察載入的資料
========================================================


```r
# 確認資料的型態
typeof(advice_data_frame)
```

```
[1] "list"
```

```r
class(advice_data_frame)
```

```
[1] "data.frame"
```


```r
# head()、tail() 顧名思義
head(advice_data_frame)
```

```
  V1 V2 V3
1  1  1  0
2  1  2  1
3  1  3  0
4  1  4  1
5  1  5  0
6  1  6  0
```



當然用 read.csv() 也 OK
========================================================

read.csv() 也跟 read.table() 很像，可以從網路或本機載入資料


```r
# 設定檔案所在路徑之檔案夾
setwd('~/hackntu2016/sna/lab_1')

attributes <- read.csv('Krack-High-Tec-Attributes.csv', header=T)

head(attributes)
```

```
  AGE TENURE LEVEL DEPT
1  33  9.333     3    4
2  42 19.583     2    4
3  40 12.750     3    2
4  33  7.500     3    4
5  32  3.333     3    2
6  59 28.000     3    1
```



針對連續的資料集可以用 summary() 
========================================================

針對連續的資料型態，可以用 summary() 可以很快地看出資料的分佈狀況


```r
summary(attributes)
```

```
      AGE            TENURE           LEVEL            DEPT     
 Min.   :27.00   Min.   : 0.250   Min.   :1.000   Min.   :0.00  
 1st Qu.:33.00   1st Qu.: 7.500   1st Qu.:3.000   1st Qu.:1.00  
 Median :37.00   Median : 9.333   Median :3.000   Median :2.00  
 Mean   :39.71   Mean   :11.746   Mean   :2.714   Mean   :2.19  
 3rd Qu.:43.00   3rd Qu.:12.500   3rd Qu.:3.000   3rd Qu.:3.00  
 Max.   :62.00   Max.   :30.000   Max.   :3.000   Max.   :4.00  
```



用 colnames() 標示各行的名稱
========================================================

為了方便，我們可以用 colnames() 標示各行的名稱


```r
# c() is a common generic R function that combines its arguments into a single vector.

colnames(advice_data_frame) <- c('ego', 'alter', 'advice_tie')
head(advice_data_frame)
```

```
  ego alter advice_tie
1   1     1          0
2   1     2          1
3   1     3          0
4   1     4          1
5   1     5          0
6   1     6          0
```



用 colnames() 標示各行的名稱
========================================================

同上一張投影片，我們也將 friendship_data_frame、reports_to_data_frame 標示各行的名稱


```r
colnames(friendship_data_frame) <- c('ego', 'alter', 'friendship_tie')
head(friendship_data_frame)
```

```
  ego alter friendship_tie
1   1     1              0
2   1     2              1
3   1     3              0
4   1     4              1
5   1     5              0
6   1     6              0
```


```r
colnames(reports_to_data_frame) <- c('ego', 'alter', 'reports_to_tie')
head(reports_to_data_frame)
```

```
  ego alter reports_to_tie
1   1     1              0
2   1     2              1
3   1     3              0
4   1     4              0
5   1     5              0
6   1     6              0
```



將三個 dataframe 合併為一
========================================================

方便後續處理


```r
# Now that we've verified they are all the same, we can combine them into a single data frame. 

krack_full_data_frame <- cbind(
  advice_data_frame, 
  friendship_data_frame$friendship_tie, 
  reports_to_data_frame$reports_to_tie
)

head(krack_full_data_frame)
```

```
  ego alter advice_tie friendship_data_frame$friendship_tie
1   1     1          0                                    0
2   1     2          1                                    1
3   1     3          0                                    0
4   1     4          1                                    1
5   1     5          0                                    0
6   1     6          0                                    0
  reports_to_data_frame$reports_to_tie
1                                    0
2                                    1
3                                    0
4                                    0
5                                    0
6                                    0
```



========================================================

更改一下 columns 的名稱避免混淆


```r
names(krack_full_data_frame)[4:5] <- c("friendship_tie", "reports_to_tie")  

head(krack_full_data_frame)
```

```
  ego alter advice_tie friendship_tie reports_to_tie
1   1     1          0              0              0
2   1     2          1              1              1
3   1     3          0              0              0
4   1     4          1              1              0
5   1     5          0              0              0
6   1     6          0              0              0
```
