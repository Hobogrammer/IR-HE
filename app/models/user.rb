class User < ActiveRecord::Base
  has_many :texts
  has_many :words, :through => :texts
  has_many :paragraphs, :through => :texts

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.avatar  = auth["info"]["image"]
    end
  end
end
