import UIKit

extension CGFloat {

  /// Rounds `self` so that it's aligned on a pixel boundary for a screen with the provided scale.
  func alignedToPixel(forScreenWithScale scale: CGFloat) -> CGFloat {
    (self * scale).rounded() / scale
  }
  
  /// Tests `self` for approximate equality using the threshold value. For example, 1.48 equals 1.52 if the threshold is 0.05.
  /// `threshold` will be treated as a postive value by taking its absolute value.
  func isEqual(to rhs: CGFloat, threshhold: CGFloat) -> Bool {
    abs(self - rhs) <= abs(threshhold)
  }

}

extension CGRect {

  /// Rounds a `CGRect`'s `origin` and `size` values so that they're aligned on pixel boundaries for a screen with the provided
  /// scale.
  func alignedToPixels(forScreenWithScale scale: CGFloat) -> CGRect {
    let alignedX = minX.alignedToPixel(forScreenWithScale: scale)
    let alignedY = minY.alignedToPixel(forScreenWithScale: scale)
    return CGRect(
      x: alignedX,
      y: alignedY,
      width: maxX.alignedToPixel(forScreenWithScale: scale) - alignedX,
      height: maxY.alignedToPixel(forScreenWithScale: scale) - alignedY)
  }

}

extension CGPoint {

  /// Rounds a `CGPoints`'s `x` and `y` values so that they're aligned on pixel boundaries for a screen with the provided scale.
  func alignedToPixels(forScreenWithScale scale: CGFloat) -> CGPoint {
    CGPoint(
      x: x.alignedToPixel(forScreenWithScale: scale),
      y: y.alignedToPixel(forScreenWithScale: scale))
  }

}
