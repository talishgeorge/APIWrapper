import CoreGraphics

// MARK: - CalendarViewScrollPosition

/// The scroll position for programmatically scrolling to a day or month.
public enum CalendarViewScrollPosition {

  /// The position that centers the day or month in the visible bounds of the calendar along its scrollable axis.
  case centered

  /// The first position along the scrollable axis that makes the day or month fully visible in the visible bounds of the calendar, with
  /// additional padding provided via `padding`.
  ///
  /// If the calendar scrolls its months vertically, then the "first position" is the top edge.
  /// If the calendar scrolls its months horizontally, then the "first position" is the left edge.
  case firstFullyVisiblePosition(padding: CGFloat)

  /// The last position along the scrollable axis that makes the day or month fully visible in the visible bounds of the calendar, with
  /// additional padding provided via `padding`.
  ///
  /// If the calendar scrolls its months vertically, then the "last position" is the bottom edge.
  /// If the calendar scrolls its months horizontally, then the "last position" is the right edge.
  case lastFullyVisiblePosition(padding: CGFloat)

}

// MARK: CalendarViewScrollPosition Constants

extension CalendarViewScrollPosition {

  /// The first position along the scrollable axis that makes the day or month fully visible in the visible bounds of the calendar.
  ///
  /// If the calendar scrolls its months vertically, then the "first position" is the top edge.
  /// If the calendar scrolls its months horizontally, then the "first position" is the left edge.
  public static let firstFullyVisiblePosition = Self.firstFullyVisiblePosition(padding: 0)

  /// The last position along the scrollable axis that makes the day or month fully visible in the visible bounds of the calendar.
  ///
  /// If the calendar scrolls its months vertically, then the "last position" is the bottom edge.
  /// If the calendar scrolls its months horizontally, then the "last position" is the right edge.
  public static let lastFullyVisiblePosition = Self.lastFullyVisiblePosition(padding: 0)

}
