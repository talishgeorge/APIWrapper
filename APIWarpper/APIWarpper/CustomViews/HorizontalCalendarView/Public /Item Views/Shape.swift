import CoreGraphics

/// Represents a background or highlight layer shape; used by `DayView` and `DayOfWeekView`.
public enum Shape: Hashable {
  case circle
  case rectangle(cornerRadius: CGFloat = 0)
}
