import UIKit

// MARK: - MonthHeaderView

/// A view that represents a day-of-the-week header in a calendar month. For example, Sun, Mon, Tue, etc.
public final class MonthHeaderView: UIView {

  // MARK: Lifecycle

  public init(invariantViewProperties: InvariantViewProperties) {
    self.invariantViewProperties = invariantViewProperties

    label = UILabel()
    label.font = invariantViewProperties.font
    label.textAlignment = invariantViewProperties.textAlignment
    label.textColor = invariantViewProperties.textColor

    super.init(frame: .zero)

    isUserInteractionEnabled = false

    backgroundColor = invariantViewProperties.backgroundColor

    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    let edgeInsets = invariantViewProperties.edgeInsets
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.leading),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInsets.trailing),
    ])
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Fileprivate

  fileprivate func setViewModel(_ viewModel: ViewModel) {
    label.text = viewModel.monthText
    accessibilityLabel = viewModel.accessibilityLabel
  }

  // MARK: Private

  private let invariantViewProperties: InvariantViewProperties
  private let label: UILabel

}

// MARK: Accessibility

extension MonthHeaderView {

  public override var isAccessibilityElement: Bool {
    get { true }
    set { }
  }

  public override var accessibilityTraits: UIAccessibilityTraits {
    get { invariantViewProperties.accessibilityTraits }
    set { }
  }

}

// MARK: - DayView.ViewModel

extension MonthHeaderView {

  /// Encapsulates the data used to populate a `MonthHeaderView`'s text label. Use a `DateFormatter` to create the
  /// `monthText` and `accessibilityLabel` strings.
  ///
  /// - Note: To avoid performance issues, reuse the same `DateFormatter` for each month, rather than creating
  /// a new `DateFormatter` for each month.
  public struct ViewModel: Equatable {

    // MARK: Lifecycle

    public init(monthText: String, accessibilityLabel: String?) {
      self.monthText = monthText
      self.accessibilityLabel = accessibilityLabel
    }

    // MARK: Public

    public let monthText: String
    public let accessibilityLabel: String?
  }

}

// MARK: - MonthHeaderView.InvariantViewProperties

extension MonthHeaderView {

  /// Encapsulates configurable properties that change the appearance and behavior of `MonthHeaderView`. These cannot be
  /// changed after a `MonthHeaderView` is initialized.
  public struct InvariantViewProperties: Hashable {

    // MARK: Lifecycle

    //init() { }
//    public init(backgroundColor: UIColor) {
//      self.backgroundColor = backgroundColor
//    }
    // MARK: Public

    //public static let base = InvariantViewProperties()

    /// The background color of the entire view, unaffected by `edgeInsets`.
    public var backgroundColor = UIColor.clear

    /// Edge insets that change the position of the month's label.
    public var edgeInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: -10, trailing: 0)//NSDirectionalEdgeInsets.zero

    /// The font of the month's label.
    public var font = UIFont.systemFont(ofSize: 22)

    /// The text alignment of the month's label.
    public var textAlignment = NSTextAlignment.center

    /// The text color of the month's label.
    public var textColor: UIColor = {
      if #available(iOS 13.0, *) {
        return .white
      } else {
        return .black
      }
    }()

    /// The accessibility traits of the `MonthHeaderView`.
    public var accessibilityTraits = UIAccessibilityTraits.header

  }

}

// MARK: - MonthHeaderView + CalendarItemViewRepresentable

extension MonthHeaderView: CalendarItemViewRepresentable {

  public static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> MonthHeaderView
  {
    MonthHeaderView(invariantViewProperties: invariantViewProperties)
  }

  public static func setViewModel(_ viewModel: ViewModel, on view: MonthHeaderView) {
    view.setViewModel(viewModel)
  }

}
