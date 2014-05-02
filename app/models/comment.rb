class Comment < ActiveRecord::Base
  attr_accessible :content, :name, :post_id, :user_id
  validates :content, :presence=>true, :length => { :minimum=> 10 }
  belongs_to :post
  belongs_to :user
    def content_html
    self.class.render_html(self.content)
  end

  def self.render_html(content)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
    md.render(content)
  end
   def k_render(content)
	kramdown::Document.new(content).to_html
   end
end
