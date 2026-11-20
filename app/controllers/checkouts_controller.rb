class CheckoutsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)
    redirect_to cart_path, alert: "Your cart is empty." if @products.empty?
    @subtotal = @products.sum { |p| p.current_price * @cart[p.id.to_s].to_i }
    @tax = (@subtotal * BigDecimal("0.12")).round(2)
    @total = @subtotal + @tax
  end

  def create
    cart = session[:cart] || {}
    products = Product.where(id: cart.keys)

    if products.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    subtotal = products.sum { |p| p.current_price * cart[p.id.to_s].to_i }
    tax = (subtotal * BigDecimal("0.12")).round(2)

    Order.transaction do
      @order = Order.create!(
        customer_name: params[:customer_name],
        email: params[:email],
        address: params[:address],
        city: params[:city],
        province: params[:province],
        postal_code: params[:postal_code],
        subtotal: subtotal,
        tax: tax,
        total: subtotal + tax,
        status: "pending",
        customer: (customer_signed_in? ? current_customer : nil)
      )

      products.each do |product|
        quantity = cart[product.id.to_s].to_i
        raise "Insufficient stock for #{product.name}" if quantity < 1 || quantity > product.stock_quantity

        @order.order_items.create!(
          product: product,
          quantity: quantity,
          unit_price: product.current_price
        )

        product.update!(stock_quantity: product.stock_quantity - quantity)
      end
    end

    session[:cart] = {}
    redirect_to order_path(@order), notice: "Your order was placed successfully!"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to checkout_path, alert: e.message
  rescue RuntimeError => e
    redirect_to checkout_path, alert: e.message
  end
end
