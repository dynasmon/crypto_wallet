class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Nathan Menezes [COOKIE]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
