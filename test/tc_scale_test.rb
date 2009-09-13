#   fcomposer - tc_scale_test.rb
#
#   Copyright (c) 2009 Francisco Tufró <contacto@franciscotufro.com.ar>
#
#   See LICENCE in the root directory.

class ScaleTest < Test::Unit::TestCase

  def test_scale_creation_default_values_are_c_major
    scale = FComposer::Scale.new
    assert_equal "C Major", scale.name
    assert_equal 7, scale.size
    assert_equal [ "C", "D", "E", "F", "G","A","B" ], scale.pitches
  end

  def test_scale_creation_with_custom_scale
    scale = FComposer::Scale.new(:name => "Hungarian Minor in A", :pitches => ["A", "B", "C", "Ds", "E", "F", "Gs"])
    assert_equal "Hungarian Minor in A", scale.name
    assert_equal 7, scale.size
    assert_equal ["A", "B", "C", "Ds", "E", "F", "Gs"], scale.pitches
  end

  def test_scale_creation_with_name_only
    scale = FComposer::Scale.new(:name => "D Major")
    assert_equal "D Major", scale.name
    assert_equal 7, scale.size
    assert_equal [ "D", "E", "Fs", "G","A", "B", "Cs" ], scale.pitches

    scale = FComposer::Scale.new(:name => "D Major", :pitches => ["C"])
    assert_equal "D Major", scale.name
    assert_not_equal 7, scale.size
    assert_not_equal [ "D", "E", "Fs", "G","A", "B", "Cs" ], scale.pitches

  end

  def test_scale_from_name
    scale = FComposer::Scale.new
    scale.set_scale_from_name("B Major")
    assert_equal "B Major", scale.name
    assert_equal 7, scale.size
    assert_equal [ "B", "Cs", "Ds", "E", "Fs", "Gs","As" ], scale.pitches
  end

  def test_scale_major
    scale = FComposer::Scale.new
    scale.set_scale_from_name("B Major")
    assert_equal "B Major", scale.name
    assert_equal 7, scale.size
    assert_equal [ "B", "Cs", "Ds", "E", "Fs", "Gs","As" ], scale.pitches
  end

  def test_scale_natural_minor
    scale = FComposer::Scale.new
    scale.set_scale_from_name("A Natural Minor")
    assert_equal "A Natural Minor", scale.name
    assert_equal 7, scale.size
    assert_equal [ "A", "B", "C", "D", "E", "F", "G" ], scale.pitches
  end

  def test_scale_harmonic_minor
    scale = FComposer::Scale.new
    scale.set_scale_from_name("A Harmonic Minor")
    assert_equal "A Harmonic Minor", scale.name
    assert_equal 7, scale.size
    assert_equal [ "A", "B", "C", "D", "E", "F", "Gs" ], scale.pitches
  end

  def test_scale_hungarian_minor
    scale = FComposer::Scale.new
    scale.set_scale_from_name("A Hungarian Minor")
    assert_equal "A Hungarian Minor", scale.name
    assert_equal 7, scale.size
    assert_equal [ "A", "B", "C", "Ds", "E", "F", "Gs" ], scale.pitches
  end

  def test_scale_hungarian_minor
    scale = FComposer::Scale.new
    scale.set_scale_from_name("C Gypsy Minor")
    assert_equal "C Gypsy Minor", scale.name
    assert_equal 7, scale.size
    assert_equal [ "C", "D", "Ds", "Fs", "G", "Gs", "As" ], scale.pitches
  end

  def test_add_scale
    FComposer::Scale.add_scale(:name => "Chromatic", :intervals => [1,1,1,1,1,1,1,1,1,1,1])
    c_scale = FComposer::Scale.new(:name => "C Chromatic")
    assert_equal 12, c_scale.size
    assert_equal [ "C","Cs","D","Ds","E","F","Fs","G","Gs","A","As","B"], c_scale.pitches
  end  
end
