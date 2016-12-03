# AutoLayout

這是一個 UIView 的 Extension

方便快速簡單的建立 NSLayoutConstraint

以下簡述一下用法

            self.view.addSubview(button)

            // 設定 button 寬度為 160
            button.mLay(.width  , 160 ),

            // 設定 button 高度為 view 寬度的 0.8倍
            button.mLay(.height ,.equal, view,.width , multiplier: 0.8 , constant: 0),
            
            // 設定 button 的 centerX 對齊 view 的 centerX
            button.mLay(.centerX, .equal, view),
            
            // 設定 button 的 top 對齊 view 的 centerY 並偏移 150
            button.mLay(.top, .equal, view, .centerY, constant: 150)







