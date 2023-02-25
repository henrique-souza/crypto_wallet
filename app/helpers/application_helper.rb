# frozen_string_literal: true

# Application Helper for Crypto Wallet
module ApplicationHelper
  def brazilian_date(us_date)
    us_date.strftime("%d/%m/%Y")
  end

  def ambiente_rails
    # if Rails.env.development?
    #   "Desenvolvimento"
    # elsif Rails.env.test?
    #   "Teste"
    # else
    #   "Produção"
    # end

    # Reduzindo as linhas acima para operação ternária
    if Rails.env.development?
      "Desenvolvimento"
    else
      Rails.env.test? ? "Teste" : "Produção"
    end
  end
end
