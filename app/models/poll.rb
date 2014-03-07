class Poll < ActiveRecord::Base
	validates_presence_of :question

	has_many :answers, :dependent => :delete_all

	accepts_nested_attributes_for :answers

	scope :active, lambda { where(:visible => true) }

	def vote(answer_id)
		a = self.answers.where(:id => answer_id)[0]
		a.value += 1;
		a.save
	end
end
