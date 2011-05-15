class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 8

  validates_presence_of :title, :body
  validates_uniqueness_of :title
  has_many :comments
  belongs_to :user
  belongs_to :category
  belongs_to :image
end
