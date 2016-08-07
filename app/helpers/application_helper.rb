module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.try(:to_sym)] || flash_type.to_s
  end

  def pagination_nums(result, per_page = Kaminari.config.default_per_page)
    "#{start_num(result, per_page)} - #{end_num(result, per_page)}"
  end

  def start_num(result, per_page)
    (result.current_page - 1)  *  per_page + 1
  end

  def end_num(result, per_page)
    if result.current_page == result.total_pages || result.total_pages.zero?
      result.total_count
    else
      result.current_page  * per_page
    end
  end
end
