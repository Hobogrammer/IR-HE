class Word < ActiveRecord::Base

  belongs_to :users
  belongs_to :texts

  validates :user_id, presence: true
  validates :text_id, presence: true
  validates :term, presence: true
  validates :definition, presence: true
  validates :sentence, presence: true

end
