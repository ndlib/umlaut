class ReferentValue < ActiveRecord::Base
  belongs_to :referent

  # Class method to normalize a string for normalized_value attribute. 
  # Right now normalization is just downcasing. Only
  # metadata values should be normalized (ie, not 'identifier' or 'format').
  # identifier and format shoudl be stored in normalized_value unchanged.
  def self.normalize(input)
      # 'chars' is neccesary for unicode.
      # normalized_value column only holds 254 bytes.. 
      return input.chars.downcase.to_s[0..254]
  end
  
end
