# See: https://gist.github.com/maxivak/57a2fb71afeb9efcf771
module ButtonComponents
  # @example
  #   = f.button :submit_cancel
  #   = f.button :submit_cancel, 'Save'
  #   = f.button :submit_cancel, cancel: posts_path
  #   = f.button :submit_cancel, 'Save', cancel: posts_path
  def submit_cancel(*args, &block)
    template.content_tag :div, class: 'form-actions' do
      options = args.extract_options!
      options[:class] = [options[:class], 'btn-primary'].compact
      args << options

      # with cancel link
      if cancel = options.delete(:cancel)
        submit(*args, &block) + '&nbsp;&nbsp;'.html_safe + template.link_to(I18n.t('simple_form.buttons.cancel'), cancel, class: 'btn btn-outline', role: :button)
      else
        submit(*args, &block)
      end
    end
  end
end

SimpleForm::FormBuilder.include(ButtonComponents)
