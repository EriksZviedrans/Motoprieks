class Image < ActiveRecord::Base
  validates_presence_of :description
  has_many :posts

  def image_file=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = input_data.read
  end
end
