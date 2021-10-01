import UIKit

enum InternalAnyCalendarItemModel {

  case itemModel(AnyCalendarItemModel)
  case legacy(AnyCalendarItem)

  var itemViewDifferentiator: _CalendarItemViewDifferentiator {
    switch self {
    case .itemModel(let itemModel):
      return itemModel._itemViewDifferentiator
    case .legacy(let legacyItem):
      return .legacyReuseIdentifier(legacyItem.reuseIdentifier)
    }
  }

  var makeView: () -> UIView {
    switch self {
    case .itemModel(let itemModel):
      return itemModel._makeView
    case .legacy(let legacyItem):
      return legacyItem.buildView
    }
  }

  var setViewModelOnViewOfSameType: (UIView) -> Void {
    switch self {
    case .itemModel(let itemModel):
      return itemModel._setViewModel(onViewOfSameType:)
    case .legacy(let legacyItem):
      return legacyItem.updateViewModel(view:)
    }
  }

  var updateHighlightState: ((UIView, Bool) -> Void)? {
    switch self {
    case .itemModel:
      return nil
    case .legacy(let legacyItem):
      return legacyItem.updateHighlightState(view:isHighlighted:)
    }
  }

  func isViewModelEqualToViewModelOfOther(_ other: Self) -> Bool {
    switch (self, other) {
    case let (.itemModel(lhsItemModel), .itemModel(rhsItemModel)):
      return lhsItemModel._isViewModel(equalToViewModelOf: rhsItemModel)
    case let (.legacy(lhsLegacyItem), .legacy(rhsLegacyItem)):
      return lhsLegacyItem.isViewModel(equalToViewModelOf: rhsLegacyItem)
    default:
      return false
    }
  }

}
