# frozen_string_literal: true
module ArraySupport
  def is_two_arrays_have_same_elements(array_1, array_2)
    array_1.difference(array_2).empty? && array_2.difference(array_1).empty?
  end
end

RSpec.configure do |config|
  config.include(ArraySupport)
end
