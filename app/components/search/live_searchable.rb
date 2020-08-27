module Search
  module LiveSearchable
    private

    def live_search?
      @live_search
    end

    def decorate_dataset(dataset = {})
      return dataset unless live_search? && dataset.has_key?(:action)

      dataset[:action] << ' search#perform'

      dataset
    end
  end
end
