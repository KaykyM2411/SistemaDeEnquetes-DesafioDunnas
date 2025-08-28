class PollsController < ApplicationController
  before_action :set_poll, only: [:edit, :update, :show, :destroy, :close]
  before_action :require_login, only: [:create, :update, :new, :destroy, :close, :edit]
  before_action :require_non_admin, only: [:create]

  def index
    @polls = Poll.where(status: 'open').order(created_at: :desc)
  end

  def new
    @poll = current_user.polls.new
    3.times { @poll.options.build }
  end

  def create
    @poll = current_user.polls.new(poll_params)
    if @poll.save
      redirect_to @poll, notice: 'Enquete criada com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # código para mostrar enquete
  end

  def edit
  @poll.options.build if @poll.options.empty?
  end

  def update
    if @poll.update(poll_params)
      redirect_to @poll, notice: 'Enquete atualizada com sucesso'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @poll.destroy
    redirect_to polls_path, notice: 'Enquete excluída com sucesso'
  end

  def close
    if current_user == @poll.user
      @poll.closed!
      redirect_to @poll, notice: 'Enquete fechada com sucesso'
    else
      redirect_to @poll, alert: 'Apenas o dono pode fechar a enquete'
    end
  end

  def my_polls
    @polls = current_user.polls.order(created_at: :desc)
  end

  def voted_polls
    @polls = current_user.voted_polls.distinct.order(created_at: :desc)
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(
    :question, :poll_type,
    options_attributes: [:id, :content, :_destroy]
  )
  end
end