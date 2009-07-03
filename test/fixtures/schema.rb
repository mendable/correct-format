ActiveRecord::Schema.define do
  create_table :foobars, :force => true do |t|
    t.string :upcase
    t.string :downcase
    t.string :capitalize
    t.string :capitalize_each
    t.string :email
  end
end
