module Immutable
  extend ActiveSupport::Concern

  included do
    validate :force_immutable
  end

  private

  # Credit: https://tamouse.github.io/swaac/rails/2015/08/13/rails-immutable-records-and-attributes/
  def force_immutable
    if self.changed? && self.persisted?
      errors.add(:base, :immutable)
    end
  end
end