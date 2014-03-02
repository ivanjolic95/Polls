class Poll < ActiveRecord::Base
	validates_presence_of :question

	has_many :answers, :dependent => :delete_all

	scope :active, lambda { where(:visible => true) }
end
