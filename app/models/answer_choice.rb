class AnswerChoice < ActiveRecord::Base
  validates :question_id, :text, :presence => true

  belongs_to(
  :question,
  class_name: "Question",
  foreign_key: "question_id"
  )

  has_many(
  :responses,
  class_name: "Response",
  foreign_key: "answer_choice_id"
  )
end