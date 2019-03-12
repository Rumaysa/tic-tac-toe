# frozen_string_literal: true

class Board < Array
  def initialize(width:)
    size = width * width

    size.times { push(nil) }
  end
end
