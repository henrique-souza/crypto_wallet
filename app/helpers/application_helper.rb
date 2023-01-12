# frozen_string_literal: true

# Application Helper for Crypto Wallet
module ApplicationHelper
  def brazilian_date(us_date)
    us_date.strftime('%d/%m/%Y')
  end
end
