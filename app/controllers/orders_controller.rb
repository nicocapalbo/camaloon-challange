class OrdersController < ApplicationController
  def new
    @order = Order.new
    @bike = Bike.find(params[:bike])
    @customization = Customization.new
  end

  def create
    @order = current_user.orders.new(order_params)
    
    if @order.save
      prms = JSON.parse(option_params.to_json)
      prms.each_value { |value| Customization.create!(order: @order, option_id: value.to_i) }
      redirect_to order_path(@order)
    else
      render new
    end
  end

  private

  def order_params
    params.require(:order).permit(:bike_id)
  end

  def option_params
    params.require(:options)
  end
end
