class PollsController < ApplicationController

	before_action :set_poll, only: [:show, :edit, :update, :destroy]

	def new
		@poll = Poll.new
	end

	def create
		@poll = Poll.new(poll_params)
		if @poll.save
			redirect_to @poll, notice: 'Anketa je uspjesno kreirana.'
		else
			render action: :new
		end
	end

	def edit
	end

	def update
		if @poll.update(poll_params)
			redirect_to @poll, notice: 'Anketa je uspjesno azurirana.'
		else
			render action: :edit
		end
	end

	private
	def set_poll
		@poll = Poll.find(params[:id])
	end

	def poll_params
		params.require(:poll).permit(:question, :visible)
	end

end
