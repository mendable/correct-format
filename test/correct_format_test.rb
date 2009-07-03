require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class CorrectFormatTest < Test::Unit::TestCase 

  require File.expand_path(File.join(File.dirname(__FILE__), '/fixtures/foobar.rb'))

  def setup
    @record = Foobar.new
  end
 
  def test_correct_format_upcase
    test_array = []
    test_array << {:before => "FOOBAR", :after => "FOOBAR"}
    test_array << {:before => "foobar", :after => "FOOBAR"}
    test_array << {:before => "FOObar", :after => "FOOBAR"}
    test_array << {:before => "@@12!!£&*adfa$$--++=", :after => "@@12!!£&*ADFA$$--++="}
    test_array << {:before => "Words and Spaces", :after => "WORDS AND SPACES"}

    before_and_after(@record, "upcase", test_array)
  end


  def test_correct_format_downcase 
    test_array = []
    test_array << {:before => "foobar", :after => "foobar"}
    test_array << {:before => "FOOBAR", :after => "foobar"}
    test_array << {:before => "FOObar", :after => "foobar"}
    test_array << {:before => "!!@-other-CHArs-in-string@+4$", :after => "!!@-other-chars-in-string@+4$"}
    test_array << {:before => "Words and Spaces", :after => "words and spaces"}

    before_and_after(@record, "downcase", test_array)
  end


  def test_correct_format_capitalize
    test_array = []
    test_array << {:before => "foobar", :after => "Foobar"}
    test_array << {:before => "FOOBAR", :after => "Foobar"}
    test_array << {:before => "FOObar", :after => "Foobar"}
    # note: seen as single word, first letter (!) cannot be capitalized, remainder should be downcased
    test_array << {:before => "!!@-other-CHars-in-string@+4$", :after => "!!@-other-chars-in-string@+4$"} 
    # "S" in "Spaces" downcased, but first letter of first word must be capitalized
    test_array << {:before => "Words and Spaces", :after => "Words and spaces"}
    # first letter of first word must be capitalised, everything else downcased
    test_array << {:before => "words AND spaces", :after => "Words and spaces"}
    
    before_and_after(@record, "capitalize", test_array)
  end

  
  def test_correct_format_capitalize_each
    test_array = []
    test_array << {:before => "foobar", :after => "Foobar"}
    test_array << {:before => "FOOBAR", :after => "Foobar"}
    test_array << {:before => "FOObar", :after => "Foobar"}
    test_array << {:before => "!!@foobar@$$!", :after => "!!@foobar@$$!"}
    test_array << {:before => "Words and Spaces", :after => "Words And Spaces"}
    # lowercased, and first letter of EVERY word capitalized
    test_array << {:before => "words AND spaces", :after => "Words And Spaces"}
 
    before_and_after(@record, "capitalize_each", test_array)
  end


  def test_correct_format_email
    test_array = []
    test_array << {:before => "foobar@example.com", :after => "foobar@example.com"}
    test_array << {:before => "FOOBAR@EXAMPLE.com", :after => "foobar@example.com"} #should lowercase everything
    test_array << {:before => "FOObar@EXAmple.com", :after => "foobar@example.com"}
    test_array << {:before => "foobar@example,co,uk", :after => "foobar@example.co.uk"}
    
    before_and_after(@record, "email", test_array)
  end


  private
    # pass a hash of key-value pairs into this
    def before_and_after(rec, field, values = [])
      
      values.each do |row|
        rec.send("#{field}=", row[:before])
        assert_equal row[:after], rec.send(field), "Should have transformed '#{row[:before]}' to '#{row[:after]}'"
      end
      
    end
  

end
