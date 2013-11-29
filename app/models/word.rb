class Word < ActiveRecord::Base

  belongs_to :user

  validates :text_id, presence: true
  validates :term, presence: true
  validates :definition, presence: true
  validates :sentence, presence: true

end
