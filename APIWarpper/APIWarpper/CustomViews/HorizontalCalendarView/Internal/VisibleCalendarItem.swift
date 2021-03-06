import CoreGraphics

// MARK: - VisibleCalendarItem

/// Represents any visible item in the calendar, ranging from core layout items like month headers and days, to secondary items like
/// selection layer items and overlay layer items.
///
/// - Note: This is a reference type because it's heavily used in `Set`s, especially in the reuse manager. By making it a reference
/// type, we avoid `VisibleCalendarItem` `initializeWithCopy` when mutating the `Set`s. This type also caches its hash
/// value, which otherwise would be recomputed for every `Set` operation performed by the reuse manager. On an iPhone 6s, this
/// reduces CPU usage by nearly 10% when programmatically scrolling down at a rate of 500 points / frame.
final class VisibleCalendarItem {

  // MARK: Lifecycle

  init(calendarItemModel: InternalAnyCalendarItemModel, itemType: ItemType, frame: CGRect) {
    self.calendarItemModel = calendarItemModel
    self.itemType = itemType
    self.frame = frame

    var hasher = Hasher()
    hasher.combine(calendarItemModel.itemViewDifferentiator)
    hasher.combine(itemType)
    cachedHashValue = hasher.finalize()
  }

  // MARK: Internal

  let calendarItemModel: InternalAnyCalendarItemModel
  let itemType: ItemType
  let frame: CGRect

  // MARK: Private

  // Performance optimization - storing this separately speeds up the `Hashable` implementation,
  // which is frequently invoked by the `ItemViewReuseManager`'s `Set` operations.
  private let cachedHashValue: Int

}

// MARK: Equatable

extension VisibleCalendarItem: Equatable {

  static func == (lhs: VisibleCalendarItem, rhs: VisibleCalendarItem) -> Bool {
    lhs.calendarItemModel.itemViewDifferentiator == rhs.calendarItemModel.itemViewDifferentiator &&
      lhs.itemType == rhs.itemType
  }

}

// MARK: Hashable

extension VisibleCalendarItem: Hashable {

  func hash(into hasher: inout Hasher) {
    hasher.combine(cachedHashValue)
  }

}

// MARK: - VisibleCalendarItem.ItemType

extension VisibleCalendarItem {

  enum ItemType: Equatable, Hashable {
    case layoutItemType(LayoutItem.ItemType)
    case pinnedDayOfWeek(DayOfWeekPosition)
    case pinnedDaysOfWeekRowBackground
    case pinnedDaysOfWeekRowSeparator
    case daysOfWeekRowSeparator(Month)
    case dayRange(DayRange)
    case overlayItem(CalendarViewContent.OverlaidItemLocation)

    var zPosition: CGFloat {
      switch self {
      case .layoutItemType: return 500
      case .pinnedDayOfWeek: return 1000
      case .pinnedDaysOfWeekRowBackground: return 999
      case .pinnedDaysOfWeekRowSeparator: return 1001
      case .daysOfWeekRowSeparator: return 501
      case .dayRange: return 250
      case .overlayItem: return 750
      }
    }

    var isUserInteractionEnabled: Bool {
      switch self {
      case .layoutItemType: return true
      case .pinnedDayOfWeek: return true
      case .pinnedDaysOfWeekRowBackground: return true
      case .pinnedDaysOfWeekRowSeparator: return false
      case .daysOfWeekRowSeparator: return false
      case .dayRange: return false
      case .overlayItem: return false
      }
    }
  }

}
