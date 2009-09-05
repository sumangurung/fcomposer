#   fcomposer - tc_scale_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   This program is free software.
#   You can distribute/modify this program under the terms of
#   the GNU Lesser General Public License version 2.
#
#
#   To understand the nomenclature of this code please head to http://en.wikipedia.org/wiki/Note

class ScaleTest < Test::Unit::TestCase

  def test_scale_creation_default_values_are_c_major
    scale = FComposer::Scale.new
    assert_equal "C Major", scale.name
    assert_equal 7, scale.size
    assert_equal [ "C", "D", "E", "F", "G","A","B" ], scale.pitchs
  end

end
