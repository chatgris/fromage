# encoding: UTF-8
class RolesInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::FormTagHelper
  attr_accessor :output_buffer

  def input
    out = ''
    attribute_value = @builder.object.class.roles

    attribute_value.each_with_index do |a, i|
      input_html_options[:id] = "#{object_name}_#{attribute_name}_#{a}"
      input_html_options[:class] << "check_boxes"

      checked = @builder.object.send("#{a}?")

      out << label_tag(input_html_options[:id], class: 'checkbox') do
        check_box_tag("#{object_name}[#{attribute_name}][]", a, checked, input_html_options) + a
      end
    end
    out.html_safe
  end
end
