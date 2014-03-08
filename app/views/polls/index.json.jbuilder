json.array!(@polls) do |poll|
	json.extract! poll, :id, :question, :visible, :answers, :number_of_votes?
	json.url poll_url(poll, format: json)
end