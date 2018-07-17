module Helpers
  # rubocop:disable Naming/AccessorMethodName
  def set_viewer(viewer)
    Discretion.set_current_viewer(viewer)
  end
  # rubocop:enable Naming/AccessorMethodName

  def pretend_not_test_in_discretion
    allow(Discretion).to receive(:in_test?).and_return(false)
  end
end
