class Text < ActiveRecord::Base

  belongs_to :user
  has_many :words

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :language, presence: true

  def self.mecab_check(query)

    mecab = MeCab::Tagger.new
    processed = mecab.parseToNode(query)
    processed_array = Array.new
    begin
      processed = processed.next
      processed_array << processed.surface.force_encoding("UTF-8")
    end until processed.next.feature.include?("BOS/EOS")
    return processed_array
  end

  def self.yahoo_mech(word)
    agent = Mechanize.new

    agent.get("http://dic.search.yahoo.co.jp/search?ei=UTF-8&p=#{word}&fr=dic&stype=prefix")
    definitions = agent.page.search("#DSm1 li").map(&:text)
  end
end
