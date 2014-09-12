class Paragraph < ActiveRecord::Base
  belongs_to :user
  belongs_to :text

  def self.process(text,content)
    content_array = content.split(/\n/)

    content_aray.each do |contents|
      text.paragraph.create(content: contents)
    end
    true
  end
end
