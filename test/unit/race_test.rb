require 'test_helper'

class RaceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Race.new.valid?
  end
end
