# CorrectFormat
module CorrectFormat
	def self.included(mod)
		mod.extend(ClassMethods)
	end
	
	module ClassMethods
		
		def correct_format_upcase(*args)
			args.each do |field|
				define_method("#{field}=") do |val|
					self[field.to_sym] = val ? val.upcase : val
				end
			end # args.each do field
		end # correct_format_upcase


		def correct_format_downcase(*args)
			args.each do |field|
				define_method("#{field}=") do |val|
					self[field.to_sym] = val ? val.downcase : val
				end
			end # args.each do field
		end # correct_format_downcase


		def correct_format_capitalize(*args)
			args.each do |field|
				define_method("#{field}=") do |val|
					self[field.to_sym] = val ? val.capitalize : val
				end
			end # args.each do field
		end # correct_format_capitalize


		def correct_format_capitalize_each(*args)
			args.each do |field|
				define_method("#{field}=") do |val|
					self[field.to_sym] = val ? val.downcase.split(/ /).collect{|f| f.capitalize}.join(" ") : val
				end
			end # args.each do field
		end # correct_format_capitalize_all

		
		# Special handler for email fields, downcases and also replaces "," with ".", a common 
		# typo mistake that will cause error to be raised.
		def correct_format_email(*args)
			args.each do |field|
				define_method("#{field}=") do |val|
					self[field.to_sym] = val ? val.downcase.gsub(",",".") : val
				end
			end # args.each do field
		end # correct_format_email

	end # ClassMethods
end # CorrectFormat

ActiveRecord::Base.send(:include, CorrectFormat)
