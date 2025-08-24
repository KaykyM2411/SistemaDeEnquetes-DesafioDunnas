class Poll < ApplicationRecord
  belongs_to :user
  has_many :option, dependent: :destroy
  has_many :votes, through: :option

  enum poll_type: {single: 'single', multiple: 'multiple' }
  enum status: {open: 'open', closed: 'closed'}

  validate :question, presence:true
  validate :poll_type, presence:true
  validate :status, presence: true

  def results
    option.join(:votes)
    .group('option_id', 'option_content')
    .count('votes_id')
  end
end
