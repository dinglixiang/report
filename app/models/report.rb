class Report < ApplicationRecord
  extend CSVImporter

  class << self
    %w(name size company target_company unit).each do |field|
      define_method field.pluralize do
        distinct.pluck(field.to_sym)
      end
    end
  end
end
