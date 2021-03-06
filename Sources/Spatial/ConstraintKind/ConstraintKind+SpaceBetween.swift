import Foundation
import QuartzCore
/**
 * Space items evenly to fill length
 */
extension Array where Element: ConstraintKind.ViewConstraintKind {
   /**
    * Aligns all items horizontally from the absolute start to absolute end and adds equal spacing between them (only works on views that adher to ConstraintKind)
    * - Description: |[]--[]--[]--[]--[]|
    * - Important: ⚠️️ views needs to have size constraint applied before calling this method
    * - Important: ⚠️️ This method from layoutSubViews, as you need the parent.bounds to be realized, and its only relaized from AutoLayout when layoutSubViews is called
    * - Important: ⚠️️ Only works with UIConstraintView's (parent does not have to be UIViewConstraintKind)
    * - Parameters:
    *    - parent: the containg view that has the views as subViews
    *    - dir: which direction you want to distribute items in
    *    - inset: use this to inset where items should be set, if none is provided parent.bounds is used
    * ## Examples:
    * views.spaceBetween(dir: .horizontal, parent: self, inset:x)
    * - Fixme: ⚠️️ write doc
    */
   public func spaceBetween(dir: Axis, parent: View, inset: EdgeInsets = .init()) {
      switch dir {
      case .hor: SpaceBetweenUtil.spaceBetween(horizontally: parent, views: self, inset: inset)
      case .ver: SpaceBetweenUtil.spaceBetween(vertically: parent, views: self, inset: inset)
      }
   }
}
/**
 * SpaceBetween helper
 */
private class SpaceBetweenUtil {
   /**
    * Horizontal (new)
    * - Fixme: ⚠️️ write doc, and use reduce on x
    */
   static func spaceBetween(horizontally parent: View, views: [ConstraintKind.ViewConstraintKind], inset: EdgeInsets) {
      let rect: CGRect = parent.bounds.inset(by: inset)
      let itemVoid: CGFloat = horizontalItemVoid(rect: rect, views: views)
      var x: CGFloat = rect.origin.x // Interim x
      views.forEach { item in
         item.activateConstraint { _ in // Fixme: ⚠️️ Create applyAnchor for hor and ver
            let constraint = Constraint.anchor(item, to: parent, align: .left, alignTo: .left, offset: x)
            item.anchor?.x = constraint
            return constraint
         }
         x += (item.size?.w.constant ?? 0) + itemVoid
      }
   }
   /**
    * Vertical (new)
    * - Fixme: ⚠️️ write doc, and use reduce on y
    */
   static func spaceBetween(vertically parent: View, views: [ConstraintKind.ViewConstraintKind], inset: EdgeInsets) {
      let rect: CGRect = parent.bounds.inset(by: inset)
      let itemVoid: CGFloat = verticalItemVoid(rect: rect, views: views)
      var y: CGFloat = rect.origin.y // Interim y
      views.forEach { item in
         item.activateConstraint { _ in // Fixme: ⚠️️ Create applyAnchor for hor and ver
            let constraint = Constraint.anchor(item, to: parent, align: .top, alignTo: .top, offset: y)
            item.anchor?.y = constraint
            return constraint
         }
         y += (item.size?.h.constant ?? 0) + itemVoid
      }
   }
}
/**
 * Helpers
 */
extension SpaceBetweenUtil {
   /**
    * ItemVoid (horizontal)
    */
   private static func horizontalItemVoid(rect: CGRect, views: [ConstraintKind.ViewConstraintKind]) -> CGFloat {
      let totW: CGFloat = views.reduce(0) { $0 + ($1.size?.w.constant ?? 0) } // find the totalW of all items
      let totVoid: CGFloat = rect.width - totW // Find totVoid by doing w - totw
      let numOfVoids = CGFloat(views.count - 1) // Then divide this voidSpace with .count - 1 and
      return totVoid / numOfVoids // Iterate of each item and inserting itemVoid in + width
   }
   /**
    * ItemVoid (vertical)
    */
   private static func verticalItemVoid(rect: CGRect, views: [ConstraintKind.ViewConstraintKind]) -> CGFloat {
      let totH: CGFloat = views.reduce(0) { $0 + ($1.size?.h.constant ?? 0) } // Find the totalW of all items
      let totVoid: CGFloat = rect.height - totH // Find totVoid by doing w - totw
      let numOfVoids = CGFloat(views.count - 1) // Then divide this voidSpace with .count - 1 and
      return totVoid / numOfVoids // Iterate of each item and inserting itemVoid in + width
   }
}
