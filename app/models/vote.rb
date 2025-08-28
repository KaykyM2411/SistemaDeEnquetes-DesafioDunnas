class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :poll
  belongs_to :option

  validates :user_id, uniqueness: { scope: :poll_id, message: 'Já votou nessa enquete' }
  validate :option_belong_to_poll

  private
  def option_belong_to_poll
    if option && option.poll_id != poll_id
      error.add(:option, 'A opçao nao pertence a essa enquete')
    end
  end
end
