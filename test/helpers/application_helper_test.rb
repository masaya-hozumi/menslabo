
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "MEN'S Labo"
    assert_equal full_title("Help"), "Help | MEN'S Labo"
  end
end
