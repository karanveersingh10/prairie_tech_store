class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @products = Product.where(id: @cart.keys)
    @cart_items = @products.map do |product|
      {
        product: product,
        quantity: @cart[product.id.to_s].to_i
      }
    end
    @subtotal = @cart_items.sum do |item|
      item[:product].current_price * item[:quantity]
    end
  end

  def add
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    if !product.active? || product.stock_quantity < 1
      redirect_to product_path(product), alert: "This product is unavailable."
      return
    end

    current_quantity = @cart[product.id.to_s].to_i
    new_quantity = current_quantity + quantity

    if new_quantity > product.stock_quantity
      redirect_to product_path(product), alert: "Not enough stock available."
      return
    end

    @cart[product.id.to_s] = new_quantity
    session[:cart] = @cart

    redirect_to cart_path, notice: "#{product.name} added to your cart!"
  end

  def update
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity <= 0
      @cart.delete(product.id.to_s)
      flash[:notice] = "Product removed from cart."
    elsif quantity > product.stock_quantity
      flash[:alert] = "Only #{product.stock_quantity} available."
    else
      @cart[product.id.to_s] = quantity
      flash[:notice] = "Cart updated."
    end

    session[:cart] = @cart
    redirect_to cart_path
  end

  def remove
    @cart.delete(params[:product_id].to_s)
    session[:cart] = @cart
    redirect_to cart_path, notice: "Product removed from cart."
  end

  def clear
    session[:cart] = {}
    redirect_to cart_path, notice: "Your cart is empty."
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= {}
  end
end
