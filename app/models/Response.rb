class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question

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

  has_one :question, :through => :answer_choice, :source => :question

  def sibling_responses
    if !self.id.nil?
      question.responses.where("responses.id != ?",self.id)
    else
      question.responses
    end
  end

  def respondent_has_not_already_answered_question
    if self.sibling_responses.exists?(user_id: self.user_id)
      errors[:base] << "respondent has already answered question"
    end
  end
end