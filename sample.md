# Use Sample

## Set Width / Height

    label.mLay(.width, 50)
    label.mLay(.height, 20)

## Set Size

    label.mLay(size: CGSize(width: 50, height: 20))

## Set Alignment equal / lessThanOrEqual / greaterThanOrEqual Other View Same Attribute

    label.mLay(.width, .lessThanOrEqual, view)
    label.mLay(.height, .greaterThanOrEqual, view)
    label.mLay(.centerX, .equal, view)
    label.mLay(.centerY, .equal, view)
    label.mLay(.top, .equal, view)
    label.mLay(.left, .equal, view)
    label.mLay(.bottom, .equal, view)
    label.mLay(.right, .equal, view)
    label.mLay(.leading, .equal, view)
    label.mLay(.trailing, .equal, view)
    label.mLay(.centerY, .equal, view)

## Set Alignment equal Other View different Attribute

    label.mLay(.top, .equal, otherView, .bottom)
    label.mLay(.bottom, .equal, otherView, .top)

## Quick Alignment CenterX and CenterY

    label.mLayCenterXY(to: view)
    
    // if you want Alignment the superView, you can quick use

    label.mLayCenterXY()

## Quick Alignment Some View (Same Frame)

    label.mLay(pin: .zero, to: view)
    
    // if you want Alignment the superView, you can quick use

    label.mLay(pin: .zero)

## Quick Alignment SafeArea

    label.mLayEqualSafeArea(with: view, direction: .top)
    label.mLayEqualSafeArea(with: view, direction: .leading)
    label.mLayEqualSafeArea(with: view, direction: .bottom)
    label.mLayEqualSafeArea(with: view, direction: .trailing)

## Quick Alignment SafeArea Multiple

    // have top & leading & bottom & trailing, you can put you want, not all

    label.mLaySafe(pin: .init(top: 10, leading: 10, trailing: 10), to: view)

    // if you want Alignment the superView, you can quick use

    label.mLaySafe(pin: .init(top: 10, leading: 10, trailing: 10))

## multiplier / constant / active / priority

    Nearly all quick way can add the setting

## Use Chain

    label
        .mLayChain(.width, 100)
        .mLayChain(.height, 50)
        .mLayChainCenterXY()

    the same method with mLay, call the mLayChain
    mLay return NSLayoutConstraint
    mLayChain return property self
    so you can Chain together