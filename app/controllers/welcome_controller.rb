# frozen_string_literal: true

# Welcome controller
class WelcomeController < ApplicationController
  def index
    @name = "Henrique"

    @god_knowledge = "Batman"

    # after using http://127.0.0.1:3000/?god_velocity=Flash
    @god_velocity = params[:god_velocity] #=> Flash
  end
end
