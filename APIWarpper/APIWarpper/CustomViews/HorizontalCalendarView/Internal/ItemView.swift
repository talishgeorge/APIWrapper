import UIKit

/// The container view for every visual item that can be displayed in the calendar.
final class ItemView: UIView {

  // MARK: Lifecycle

  init(initialCalendarItemModel: InternalAnyCalendarItemModel) {
    calendarItemModel = initialCalendarItemModel
    contentView = calendarItemModel.makeView()

    super.init(frame: .zero)

    contentView.insetsLayoutMarginsFromSafeArea = false
    addSubview(contentView)

    updateViewModel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let contentView: UIView

  var selectionHandler: (() -> Void)?

  var calendarItemModel: InternalAnyCalendarItemModel {
    didSet {
      guard calendarItemModel.itemViewDifferentiator == oldValue.itemViewDifferentiator else {
        preconditionFailure("""
          Cannot configure a reused `ItemView` with a calendar item model that was created with a
          different instance of invariant view properties.
        """)
      }

      // Only update the view model if it's different from the old one.
      guard !calendarItemModel.isViewModelEqualToViewModelOfOther(oldValue) else { return }

      updateViewModel()
    }
  }

  override class var layerClass: AnyClass {
    CATransformLayer.self
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.frame = bounds
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    if touches.first.map(isTouchInView(_:)) ?? false {
      selectionHandler?()
    }
  }

  // MARK: Private

  private func updateViewModel() {
    calendarItemModel.setViewModelOnViewOfSameType(contentView)
  }

  private func isTouchInView(_ touch: UITouch) -> Bool {
    contentView.bounds.contains(touch.location(in: contentView))
  }

}

// MARK: UIAccessibility

extension ItemView {

  override var isAccessibilityElement: Bool {
    get { false }
    set { }
  }

}
