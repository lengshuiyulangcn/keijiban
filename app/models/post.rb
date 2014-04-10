class Post < ActiveRecord::Base
  attr_accessible :content, :title, :type, :visit_count
  validates :title, :presence=>true, :uniqueness=> true
  validates :content, :presence=>true, :length => { :minimum=> 30 }
  validates :type, :presence=>true
  # :inclusion => { :in => [ TECH, LIFE, CREATOR ] }

end
