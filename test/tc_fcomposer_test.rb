#   fcomposer - tc_fcomposer_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.

class FComposerTest < Test::Unit::TestCase  
  def test_fcomposer_is_a_module
    assert_equal Module, FComposer.class
  end
end
