import UIKit
import Spatial
/**
 * Create
 */
extension MainVC{
   /**
    * Creates main view
    */
   func createMainView() -> MainView{
//      Swift.print("createMainView")
//      let screenSize:CGSize = {
//         let size = UIScreen.main.bounds.size
//         return .init(width:size.width/* - 24*/, height:size.height/* - 24*/)
//      }()
      let view:MainView = MainView()//.init(frame: .init(origin: .zero, size: screenSize))
      self.view.addSubview(view)
      //Swift.print("screenSize:  \(screenSize)")
      view.anchorAndSize(to: self.view)
//      view.activateAnchorAndSize { view in
//         let a = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft/*, offset:CGPoint.init(x: 12, y: 12)*/)
//         let s = Constraint.size(view, size: screenSize)
//         return (a,s)
//      }
      return view
   }
   /**
    * Creates animation test view
    */
   func createAnimTestView() -> AnimationTest{
//      Swift.print("createAnimTestView")
      let view:AnimationTest = AnimationTest.init(frame: CGRect.init(origin: .zero, size: .zero))
      self.view.addSubview(view)
      
      //Swift.print("screenSize:  \(screenSize)")
//      view.
      view.activateAnchorAndSize { view in
         let a = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft/*, offset:CGPoint.init(x: 12, y: 12)*/)
         let s = Constraint.size(view, size: UIScreen.main.bounds.size)
         return (a,s)
      }
      return view
   }
}
