class Poll < ActiveRecord::Base
	validates_presence_of :question

	has_many :answers
end
