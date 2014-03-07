class PollsController < ApplicationController
	skip_before_action :authorize, only: [:index, :show, :vote]
	before_action :set_poll, only: [:show, :edit, :update, :destroy, :vote]
	skip_before_filter :verify_authenticity_token, :only => :vote

	def index
		if session[:user_id]
			@polls = Poll.all
		else
			@polls = Poll.active
		end
	end

	def show
	end

	def new
		@poll = Poll.new
		@numOfAnswers = 1
	end

	def create
		@poll = Poll.new(poll_params)

		respond_to do |format|
			if @poll.save
				format.html { redirect_to @poll, notice: 'Anketa je uspjesno kreirana.' }
				format.json { render action: 'show', status: :created, location: @poll }
			else
				format.html { render action: :new }
				format.json { render json: @poll.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@numOfAnswers = @poll.answers.size + 1
	end

	def update
		respond_to do |format|
			if @poll.update(poll_params)
				format.html { redirect_to @poll, notice: 'Anketa je uspjesno azurirana.' }
				format.json { head :no_content }
			else
				format.html { render action: :edit }
				format.json { render json: @poll.errors, status: :unprocessabble_entity }
			end
		end
	end

	def destroy
		@poll.destroy
		respond_to do |format|
			format.html { redirect_to polls_url }
			format.json { head :no_content }
		end
	end

	def destroy_multiple
		begin
			Poll.destroy(params[:polls])
			notice = "Ankete uspjesno obrisane."
		rescue
			notice = "Niste odabrali ni jednu anketu."
		end
		respond_to do |format|
			format.html { redirect_to polls_url, notice: notice }
			format.json { head :no_content }
		end
	end

	def vote
		id = params[:aid]
		begin
			@poll.vote(id)
			notice = "Uspjesno ste glasali."
			s = '{"success":1}'
		rescue
			notice = "Vas glas nazalost nije prihvacen."
			s = '{"success":0}'
		end
		json = JSON.parse(s)
		respond_to do |format|
			format.html { redirect_to @poll, notice: notice }
			format.json { render json: json }
		end
	end

	private
	def set_poll
		if session[:user_id]
			@poll = Poll.find(params[:id])
		else
			if Poll.find(params[:id]).visible
				@poll = Poll.find(params[:id])
			end
		end
	end

	def poll_params
		params.require(:poll).permit(:question, :visible,
			:answers_attributes => [:id,:text])
	end

end
