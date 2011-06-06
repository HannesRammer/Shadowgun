require 'test_helper'

class AbilityLevelTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AbilityLevel.new.valid?
  end
end
