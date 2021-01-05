module Bootstrap
  class ModalComponent < ViewComponent::Base
    include BootstrapHelper

    with_content_areas :footer

    def initialize(title:, data: {})
      @title = title
      @data = data
    end

    private

    attr_reader :title, :data
  end
end
