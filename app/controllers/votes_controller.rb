class VotesController < ApplicationController
  before_action :require_login
  before_action :set_poll
  before_action :set_option, only: [:create]
  before_action :check_vote_permissions, only: [:create]
  
  def create
    @vote = current_user.votes.new(poll: @poll, option: @option)
    
    if @vote.save
      redirect_to @poll, notice: 'Voto registrado com sucesso'
    else
      redirect_to @poll, alert: 'O voto não pôde ser registrado. Por favor, tente novamente.'
    end
  end

  private
  def set_poll
    @poll = Poll.find_by(id: params[:poll_id])
    unless @poll
      redirect_to root_path, alert: "Enquete não encontrada."
    end
  end
  
  def set_option
    unless params[:vote] && params[:vote][:option_id].present? && params[:vote][:option_id].to_i > 0
      redirect_to @poll, alert: 'Por favor, selecione uma opção para votar.'
      return
    end

    @option = Option.find_by(id: params[:vote][:option_id])
    unless @option
      redirect_to @poll, alert: "Opção de voto não encontrada."
      return
    end
  end
  
  def check_vote_permissions
    unless @poll.open?
      redirect_to @poll, alert: 'A enquete está fechada.'
      return
    end
    
    if current_user.votes.exists?(poll_id: @poll.id)
      redirect_to @poll, alert: 'Você já votou nessa enquete.'
      return
    end
  end
end