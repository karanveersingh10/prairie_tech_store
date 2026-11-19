
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

    # Pagination
    @per_page = 6
    @total_products = @products.count
    @total_pages = [(@total_products.to_f / @per_page).ceil, 1].max

    requested_page = params[:page].to_i
    @current_page = [[requested_page, 1].max, @total_pages].min

    @products = @products
      .offset((@current_page - 1) * @per_page)
      .limit(@per_page)
  end

  def show
    @product = Product.find(params[:id])
  end
end
