module ApplicationHelper
  # Хелпер для отрисовки поля ввода текста,с заголовком и с сообщением об ошибке
  def text_input_field(form, field_name, subject, required: true, readonly: false, hint: '')
    li_class = required ? 'input required stringish' : 'input stringish'
    label_html = "#{subject.class.human_attribute_name(field_name)}#{input_field_required(required)}"
    content_tag(:li, class: li_class) do
      form.label(field_name, label_html.html_safe, class: 'label') +
        form.text_field(field_name, readonly: readonly) +
        print_hint(hint) +
        input_field_error(subject, field_name)
    end
  end

  def input_field_required(required)
    return '' unless required

    content_tag(:abbr, '*', title: 'required')
  end

  def print_hint(hint)
    return if hint.nil?
    return if hint == ''

    content_tag(:p, class: 'inline-hints') do
      hint
    end
  end

  def input_field_error(subject, field_name)
    return if subject.errors[field_name].empty?

    content_tag(:p, class: 'inline-errors') do
      subject.errors[field_name].join(', ')
    end
  end
end
