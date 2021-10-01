import CoreGraphics

// MARK: - ScrollToItemContext

struct ScrollToItemContext {
  let targetItem: TargetItem
  let scrollPosition: CalendarViewScrollPosition
  let animated: Bool
}

// MARK: - ScrollToItemContext.TargetItem

extension ScrollToItemContext {

  enum TargetItem {
    case month(Month)
    case day(Day)
  }

}

// MARK: - ScrollToItemContext.PositionRelativeToVisibleBounds

extension ScrollToItemContext {

  enum PositionRelativeToVisibleBounds {
    case before
    case after
    case partiallyOrFullyVisible(frame: CGRect)
  }

}
