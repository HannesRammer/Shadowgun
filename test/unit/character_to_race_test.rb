require 'test_helper'

class CharacterToRaceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CharacterToRace.new.valid?
  end
end
