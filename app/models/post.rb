class Post < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :content, :title, :tag, :visit_count
  validates :title, :presence=>true, :uniqueness=> true
  validates :content, :presence=>true, :length => { :minimum=> 30 }
  validates :tag, :presence=>true
  has_many :comments
  # :inclusion => { :in => [ TECH, LIFE, CREATOR ] }
  def content_html
    self.class.render_html(self.content)
  end

  def self.render_html(content)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
    md.render(content)
  end
 def sub_content
    HTML_Truncator.truncate(content_html, 300, length_in_chars: true)
  end
   def visited
    if self.visit_count==nil
        self.visit_count=0
    end
    self.visit_count += 1
    self.save
    self.visit_count
  end
end
