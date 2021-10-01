import UIKit

/// A configuration used when creating a background or highlight layer; used by `DayView` and `DayOfWeekView`.
public struct DrawingConfig: Hashable {

  // MARK: Lifecycle

  public init(
    fillColor: UIColor = .clear,
    borderColor: UIColor = .clear,
    borderWidth: CGFloat = 1)
  {
    self.fillColor = fillColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
  }

  // MARK: Public

  public static let transparent = DrawingConfig()

  public var fillColor = UIColor.clear
  public var borderColor = UIColor.clear
  public var borderWidth: CGFloat = 1
}
