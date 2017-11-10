module EmployeesHelper

  def flash_message(resource)
    resource.errors.map do |key, msg|
      content_tag :div, "#{key} #{msg}", :id => key, :class => 'flash'
    end.join.html_safe
  end

end
