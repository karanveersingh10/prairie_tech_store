class PagesController < ApplicationController
  def about
    @page = AboutPage.first
  end

  def contact
    @page = ContactPage.first
  end
end
