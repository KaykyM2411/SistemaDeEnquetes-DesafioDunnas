class VotesController < ApplicationController
  before_action :require_login
  before_action :require_non_admin, only: [:create]
  before_action :set_poll
  before_action :set_option
  before_action :check_vote_permissions

  def create
    @vote = current_user.votes.new(poll: @poll, option: @option)

    if @vote.save
      redirect_to @poll, notice: 'Voto registrado com sucesso'
    else
      redirect_to @poll, alert: @vote.error.full_messages.join(', ')
    end
  end

  private
  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def set_option
    @option = Option.find(params[:option_id])
  end

  def check_vote_permissions
    unless @poll.open?
      redirect_to @poll, alert: 'A enquete esta fechada'
      return
    end

    if current_user.votes.exists?(poll_id: @poll.id)
      redirect_to @poll, alert: 'Você já votou nessa enquete'
      return
    end

    if @option.poll_id != @poll.id
      redirect_to @poll, alert: 'Resposta invalida para essa enquete'
    end
  end
end
