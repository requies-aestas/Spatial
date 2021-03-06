#if os(iOS)
import UIKit
/**
 * Animation (Static & convenient)
 */
extension UIView {
   public typealias AnimComplete = () -> Void
   public typealias AnimUpdate = () -> Void
   public static func defaultOnComplete() { Swift.print("default anim completed closure") }
   /**
    * Animate
    * - Parameters:
    *   - onUpdate: is "animateTo this" and on every frame do this at the same time 🤔
    *   - onComplete: call back closure for when aim is complete
    *   - dur: seconds the anim should last
    *   - easing: the easing curve
    * ## Examples:
    * UIView.animate({ self.update(offset: to, align: align, alignTo: alignTo) }, onComplete: { Swift.print("🎉") })
    */
   public static func animate(_ onUpdate:@escaping AnimUpdate, onComplete:@escaping AnimComplete = UIView.defaultOnComplete, dur: Double = 0.3, easing: AnimationCurve = .easeOut) {
      let anim: UIViewPropertyAnimator = .init(duration: dur, curve: easing, animations: {
         onUpdate()
      })
      anim.addCompletion { _ in onComplete() }
      anim.startAnimation()
   }
}
#endif
