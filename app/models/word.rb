class Word < ActiveRecord::Base
  belongs_to :user
  belongs_to :text

  validates :text_id, presence: true
  validates :term, presence: true
  validates :definition, presence: true
  validates :sentence, presence: true

end
