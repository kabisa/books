module Search
  class Form < ViewComponent::Base
    include Ransack::Helpers::FormHelper
    include BootstrapHelper

    def initialize(q:)
      @q = q
    end

    private

    attr_reader :q
  end

end
