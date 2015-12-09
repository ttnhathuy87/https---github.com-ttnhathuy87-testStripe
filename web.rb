require 'sinatra'
require 'stripe'
require 'dotenv'

Dotenv.load

Stripe.api_key = ENV['sk_test_xUpT6Ptp06OqDCYVxFVOu1hz']

get '/' do
  status 200
  return "Great, your backend is set up. Now you can configure the Stripe example iOS apps to point here."
end

post '/charge' do

  # Get the credit card details submitted by the form
  token = params[:stripeToken]

  # Create the charge on Stripe's servers - this will charge the user's card
  begin
   charge = Stripe::Charge.create({
        :amount => 100,
        :source => token,
        :description => "Example Charge",
        :currency => "usd"
      })
   #Stripe::Charge.create({
   #   :amount => params[:amount], # this number should be in cents
   #   :currency => "usd",
    #  :card => token,
   #   :description => "Example Charge"}
   # )
  rescue Stripe::CardError => e
    status 402
    return "Error creating charge."
  end

  status 200
  return "Order successfully created"

end
