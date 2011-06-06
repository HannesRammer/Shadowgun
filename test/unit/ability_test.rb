require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Ability.new.valid?
  end
end
