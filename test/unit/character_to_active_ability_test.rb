require 'test_helper'

class CharacterToActiveAbilityTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CharacterToActiveAbility.new.valid?
  end
end
