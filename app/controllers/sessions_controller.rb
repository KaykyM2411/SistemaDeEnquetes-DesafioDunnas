class SessionsController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def create
  user = User.find_by(email: params[:email])
  Rails.logger.info "User encontrado: #{user&.inspect}"
  
  if user
    auth_result = user.authenticate(params[:password])
    Rails.logger.info "Resultado autenticação: #{auth_result.inspect}"
  end

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    Rails.logger.info "SESSION SET: user_id = #{session[:user_id]}"
    Rails.logger.info "REDIRECIONANDO PARA ROOT_PATH"
    redirect_to root_path, notice: 'Login realizado com sucesso!'
    return 
  else
    Rails.logger.info "LOGIN FALHOU - Email ou senha inválidos"
    flash.now[:alert] = 'Email ou senha inválida'
    render :new
  end
end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logout realizado com sucesso'
  end
end
