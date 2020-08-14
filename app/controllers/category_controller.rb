class CategoryController < ApplicationController
  @parents = Category.where(ancestry: nil)
end
