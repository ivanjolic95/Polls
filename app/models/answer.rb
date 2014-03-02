class Answer < ActiveRecord::Base
	validates_presence_of :text

	belongs_to :poll

	before_save :set_value_to_zero

	def set_value_to_zero
		self.value = 0
	end
end
