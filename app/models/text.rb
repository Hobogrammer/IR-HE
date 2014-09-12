class Text < ActiveRecord::Base

  belongs_to :users
  belongs_to :paragrphs
  has_many :words, :through => :paragrphs

  validates :user_id, presence: true
  validates :title, presence: true
  validates :language, presence: true

  def self.mecab_check(query)

    mecab = MeCab::Tagger.new
    processed = mecab.parseToNode(query)
    processed_array = Array.new
    begin
      processed = processed.next
      processed_array << processed.surface.force_encoding("UTF-8")
    end until processed.next.feature.include?("BOS/EOS")
    processed_array
  end

  def self.yahoo_mech(word)
    agent = Mechanize.new

    agent.get("http://dic.search.yahoo.co.jp/search?ei=UTF-8&p=#{word}&stype=prefix&fr=dic")
    definitions = agent.page.search("#DSm1 li").map(&:text)
  end
end
