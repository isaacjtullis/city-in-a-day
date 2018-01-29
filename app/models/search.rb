class Search < ActiveRecord::Base

  def products
    @trails ||= find_products
  end

  private

  def find_products
    products = Trail.order(:name)
    products = products.where("name like ?", "%#{keywords}%") if keywords.present?
  end
end
