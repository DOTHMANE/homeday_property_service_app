class ApplicationController < ActionController::API
  include Pagy::Backend

  private

  def pagy_metadata(pagy)
    {
      current_page: pagy.page,
      total_pages: pagy.pages,
      total_count: pagy.count,
      per_page: pagy.limit,
      next_page: pagy.next,
      prev_page: pagy.prev
    }
  end
end
