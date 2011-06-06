require 'test_helper'

class CharacterToPathTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CharacterToPath.new.valid?
  end
end
