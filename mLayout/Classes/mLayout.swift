//
//  mLayout.Swift
//
//
//  Created by nick on 2016/12/3.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

public extension UIView {
    
    struct OptionalEdge {
        
        public var top: CGFloat?
        public var leading: CGFloat?
        public var bottom: CGFloat?
        public var trailing: CGFloat?
        
        public init(top: CGFloat? = nil, leading: CGFloat? = nil, bottom: CGFloat? = nil, trailing: CGFloat? = nil) {
            self.top = top
            self.leading = leading
            self.bottom = bottom
            self.trailing = trailing
        }
        public static var allZero: UIView.OptionalEdge {
            return UIView.OptionalEdge.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }

    @discardableResult
    func mLay( _ attribute: NSLayoutConstraint.Attribute,
               _ relatedBy: NSLayoutConstraint.Relation,
               _ toItem: UIView?,
               _ attribute1: NSLayoutConstraint.Attribute,
               multiplier: CGFloat,
               constant: CGFloat,
               active: Bool = true,
               priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout =  NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
        layout.priority = priority
        layout.isActive = active
        return layout
    }

    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active, priority: priority)
    }

    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
    }

    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              multiplier: CGFloat,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active, priority: priority)
    }

    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
    }

    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              _ attribute1: NSLayoutConstraint.Attribute,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active, priority: priority)
    }

    @discardableResult
    func mLay(pin: UIEdgeInsets, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        let view = view ?? superview!
        return [  mLay(.top   , .equal, view, constant: pin.top     ),
                  mLay(.left  , .equal, view, constant: pin.left    ),
                  mLay(.bottom, .equal, view, constant: -pin.bottom ),
                  mLay(.right , .equal, view, constant: -pin.right  )]
    }

    @discardableResult
    func mLayEqualSuper() -> [NSLayoutConstraint] {
        return mLay(pin: .zero)
    }

    @discardableResult
    func mLay(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        let view = view ?? superview!
        if let top      = pin.top      { arr.append( mLay(.top      , .equal, view, constant: top       )) }
        if let leading  = pin.leading  { arr.append( mLay(.leading  , .equal, view, constant: leading   )) }
        if let bottom   = pin.bottom   { arr.append( mLay(.bottom   , .equal, view, constant: -bottom   )) }
        if let trailing = pin.trailing { arr.append( mLay(.trailing , .equal, view, constant: -trailing )) }
        return arr
    }

    @discardableResult
    func mLayCenterXY(to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        return [ mLay(.centerY, .equal, view ?? superview! ),
                 mLay(.centerX, .equal, view ?? superview! )]
    }

    @discardableResult
    func mLay(size: CGSize) -> [NSLayoutConstraint] {
        return [ mLay( .height, size.height), mLay( .width, size.width)]
    }

}

public extension UIView {
    enum mLayDirection {
        case top
        case trailing
        case bottom
        case leading

        func getLayoutAttribute() -> NSLayoutConstraint.Attribute {
            switch self {
            case .top: return .top
            case .leading: return .leading
            case .bottom: return .bottom
            case .trailing: return .trailing
            }
        }
    }

    // Auto Active
    @discardableResult
    func mLayEqualSafeArea(with item: UIView, direction: mLayDirection, constant: CGFloat = 0, active: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            switch direction {
            case .top:  return self.topAnchor.constraint(equalTo: item.safeAreaLayoutGuide.topAnchor, constant: constant).active(bool: active)
            case .leading: return self.leadingAnchor.constraint(equalTo: item.safeAreaLayoutGuide.leadingAnchor, constant: constant).active(bool: active)
            case .bottom: return self.bottomAnchor.constraint(equalTo: item.safeAreaLayoutGuide.bottomAnchor, constant: constant).active(bool: active)
            case .trailing: return self.trailingAnchor.constraint(equalTo: item.safeAreaLayoutGuide.trailingAnchor, constant: constant).active(bool: active)
            }
        } else {
            let attrib = direction.getLayoutAttribute()
            return NSLayoutConstraint(item: self, attribute: attrib, relatedBy: .equal, toItem: item, attribute: attrib, multiplier: 1, constant: constant).active(bool: active)
        }
    }

    @discardableResult
    func mLaySafe(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        let view = view ?? superview!
        if let value = pin.top      { arr.append( mLayEqualSafeArea(with: view, direction: .top   , constant:  value)) }
        if let value = pin.leading  { arr.append( mLayEqualSafeArea(with: view, direction: .leading  , constant:  value)) }
        if let value = pin.bottom   { arr.append( mLayEqualSafeArea(with: view, direction: .bottom, constant: -value)) }
        if let value = pin.trailing { arr.append( mLayEqualSafeArea(with: view, direction: .trailing , constant: -value)) }
        return arr
    }
    
}

public extension NSLayoutConstraint {
    @discardableResult
    func active(bool: Bool) -> NSLayoutConstraint {
        self.isActive = bool
        return self
    }
}

public extension UIView {
    
    @discardableResult
    func mLayChain( _ attribute: NSLayoutConstraint.Attribute,
               _ relatedBy: NSLayoutConstraint.Relation,
               _ toItem: UIView?,
               _ attribute1: NSLayoutConstraint.Attribute,
               multiplier: CGFloat,
               constant: CGFloat,
               active: Bool = true,
               priority: UILayoutPriority = .init(1000)) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let layout =  NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
        layout.priority = priority
        layout.isActive = active
        return self
    }

    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active, priority: priority)
        return self
    }

    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
              _ constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> Self {
        mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              multiplier: CGFloat,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active, priority: priority)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              _ attribute1: NSLayoutConstraint.Attribute,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> Self {
        mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active, priority: priority)
        return self
    }
    
    @discardableResult
    func mLayChain(pin: UIEdgeInsets, to view: UIView? = nil) -> Self {
        mLay(pin: pin, to: view)
        return self
    }
    
    @discardableResult
    func mLayChainEqualSuper() -> Self {
        mLayEqualSuper()
        return self
    }
    
    @discardableResult
    func mLayChain(pin: OptionalEdge, to view: UIView? = nil) -> Self {
        mLay(pin: pin, to: view)
        return self
    }
    
    @discardableResult
    func mLayChainCenterXY(to view: UIView? = nil) -> Self {
        mLayCenterXY(to: view)
        return self
    }
    
    @discardableResult
    func mLayChain(size: CGSize) -> Self {
        mLay(size: size)
        return self
    }
}

public extension UIView {
    
    @discardableResult
    func mLayChainEqualSafeArea(with item: UIView, direction: mLayDirection, constant: CGFloat = 0, active: Bool = true) -> Self {
        mLayEqualSafeArea(with: item, direction: direction, constant: constant, active: active)
        return self
    }

    @discardableResult
    func mLayChainSafe(pin: OptionalEdge, to view: UIView? = nil) -> Self {
        mLaySafe(pin: pin, to: view)
        return self
    }

}
