class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true

  belongs_to(
  :answer_choice,
  class_name: "AnswerChoice",
  foreign_key: "answer_choice_id"
  )

  belongs_to(
  :respondent,
  class_name: "User",
  foreign_key: :user_id
  )

  has_one :question, :through => :answer_choices, :source => :questions

  def sibling_responses
    question.responses.where("responses.id != ?",self.id) if !self.id.nil?
  end

  def respondent_has_not_already_answered_question
    return false if self.sibling_responses.exists?(user_id: self.user_id)
    return true
  end
end