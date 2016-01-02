class Importance < ActiveRecord::Base

  VALUES = %i[critical important suggestion]

  class << self
    VALUES.each do |v|
      define_method v.to_sym do
        find_by(value: v)
      end
    end
  end
end
