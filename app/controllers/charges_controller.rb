class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "BigMoney Membership - #{current_user.name}",
    amount: 1500
 }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 1500,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for your payment of $15 #{current_user.email}."
    current_user.update_attribute(:role, 1)
    redirect_to wikis_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    current_user.update_attribute(:role, 0)
    Wiki.set_to_public_wikis(current_user)
    redirect_to wikis_path
  end
end
