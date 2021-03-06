module ApplicationHelper
  def admin_controller? params
    params[:controller].split('/').first == "admin"
  end
  def filter_params ary, element
    if ary
      ary = ary.split(',')
      unless ary.delete(element)
        ary = (ary.split(',') << element).uniq
      end
      ary = ary.join(',')
    else
      ary = element
    end
    { categories: ary} if ary.present?
  end

  def disabled_filter? ary, filter
    unless ary.present? && ary.split(',').include?(filter)
      '-disabled'
    else
      ''
    end
  end

  def image_src_from ary, category
    asset_path("icons/#{ category.identifier + disabled_filter?(ary, category.slug) }-icon.png")
  end

  def is_active str, params
    str.split('/').first == params[:controller] && str.split('/').last == params[:action]
  end
end