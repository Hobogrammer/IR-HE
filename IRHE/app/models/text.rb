class Text < ActiveRecord::Base

  belongs_to :user
  has_many :words

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :language, presence: true
end
