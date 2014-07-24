class Question < ActiveRecord::Base
  validates :poll_id, :text, :presence => true

  has_many(
  :answer_choices,
  class_name: "AnswerChoice",
  foreign_key: "question_id"
  )

  belongs_to(
  :poll,
  class_name: "Poll",
  foreign_key: "poll_id"
  )

  has_many :responses, :through => :answer_choices, :source => :responses

  def results
    results = {}
    self.answer_choices.includes(:responses).each do |answer_choice|
      results[answer_choice] = answer_choice.responses.length
    end
    results
  end

  def sql_results
    results = <<-SQL
    SELECT answer_choices.*, COUNT(responses)
    FROM answer_choices JOIN responses
    ON answer_choices.id = responses.answer_choice_id
    GROUP BY answer_choices
    SQL
    results
  end
end