
class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category).where(active: true)

    if params[:search].present?
      keyword = "%#{params[:search].strip}%"

      @products = @products.where(
        "products.name LIKE :keyword OR products.description LIKE :keyword OR products.brand LIKE :keyword",
        keyword: keyword
      )
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end
end
