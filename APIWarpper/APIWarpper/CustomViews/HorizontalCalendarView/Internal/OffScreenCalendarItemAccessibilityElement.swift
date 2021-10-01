import UIKit

// MARK: OffScreenCalendarItemAccessibilityElement

/// An accessibility element for an off-screen item that mirrors the accessibility traits and label of its corresponding item's view.
final class OffScreenCalendarItemAccessibilityElement: UIAccessibilityElement {

  // MARK: Lifecycle

  init?(correspondingItem: VisibleCalendarItem, scrollViewContainer: UIScrollView) {
    let view = correspondingItem.calendarItemModel.makeView()
    correspondingItem.calendarItemModel.setViewModelOnViewOfSameType(view)
    guard view.isAccessibilityElement else { return nil }

    self.correspondingItem = correspondingItem

    super.init(accessibilityContainer: scrollViewContainer)

    accessibilityTraits = view.accessibilityTraits
    accessibilityLabel = view.accessibilityLabel
  }

  // MARK: Internal

  let correspondingItem: VisibleCalendarItem

}
