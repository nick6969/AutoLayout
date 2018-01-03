# AutoLayout

// 2018-01-03
修正邏輯錯誤
isActive = true 之後的 NSLayoutConstraint 只能更改 constant
添加 assert 保護，讓開發者可以理解發生的問題，進而修正 

// 2017-10-13
    支援 SafeArea

    可以這樣寫
    aView.mLayEqualSafeArea(with: self.view, direction: .top)
    只有在 iOS 11 才會使用 safeArea ， iOS 8,9,10 是用原本的寫法完成的

--
// 2017-10-10
    添加 active 參數 預設是 true
    所以舊有的不用更改
    若是只是要製作一個 NSLayoutConstraint 沒有要及時直接使用的話
    可以加上參數 active = false 就可以

--
這是一個 UIView 的 Extension

方便快速簡單的建立 NSLayoutConstraint

以下簡述一下用法

            view.addSubview(button)

            // 設定 button 寬度為 160
            button.mLay(.width  , 160 ),

            // 設定 button 高度為 view 寬度的 0.8倍
            button.mLay(.height ,.equal, view,.width , multiplier: 0.8 , constant: 0),
            
            // 設定 button 的 centerX 對齊 view 的 centerX
            button.mLay(.centerX, .equal, view),
            
            // 設定 button 的 top 對齊 view 的 centerY 並偏移 150
            button.mLay(.top, .equal, view, .centerY, constant: 150)


// 2017-07-29
    相容舊版，以前的寫法都可以不用修改，另外再添加了下面的寫法

    對於 method 添加了 @discardableResult 的修飾 , 回傳值可接可不接

    預設 isActive = true ， 不用再手工 addConstraint
    
    以前為這樣寫
    view.addConstraints([
        button.mLay(.height, 50)
    ])
    現在只要這樣寫
    button.mLay(.height, 50)

    ----

    添加了幾種寫法

    如果是要對齊某個 view 的 centerX and centerY 以前會這樣寫
    button.mLay(.centerX, .equal, view)
    button.mLay(.centerY, .equal, view)

    現在可以這樣寫
    button.mLayCenterXY(to:view)
    
    如果 view 是 button 的 superview 還可以變成這樣寫
    button.mLayCenterXY()

    -

    要設定某個元件的寬高 以前會這樣寫
    button.mLay(.height, 100)
    button.mLay(.width, 150)
    
    現在可以這樣寫
    button.mLay(size: CGSize(width: 150, height: 100))

    -

    之前會這樣寫 
    button.mLay(pin: .zero, to: view)

    如果 view 是 button 的 superview 還可以變成這樣寫
    button.mLay(pin: .zero)

    也可以這樣寫
    button.mLayEqualSuper()

    -

    mLay(pin: 的參數型別是 UIEdgeInsets , 只能 top left bottom right 通通都設定
    新的 mLay(pin: 的參數添加接受另一種型別 OptionalEdge , 可以只設定部分方向

    public struct OptionalEdge {
        public var top: CGFloat?
        public var left: CGFloat?
        public var bottom: CGFloat?
        public var right: CGFloat?
        public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil){
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
    }

    例如像是這樣
    button.mLay(pin: .init(top: 20, left: 20, right: 20),to:view) // 跟 上 左 右 各保持 20 的距離 , 一樣 to: 不填會對齊 superview

    -
    
    另外加上可以直接設定 NSLayoutConstraint 的 priority
    以前會這樣寫
    let layout = button.mLay(.height, 150)
    layout.priority = 999

    現在可以這樣寫
    button.mLay(.height, 150).priority(999)

