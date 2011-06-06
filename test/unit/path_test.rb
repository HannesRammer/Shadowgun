require 'test_helper'

class PathTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Path.new.valid?
  end
end
