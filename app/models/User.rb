class User < ActiveRecord::Base
  validates :user_name, :presence => true, :uniqueness => true

  has_many(
  :authored_polls,
  class_name: "Poll",
  foreign_key: "author_id"
  )

  has_many(
  :responses,
  class_name: "Response",
  foreign_key: "user_id"
  )

  def completed_polls
    completed_polls = <<-SQL
    SELECT polls.*,COUNT(questions.id)
    FROM polls JOIN questions ON poll.id = questions.poll_id

    (SELECT responses.* FROM responses
      JOIN users ON responses.user_id = user.id
    GROUP BY polls
    SQL
    completed_polls
  end
end