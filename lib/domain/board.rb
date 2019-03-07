# frozen_string_literal: true

class Board < Array
  def initialize(size:)
    size.times { push(nil) }
  end
end