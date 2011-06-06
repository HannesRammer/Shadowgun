require 'test_helper'

class CharacterToVocationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CharacterToVocation.new.valid?
  end
end
