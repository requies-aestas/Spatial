import Foundation
import QuartzCore
/**
 * Update constraints (For items that are of type ConstraintKind)
 * - Note: adding a method called activateConstraints doesn't make any sense because you have only anchor and size or either
 */
extension ConstraintKind where Self: View {
   /**
    * One-liner for applyAnchorAndSize
    * ## Examples:
    * view.applyAnchorAndSize(to: self, height: 100, align: .centerCenter, alignTo: .centerCenter)
    * - Parameters:
    *    - to: The instance to apply to
    *    - sizeTo: provide this if you need to base the size on another view
    *    - width: the width to apply to instance
    *    - height: the height to apply to instance
    *    - align: alignment for the `to` view
    *    - alignTo: alignment for the `sizeTo` view, if one was provided
    *    - multiplier: multiplies the `size` or `sizeTo`
    *    - offset: offset for the `to` parameter
    *    - sizeOffset: offset for the `sizeTo` parameter (use negative values for inset)
    *    - useMargin: aligns to autolayout margins or not
    */
   public func applyAnchorAndSize(to: View, sizeTo: View? = nil, width: CGFloat? = nil, height: CGFloat? = nil, align: Alignment = .topLeft, alignTo: Alignment = .topLeft, multiplier: CGSize = .init(width: 1, height: 1), offset: CGPoint = .zero, sizeOffset: CGSize = .zero, useMargin: Bool = false) {
      self.applyAnchorAndSize { _ in
         let anchor: AnchorConstraint = Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
         let size: SizeConstraint = {
            if let width = width, let height = height { // This method exists when you have size, but don't want to set size based on another view, which is the case if you have defined both width and height params
               return Constraint.size(self, size: .init(width: width, height: height), multiplier: multiplier)
            } else {
               return Constraint.size(self, to: sizeTo ?? to, width: width, height: height, offset: sizeOffset, multiplier: multiplier)
            }
         }()
         return (anchor, size)
      }
   }
   /**
    * One-liner for applyAnchor
    * ## Examples:
    * view.applyAnchor(to:self, align:.center, alignTo:.center)
    * - Parameters:
    *    - to: The instance to apply to
    *    - align: alignment for the `to` view
    *    - alignTo: alignment for the `sizeTo` view, if one was provided
    *    - offset: offset for the `to` parameter
    *    - useMargin: aligns to autolayout margins or not
    */
   public func applyAnchor(to: View, align: Alignment = .topLeft, alignTo: Alignment = .topLeft, offset: CGPoint = .zero, useMargin: Bool = false) {
      self.applyAnchor { _ in
         Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
      }
   }
   /**
    * One-liner method for the long-hand method self.applySize
    * ## Examples:
    * view.applySize(to:self)//multiplier,offset
    * - Parameters:
    *    - to: The instance to apply to
    *    - width: the width to apply to instance
    *    - height: the height to apply to instance
    *    - multiplier: multiplies the `size` or `sizeTo` default is (width:1,height:1)
    *    - offset: offset for the `to` parameter
    */
   public func applySize(to: View, width: CGFloat? = nil, height: CGFloat? = nil, offset: CGSize = .zero, multiplier: CGSize = .init(width: 1, height: 1)) {
      self.applySize { _ in
         Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
      }
   }
}
