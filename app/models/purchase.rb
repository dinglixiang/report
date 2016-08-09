class Purchase < ApplicationRecord
  extend PurchaseCSVImporter

  class << self
    %w(name size company upstream_client).each do |field|
      define_method field.pluralize do
        distinct.pluck(field.to_sym)
      end
    end
  end
end
