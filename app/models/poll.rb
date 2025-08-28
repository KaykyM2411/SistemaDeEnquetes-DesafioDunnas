class Poll < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :votes, through: :options

  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  enum :poll_type, { single: 'single', multiple: 'multiple' }
  enum :status, { open: 'open', closed: 'closed' }

  validates :question, presence: true
  validates :poll_type, presence: true
  validates :status, presence: true

  before_validation :set_default_status, on: :create


  def results
    options.joins(:votes)
           .group('options.id', 'options.content')
           .count('votes.id')
  end

  def voted_by? (user)
    votes.exists?(user: user)
  end

  def total_votes
    options.sum { |option| option.votes.count }
  end

  private
  def set_default_status
    self.status ||= 'open'
  end
end