class DeliveriesController < ApplicationController
  def index
    if current_user != nil
      matching_deliveries = Delivery.all

      @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })

      render({ :template => "deliveries/index" })
    else 
      redirect_to("/users/sign_up")
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show" })
  end

  def create
    the_delivery = Delivery.new
    the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.description = params.fetch("query_description")
    the_delivery.expected = params.fetch("query_expected")
    the_delivery.detail = params.fetch("query_details")
    the_delivery.received = false

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Added to list" })
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.user_id = params.fetch("query_user_id")
    the_delivery.description = params.fetch("query_description")
    the_delivery.expected = params.fetch("query_expected")
    the_delivery.detail = params.fetch("query_detail")
    the_delivery.received = params.fetch("query_received")

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries/#{the_delivery.id}", { :notice => "Delivery updated successfully."} )
    else
      redirect_to("/deliveries/#{the_delivery.id}", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def received
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.received = params.fetch("query_received")

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Delivery received."} )
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/deliveries", { :notice => "Delivery deleted successfully."} )
  end
end
