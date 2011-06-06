require 'test_helper'

class QuestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Quest.new.valid?
  end
end
