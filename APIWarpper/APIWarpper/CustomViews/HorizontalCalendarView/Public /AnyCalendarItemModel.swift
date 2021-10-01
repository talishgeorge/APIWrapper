import UIKit

// MARK: - AnyCalendarItemModel

/// A type-erased calendar item model.
///
/// Useful for working with types conforming to `CalendarItemModel` without knowing the underlying concrete type.
public protocol AnyCalendarItemModel {

  /// A type that helps `ItemViewReuseManager` determine which views are compatible with one another and can therefore be
  /// recycled / reused.
  ///
  /// - Note: There is no reason to access this property from your feature code; it should only be accessed internally.
  var _itemViewDifferentiator: _CalendarItemViewDifferentiator { get }

  /// Builds an instance of `ViewType` by invoking its initializer with `invariantViewProperties`.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _makeView() -> UIView

  /// Updates the view model on an instance of `ViewType` by invoking `setViewModel`.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _setViewModel(onViewOfSameType view: UIView)

  /// Compares the view models of two `CalendarItemModel`s for equality.
  ///
  /// - Note: There is no reason to invoke this function from your feature code; it should only be invoked internally.
  func _isViewModel(equalToViewModelOf other: AnyCalendarItemModel) -> Bool

}

// MARK: - _CalendarItemViewDifferentiator

/// A type that helps `ItemViewReuseManager` determine which views are compatible with one another and can therefore be
/// recycled / reused.
///
/// - Note: There is no reason to create an instance of this enum from your feature code; it should only be invoked internally.
public enum _CalendarItemViewDifferentiator: Hashable {
  case viewRepresentable(
    viewRepresentableTypeDescription: String,
    viewTypeDescription: String,
    invariantViewProperties: AnyHashable)
  case legacyReuseIdentifier(String)
}
