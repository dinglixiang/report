class Stock < ApplicationRecord
  belongs_to :user
  extend StockCSVImporter

  class << self
    %w(name).each do |field|
      define_method field.pluralize do
        distinct.pluck(field.to_sym)
      end
    end
  end
end
