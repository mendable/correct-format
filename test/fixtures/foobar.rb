class Foobar < ActiveRecord::Base
  # For easy of use, here we have a single record that we 
  # can test against, with fields named the same as the 
  # the correct_format_{{***}} portion.
  correct_format_upcase :upcase
  correct_format_downcase :downcase
  correct_format_capitalize :capitalize
  correct_format_capitalize_each :capitalize_each
  correct_format_email :email
end
