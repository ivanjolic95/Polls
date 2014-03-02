class Poll < ActiveRecord::Base
	validates_presence_of :question

	has_many :answers

	scope :active, lambda { where(:visible => true) }
end
