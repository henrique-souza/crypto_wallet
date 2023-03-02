# frozen_string_literal: true

# Welcome controller
class WelcomeController < ApplicationController
  def index
    @name = "Henrique"

    @batman = "Batman"

    # after using http://127.0.0.1:3000/?god_speed=Flash
    @flash = params[:god_speed] #=> Flash

    @hal_jordan = params[:god_light] #=> Hal Jordan
  end
end
